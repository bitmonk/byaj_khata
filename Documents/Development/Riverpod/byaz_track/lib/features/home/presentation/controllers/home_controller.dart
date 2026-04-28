import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:byaz_track/core/db/database_helper.dart';
import 'package:byaz_track/features/create_loan/data/model/loan_model.dart';
import 'package:byaz_track/features/ledger/presentation/widgets/ledger_list_item_card.dart';
import 'package:byaz_track/features/home/presentation/widgets/upcoming_collections_widget.dart';
import 'package:get/get.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:byaz_track/core/utils/byaj_helper.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeStats {
  final double totalLending;
  final double totalBorrowing;
  final double netBalance;
  final double monthlyIncome;
  final double avgRate;
  final String nextCollection;
  final double lendingGrowth;
  final double borrowingGrowth;
  final List<UpcomingCollectionItem> upcomingCollections;
  final List<FlSpot> chartSpots6m;
  final List<FlSpot> chartSpots1y;

  HomeStats({
    this.totalLending = 0,
    this.totalBorrowing = 0,
    this.netBalance = 0,
    this.monthlyIncome = 0,
    this.avgRate = 0,
    this.nextCollection = 'N/A',
    this.lendingGrowth = 0,
    this.borrowingGrowth = 0,
    this.upcomingCollections = const [],
    this.chartSpots6m = const [],
    this.chartSpots1y = const [],
  });
}

