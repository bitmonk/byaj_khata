import 'dart:async';
import 'package:byaz_track/core/db/database_helper.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/create_loan/data/model/loan_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:byaz_track/features/ledger/data/source/ledger_remote_source.dart';

class LedgerController extends GetxController {
  LedgerController({required this.remoteSource});
  final LedgerRemoteSource remoteSource;

  final RxList<LoanModel> loans = <LoanModel>[].obs;
  Timer? _debounce;

  Rx<TheStates> fetchLoanState = TheStates.initial.obs;

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
      final data = await db.query('loans', orderBy: 'created_at DESC');

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
          where: 'party_name LIKE ?',
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
}
