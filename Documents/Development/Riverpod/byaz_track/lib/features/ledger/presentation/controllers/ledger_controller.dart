import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:byaz_track/core/db/database_helper.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/create_loan/data/model/loan_model.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:byaz_track/features/ledger/data/source/ledger_remote_source.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LedgerController extends GetxController {
  LedgerController({required this.remoteSource});
  final LedgerRemoteSource remoteSource;

  final RxList<LoanModel> loans = <LoanModel>[].obs;
  Timer? _debounce;

  Rx<TheStates> fetchLoanState = TheStates.initial.obs;
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  void onInit() {
    super.onInit();
    fetchLoans();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }

  Future<void> fetchLoans() async {
    try {
      fetchLoanState.value = TheStates.loading;
      final db = await DatabaseHelper.instance.database;
      final data = await db.query(
        'loans',
        where: 'is_deleted = 0',
        orderBy: 'created_at DESC',
      );

      loans.value = data.map((json) => LoanModel.fromMap(json)).toList();
      fetchLoanState.value = TheStates.success;
    } catch (e) {
      debugPrint('Error fetching loans: $e');
      fetchLoanState.value = TheStates.error;
    }
  }

  Future<void> syncPendingLoans() async {
    try {
      final db = await DatabaseHelper.instance.database;
      final pendingLoans = await db.query(
        'loans',
        where: 'sync_status = ?',
        whereArgs: ['pending'],
      );

      if (pendingLoans.isEmpty) {
        debugPrint('No pending loans to sync.');
        return;
      }

      final supabase = Supabase.instance.client;

      for (final loanJson in pendingLoans) {
        final loanMap = Map<String, dynamic>.from(loanJson);
        loanMap.remove('sync_status');

        await supabase.from('loans').upsert(loanMap);

        await db.update(
          'loans',
          {'sync_status': 'synced'},
          where: 'id = ?',
          whereArgs: [loanJson['id']],
        );
      }

      debugPrint('Successfully synced ${pendingLoans.length} loans.');
      await fetchLoans();
    } catch (e) {
      debugPrint('Error syncing loans: $e');
    }
  }

  Rx<TheStates> searchLoanState = TheStates.initial.obs;
  Future<void> searchLoan(String query) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    searchLoanState.value = TheStates.loading;

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        if (query.isEmpty) {
          await fetchLoans();
          searchLoanState.value = TheStates.success;
          return;
        }
        final db = await DatabaseHelper.instance.database;
        final data = await db.query(
          'loans',
          where: 'party_name LIKE ? AND is_deleted = 0',
          whereArgs: ['%$query%'],
          orderBy: 'created_at DESC',
        );

        loans.value = data.map((json) => LoanModel.fromMap(json)).toList();
        searchLoanState.value = TheStates.success;
      } catch (e) {
        debugPrint('Error searching loans: $e');
        searchLoanState.value = TheStates.error;
      }
    });
  }

  Rx<TheStates> deleteLoanState = TheStates.initial.obs;

  Future<void> deleteLoan(String loanId, BuildContext context) async {
    try {
      deleteLoanState.value = TheStates.loading;
      final result = await dbHelper.deleteLoan(loanId);
      if (result > 0) {
        deleteLoanState.value = TheStates.success;
        // Refresh ledger
        fetchLoans();

        // showTopSnackBar(
        //   Overlay.of(context),
        //   dismissType: DismissType.onSwipe,
        //   onTap: () {
        //     restoreLoan(loanId);
        //   },
        DelightToastBar(
          autoDismiss: true,
          snackbarDuration: const Duration(seconds: 3),
          builder:
              (context) => ToastCard(
                trailing: TextButton(
                  onPressed: () {
                    restoreLoan(loanId);
                  },
                  child: const Text("Undo"),
                ),
                title: const Text(
                  "Loan deleted successfully",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),
        ).show(context);
        // );
      } else {
        deleteLoanState.value = TheStates.error;
      }
    } catch (e) {
      deleteLoanState.value = TheStates.error;
      print(e);
    }
  }

  Rx<TheStates> restoreLoanState = TheStates.initial.obs;
  Future<void> restoreLoan(String loanId) async {
    try {
      restoreLoanState.value = TheStates.loading;
      final result = await dbHelper.restoreLoan(loanId);
      if (result > 0) {
        restoreLoanState.value = TheStates.success;
        fetchLoans();
        print("Loan restored successfully");
      } else {
        restoreLoanState.value = TheStates.error;
      }
    } catch (e) {
      restoreLoanState.value = TheStates.error;
      print("Error restoring loan: $e");
    }
  }
}