class HomeController extends GetxController {
  final stats = HomeStats().obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStats();
  }

  Future<void> fetchStats() async {
    isLoading.value = true;
    try {
      final db = await DatabaseHelper.instance.database;
      final userId = Supabase.instance.client.auth.currentUser?.id;
      final List<Map<String, dynamic>> maps = await db.query(
        'loans',
        where: 'is_deleted = 0 AND user_id = ?',
        whereArgs: [userId],
      );

      final allLoans = maps.map((m) => LoanModel.fromMap(m)).toList();
      final activeLoans =
          allLoans
              .where((l) => l.loanStatus == LedgerItemStatus.active)
              .toList();

      double totalLending = 0;
      double totalBorrowing = 0;
      double totalMonthlyInterest = 0;
      double totalLendingPrincipal = 0;

      DateTime? soonestCollection;

      for (var loan in activeLoans) {
        final principal = loan.principalAmount.toDouble();

        // Calculate monthly interest for this loan
        double monthlyInterest = 0;
        final isMonthly =
            loan.interestType == '0'; // Rupee (per 100) = per month

        if (isMonthly) {
          monthlyInterest = (principal * loan.rateValue) / 100;
        } else {
          monthlyInterest = (principal * (loan.rateValue / 100)) / 12;
        }

        if (loan.transactionType == '0') {
          // I Lent
          totalLending += principal;
          totalLendingPrincipal += principal;
          totalMonthlyInterest += monthlyInterest;
        } else {
          // I Borrowed
          totalBorrowing += principal;
        }

        // Determine next collection date (simplified logic: same day next month)
        final lastDate = loan.lastCollectedDate ?? loan.startDate;
        final nextDate = _calculateNextMonthlyDate(lastDate);
        if (soonestCollection == null || nextDate.isBefore(soonestCollection)) {
          soonestCollection = nextDate;
        }
      }

      final netBalance = totalLending - totalBorrowing;
      final avgRate =
          totalLendingPrincipal > 0
              ? (totalMonthlyInterest / totalLendingPrincipal) * 100
              : 0.0;

      String nextCollectionStr = 'N/A';
      if (soonestCollection != null) {
        final now = DateTime.now();
        final difference = soonestCollection.difference(now).inDays;
        if (difference == 0) {
          nextCollectionStr = 'Today';
        } else if (difference == 1) {
          nextCollectionStr = 'Tomorrow';
        } else if (difference < 0) {
          nextCollectionStr = 'Overdue';
        } else {
          nextCollectionStr = 'In $difference Days';
        }
      }

      // Prepare upcoming collections list
      List<UpcomingCollectionItem> upcomingList =
          activeLoans.map((loan) {
            final lastDate = loan.lastCollectedDate ?? loan.startDate;
            final nextDate = _calculateNextMonthlyDate(lastDate);
            final principal = loan.principalAmount.toDouble();
            double monthlyInterest = 0;
            final isMonthly = loan.interestType == '0';
            if (isMonthly) {
              monthlyInterest = (principal * loan.rateValue) / 100;
            } else {
              monthlyInterest = (principal * (loan.rateValue / 100)) / 12;
            }

            final diff = nextDate.difference(DateTime.now()).inDays;
            String dueStatus =
                diff == 0
                    ? 'today'
                    : (diff == 1 ? 'tomorrow' : 'in $diff days');
            if (diff < 0) dueStatus = 'Overdue';

            final type = loan.transactionType == '0' ? 'Lent' : 'Borrowed';
            String dueText = '$type: Due $dueStatus';
            if (diff < 0) dueText = '$type: Overdue';

            return UpcomingCollectionItem(
              name: loan.partyName,
              initials:
                  loan.partyName.isNotEmpty
                      ? loan.partyName.substring(0, 1).toUpperCase()
                      : '?',
              dueText: dueText,
              amount: 'Rs ${monthlyInterest.toStringAsFixed(0)}',
              status: 'MONTHLY INTEREST',
              avatarColor: _getRandomColor(loan.partyName),
              loan: loan,
            );
          }).toList();

      upcomingList = upcomingList.take(5).toList();

      // Calculate Chart Data
      final spots6m = _calculateChartData(allLoans, 6);
      final spots1y = _calculateChartData(allLoans, 12);

      // Save latest interest growth to database
      await _saveInterestGrowth(spots1y);
      await syncInterestGrowth();

      // --- Growth Calculation ---
      final now = DateTime.now();
      final lastMonthEnd = DateTime(now.year, now.month, 0);

      double previousLending = 0;
      double previousBorrowing = 0;

      for (var loan in allLoans) {
        // Was it active at the end of last month?
        bool wasActive = loan.startDate.isBefore(
          lastMonthEnd.add(const Duration(days: 1)),
        );
        if (loan.loanStatus == LedgerItemStatus.settled &&
            loan.lastCollectedDate != null &&
            loan.lastCollectedDate!.isBefore(
              lastMonthEnd.add(const Duration(days: 1)),
            )) {
          wasActive = false;
        }

        if (wasActive) {
          if (loan.transactionType == '0') {
            previousLending += loan.principalAmount;
          } else {
            previousBorrowing += loan.principalAmount;
          }
        }
      }

      double lendingGrowth = 0;
      if (previousLending > 0) {
        lendingGrowth =
            ((totalLending - previousLending) / previousLending) * 100;
      } else if (totalLending > 0) {
        lendingGrowth = 100.0;
      }

      double borrowingGrowth = 0;
      if (previousBorrowing > 0) {
        borrowingGrowth =
            ((totalBorrowing - previousBorrowing) / previousBorrowing) * 100;
      } else if (totalBorrowing > 0) {
        borrowingGrowth = 100.0;
      }

      stats.value = HomeStats(
        totalLending: totalLending,
        totalBorrowing: totalBorrowing,
        netBalance: netBalance,
        monthlyIncome: totalMonthlyInterest,
        avgRate: avgRate,
        nextCollection: nextCollectionStr,
        lendingGrowth: lendingGrowth,
        borrowingGrowth: borrowingGrowth,
        upcomingCollections: upcomingList,
        chartSpots6m: spots6m,
        chartSpots1y: spots1y,
      );
      print('stats.value: ${stats.value.netBalance}');
    } catch (e) {
      print('Error fetching home stats: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<FlSpot> _calculateChartData(List<LoanModel> allLoans, int monthCount) {
    final List<FlSpot> spots = [];
    final now = DateTime.now();

    for (int i = monthCount - 1; i >= 0; i--) {
      // Calculate date for this month (end of the month i months ago)
      final monthDate = DateTime(now.year, now.month - i + 1, 0);
      final monthStart = DateTime(now.year, now.month - i, 1);
      final monthEnd = monthDate;

      double totalInterestForMonth = 0;

      for (var loan in allLoans) {
        if (loan.transactionType != '0') continue; // Only Lending

        // Check if loan was active during this month
        if (loan.startDate.isAfter(monthEnd)) continue;
        if (loan.loanStatus == LedgerItemStatus.settled &&
            loan.lastCollectedDate != null &&
            loan.lastCollectedDate!.isBefore(monthStart)) {
          continue;
        }

        // Calculate interest for this month
        final principal = loan.principalAmount.toDouble();
        double monthlyInterestPotential = 0;
        final isMonthly = loan.interestType == '0';

        if (isMonthly) {
          monthlyInterestPotential = (principal * loan.rateValue) / 100;
        } else {
          monthlyInterestPotential = (principal * (loan.rateValue / 100)) / 12;
        }

        // Pro-rate if started or ended mid-month
        double ratio = 1.0;
        DateTime actualStart =
            loan.startDate.isAfter(monthStart) ? loan.startDate : monthStart;
        DateTime actualEnd =
            (loan.loanStatus == LedgerItemStatus.settled &&
                    loan.lastCollectedDate != null &&
                    loan.lastCollectedDate!.isBefore(monthEnd))
                ? loan.lastCollectedDate!
                : monthEnd;

        if (actualStart.isAfter(actualEnd)) {
          ratio = 0;
        } else {
          final daysInMonth = monthEnd.difference(monthStart).inDays + 1;
          final activeDays = actualEnd.difference(actualStart).inDays + 1;
          ratio = activeDays / daysInMonth;
        }

        totalInterestForMonth += monthlyInterestPotential * ratio;
      }

      // We normalize the X value to 0..11 for the chart logic
      // i = 0 is the current month (last spot)
      // For 6 months: i = 5, 4, 3, 2, 1, 0 -> X should be maybe index in the range
      final xValue = (monthCount - 1 - i).toDouble();
      spots.add(FlSpot(xValue, totalInterestForMonth));
    }

    if (spots.isEmpty || spots.every((s) => s.y == 0)) {
      // Return a flat line of 0s if no data
      return List.generate(monthCount, (index) => FlSpot(index.toDouble(), 0));
    }

    return spots;
  }

  Future<void> _saveInterestGrowth(List<FlSpot> spots) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final supabase = Supabase.instance.client;
      final userId = supabase.auth.currentUser?.id;
      final now = DateTime.now();

      for (int i = 0; i < spots.length; i++) {
        final spot = spots[i];
        // Calculate the month for this spot
        // In _calculateChartData(allLoans, 12):
        // i = 0 is 11 months ago, i = 11 is current month
        final monthOffset = 11 - i;
        final date = DateTime(now.year, now.month - monthOffset, 1);
        final monthYear = DateFormat('yyyy-MM').format(date);

        // Check if already exists for this month and user
        final List<Map<String, dynamic>> existing = await db.query(
          'interest_growth',
          where: 'month_year = ? AND user_id = ?',
          whereArgs: [monthYear, userId],
        );

        if (existing.isEmpty) {
          await db.insert('interest_growth', {
            'id':
                DateTime.now().millisecondsSinceEpoch.toString() + i.toString(),
            'month_year': monthYear,
            'amount': spot.y,
            'user_id': userId,
            'sync_status': 'pending',
          });
        } else {
          // Update existing if amount changed
          if (existing.first['amount'] != spot.y) {
            await db.update(
              'interest_growth',
              {'amount': spot.y, 'sync_status': 'pending'},
              where: 'id = ?',
              whereArgs: [existing.first['id']],
            );
          }
        }
      }
    } catch (e) {
      print('Error saving interest growth: $e');
    }
  }

  Future<void> syncInterestGrowth() async {
    try {
      final db = await DatabaseHelper.instance.database;
      final supabase = Supabase.instance.client;
      final userId = supabase.auth.currentUser?.id;

      if (userId == null) return;

      final pendingSync = await db.query(
        'interest_growth',
        where: 'sync_status = ? AND user_id = ?',
        whereArgs: ['pending', userId],
      );

      if (pendingSync.isEmpty) return;

      for (final row in pendingSync) {
        final map = Map<String, dynamic>.from(row);
        map.remove('sync_status');

        await supabase
            .from('interest_growth')
            .upsert(map, onConflict: 'user_id,month_year');

        await db.update(
          'interest_growth',
          {'sync_status': 'synced'},
          where: 'id = ?',
          whereArgs: [row['id']],
        );
      }
      debugPrint(
        'Synced ${pendingSync.length} interest growth records to Supabase',
      );
    } catch (e) {
      debugPrint('Error syncing interest growth: $e');
    }
  }

  DateTime _calculateNextMonthlyDate(DateTime fromDate) {
    final nextMonth = fromDate.month == 12 ? 1 : fromDate.month + 1;
    final nextYear = fromDate.month == 12 ? fromDate.year + 1 : fromDate.year;

    int nextDay = fromDate.day;
    final daysInNextMonth = _getDaysInMonth(nextYear, nextMonth);
    if (nextDay > daysInNextMonth) {
      nextDay = daysInNextMonth;
    }

    return DateTime(nextYear, nextMonth, nextDay);
  }

  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  Color _getRandomColor(String name) {
    final colors = [
      const Color(0xFF10B981),
      const Color(0xFFF59E0B),
      const Color(0xFF3B82F6),
      const Color(0xFF8B5CF6),
      const Color(0xFFEC4899),
    ];
    return colors[name.length % colors.length];
  }
}
