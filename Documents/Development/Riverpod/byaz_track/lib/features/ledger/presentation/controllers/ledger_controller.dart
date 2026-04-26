import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:byaz_track/core/db/database_helper.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/create_loan/data/model/loan_model.dart';
import 'package:byaz_track/features/ledger/presentation/widgets/ledger_list_item_card.dart';
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
  final RxString _searchQuery = ''.obs;
  final RxString _selectedFilter = 'All'.obs;

  Rx<TheStates> fetchLoanState = TheStates.initial.obs;
  Rx<TheStates> syncState = TheStates.initial.obs;
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  // Summary Observables
  final RxDouble totalReceivables = 0.0.obs;
  final RxDouble monthlyInterest = 0.0.obs;
  final RxString receivablesTrend = '0%'.obs;
  final RxString interestTrend = '0%'.obs;
  final RxBool isReceivablesPositive = true.obs;
  final RxBool isInterestPositive = true.obs;

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

      // --- Summary Calculation ---
      final summaryData = await db.query('loans', where: 'is_deleted = 0');
      final rawLoansForSummary =
          summaryData.map((json) => LoanModel.fromMap(json)).toList();
      calculateSummaries(rawLoansForSummary);

      // --- List Fetching ---
      List<LoanModel> filteredLoans = [];

      if (_selectedFilter.value == 'Upcoming') {
        // Fetch all active loans and sort by upcoming due date
        final data = await db.query(
          'loans',
          where: 'is_deleted = 0 AND loan_status = ?',
          whereArgs: ['active'],
        );
        final allActive = data.map((json) => LoanModel.fromMap(json)).toList();

        // Sort by next collection date
        allActive.sort((a, b) {
          final nextA = _calculateNextMonthlyDate(
            a.lastCollectedDate ?? a.startDate,
          );
          final nextB = _calculateNextMonthlyDate(
            b.lastCollectedDate ?? b.startDate,
          );
          return nextA.compareTo(nextB);
        });

        filteredLoans = allActive;
      } else {
        final queryData = _buildWhereClause(_searchQuery.value);
        final listData = await db.query(
          'loans',
          where: queryData['where'],
          whereArgs: queryData['whereArgs'],
          orderBy: 'created_at DESC',
        );
        filteredLoans =
            listData.map((json) => LoanModel.fromMap(json)).toList();
      }

      loans.value = filteredLoans;
      fetchLoanState.value = TheStates.success;
    } catch (e) {
      debugPrint('Error fetching loans: $e');
      fetchLoanState.value = TheStates.error;
    }
  }

  Map<String, dynamic> _buildWhereClause(String query) {
    String where = 'is_deleted = 0';
    List<dynamic> whereArgs = [];

    if (query.isNotEmpty) {
      where += ' AND party_name LIKE ?';
      whereArgs.add('%$query%');
    }

    switch (_selectedFilter.value) {
      case 'Active':
        where += ' AND loan_status = ?';
        whereArgs.add('active');
        break;
      case 'Settled':
        where += ' AND loan_status = ?';
        whereArgs.add('settled');
        break;
      // 'Upcoming' is handled specially in fetchLoans
      case 'Borrowed':
        where += ' AND transaction_type = ?';
        whereArgs.add('1');
        break;
      case 'Lent':
        where += ' AND transaction_type = ?';
        whereArgs.add('0');
        break;
    }

    return {'where': where, 'whereArgs': whereArgs};
  }

  final RxInt selectedTabIndex = 0.obs;
  void setFilter(String filter) {
    _selectedFilter.value = filter;
    _refreshLedger();
  }

  Future<void> syncAllData(BuildContext context) async {
    try {
      syncState.value = TheStates.loading;
      final db = await dbHelper.database;
      final supabase = Supabase.instance.client;
      final userId = supabase.auth.currentUser?.id;

      if (userId == null) {
        syncState.value = TheStates.error;
        return;
      }

      // 1. Sync Loans
      final loansToSync = await db.query('loans');
      for (final loanJson in loansToSync) {
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

      // 2. Sync Payments
      final paymentsToSync = await db.query('payments');
      for (final paymentJson in paymentsToSync) {
        final paymentMap = Map<String, dynamic>.from(paymentJson);
        paymentMap.remove('sync_status');
        await supabase.from('payments').upsert(paymentMap);
        await db.update(
          'payments',
          {'sync_status': 'synced'},
          where: 'id = ?',
          whereArgs: [paymentJson['id']],
        );
      }

      // 3. Sync Interest Growth (from HomeController logic)
      final growthToSync = await db.query(
        'interest_growth',
        where: 'user_id = ?',
        whereArgs: [userId],
      );
      for (final row in growthToSync) {
        final map = Map<String, dynamic>.from(row);
        map.remove('sync_status');
        await supabase.from('interest_growth').upsert(map);
        await db.update(
          'interest_growth',
          {'sync_status': 'synced'},
          where: 'id = ?',
          whereArgs: [row['id']],
        );
      }

      syncState.value = TheStates.success;
      DelightToastBar(
        autoDismiss: true,
        builder:
            (context) => const ToastCard(
              title: Text(
                "All data synced successfully",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
            ),
      ).show(context);
      await fetchLoans();
    } catch (e) {
      syncState.value = TheStates.error;
      debugPrint('Error syncing data: $e');
      DelightToastBar(
        autoDismiss: true,
        builder:
            (context) => ToastCard(
              title: Text(
                "Sync failed: $e",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
      ).show(context);
    }
  }

  Future<void> syncPendingLoans() async {
    // Keep this for background sync if needed, or point to syncAllData
    // For now, let's keep it minimal or just call syncAllData
  }

  Rx<TheStates> searchLoanState = TheStates.initial.obs;
  Future<void> searchLoan(String query) async {
    _searchQuery.value = query;
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    searchLoanState.value = TheStates.loading;

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      await _executeSearch(query);
    });
  }

  Future<void> _executeSearch(String query) async {
    try {
      final db = await DatabaseHelper.instance.database;

      // Update summaries globally even during search
      final summaryData = await db.query('loans', where: 'is_deleted = 0');
      final rawLoansForSummary =
          summaryData.map((json) => LoanModel.fromMap(json)).toList();
      calculateSummaries(rawLoansForSummary);

      final queryData = _buildWhereClause(query);
      final data = await db.query(
        'loans',
        where: queryData['where'],
        whereArgs: queryData['whereArgs'],
        orderBy: 'created_at DESC',
      );

      loans.value = data.map((json) => LoanModel.fromMap(json)).toList();
      searchLoanState.value = TheStates.success;
    } catch (e) {
      debugPrint('Error searching loans: $e');
      searchLoanState.value = TheStates.error;
    }
  }

  Rx<TheStates> refreshLedgerState = TheStates.initial.obs;
  Future<void> _refreshLedger() async {
    refreshLedgerState.value = TheStates.loading;
    if (_searchQuery.value.isEmpty) {
      await fetchLoans();
    } else {
      await _executeSearch(_searchQuery.value);
    }
    refreshLedgerState.value = TheStates.success;
  }

  void calculateSummaries(List<LoanModel> allLoans) {
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));

    // Filter to only consider "Lent" loans (transactionType == '0')
    // and "Borrowed" loans (transactionType == '1')
    // for separate receivables/payables calculation if needed.
    // However, the requested metrics are "Total Receivables" and "Monthly Interest".

    final lentLoans = allLoans.where((l) => l.transactionType == '0').toList();

    // --- Current Metrics ---
    final activeLoans =
        lentLoans
            .where((l) => l.loanStatus == LedgerItemStatus.active)
            .toList();

    double currentTotal = 0;
    double currentInterest = 0;

    for (var loan in activeLoans) {
      currentTotal += loan.principalAmount;
      // Monthly interest calculation
      if (loan.interestType == '0') {
        // 0 = Monthly (Rupee per 100)
        currentInterest += (loan.principalAmount * loan.rateValue) / 100;
      } else {
        // 1 = Per Annum (%)
        currentInterest += (loan.principalAmount * loan.rateValue) / 1200;
      }
    }

    totalReceivables.value = currentTotal;
    monthlyInterest.value = currentInterest;

    // --- Past Metrics (30 days ago) ---
    final pastActiveLoans =
        lentLoans.where((l) {
          final isCreatedBefore = l.createdAt.isBefore(thirtyDaysAgo);
          final isStillActive = l.loanStatus == LedgerItemStatus.active;
          final wasSettledRecently =
              l.loanStatus == LedgerItemStatus.settled &&
              (l.lastCollectedDate?.isAfter(thirtyDaysAgo) ?? false);

          return isCreatedBefore && (isStillActive || wasSettledRecently);
        }).toList();

    double pastTotal = 0;
    double pastInterest = 0;

    for (var loan in pastActiveLoans) {
      pastTotal += loan.principalAmount;
      if (loan.interestType == '0') {
        pastInterest += (loan.principalAmount * loan.rateValue) / 100;
      } else {
        pastInterest += (loan.principalAmount * loan.rateValue) / 1200;
      }
    }

    // --- Trend Calculation ---
    receivablesTrend.value = _calculateTrend(currentTotal, pastTotal);
    isReceivablesPositive.value = currentTotal >= pastTotal;

    interestTrend.value = _calculateTrend(currentInterest, pastInterest);
    isInterestPositive.value = currentInterest >= pastInterest;
  }

  String _calculateTrend(double current, double past) {
    if (past == 0) return current > 0 ? '+100%' : '0%';
    final change = ((current - past) / past) * 100;
    final sign = change >= 0 ? '+' : '';
    return '$sign${change.toStringAsFixed(1)}%';
  }

  Rx<TheStates> deleteLoanState = TheStates.initial.obs;

  Future<void> deleteLoan(String loanId, BuildContext context) async {
    try {
      deleteLoanState.value = TheStates.loading;
      final result = await dbHelper.deleteLoan(loanId);
      if (result > 0) {
        deleteLoanState.value = TheStates.success;
        // Refresh ledger respecting current search
        await _refreshLedger();

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
        await _refreshLedger();
        print("Loan restored successfully");
      } else {
        restoreLoanState.value = TheStates.error;
      }
    } catch (e) {
      restoreLoanState.value = TheStates.error;
      print("Error restoring loan: $e");
    }
  }

  DateTime _calculateNextMonthlyDate(DateTime date) {
    int nextMonth = date.month + 1;
    int nextYear = date.year;
    if (nextMonth > 12) {
      nextMonth = 1;
      nextYear += 1;
    }
    int daysInNextMonth = _getDaysInMonth(nextYear, nextMonth);
    int nextDay = date.day > daysInNextMonth ? daysInNextMonth : date.day;
    return DateTime(nextYear, nextMonth, nextDay);
  }

  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
}
