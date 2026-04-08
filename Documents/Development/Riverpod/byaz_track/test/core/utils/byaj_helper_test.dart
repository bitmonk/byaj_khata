import 'package:flutter_test/flutter_test.dart';
import 'package:byaz_track/core/utils/byaj_helper.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:byaz_track/core/extension/date_extension.dart';

void main() {
  group('ByajHelper Tests', () {
    test('calculateDuration - Exact month', () {
      final start = NepaliDateTime(2080, 1, 10);
      final end = NepaliDateTime(2080, 2, 10);
      final duration = ByajHelper.calculateDuration(start, end);

      expect(duration.years, 0);
      expect(duration.months, 1);
      expect(duration.days, 0);
      expect(duration.totalMonths, 1);
    });

    test('calculateDuration - Month crossing with extra days', () {
      final start = NepaliDateTime(2080, 1, 10);
      final end = NepaliDateTime(2080, 2, 15);
      final duration = ByajHelper.calculateDuration(start, end);

      expect(duration.years, 0);
      expect(duration.months, 1);
      expect(duration.days, 5);
    });

    test('calculateDuration - Year crossing', () {
      final start = NepaliDateTime(2079, 12, 10);
      final end = NepaliDateTime(2080, 1, 10);
      final duration = ByajHelper.calculateDuration(start, end);

      expect(duration.years, 0);
      expect(duration.months, 1);
      expect(duration.totalMonths, 1);
    });

    test('getDaysInMonth - Baishakh is usually 31', () {
      expect(ByajHelper.getDaysInMonth(2080, 1), 31);
    });

    test('calculateInterest - Simple monthly 2%', () {
      final start = NepaliDateTime(2080, 1, 1);
      final end = NepaliDateTime(2080, 2, 1); // 1 month exactly
      final result = ByajHelper.calculateInterest(
        principal: 1000,
        rate: 2,
        isMonthly: true,
        start: start,
        end: end,
      );

      // 1000 * 1 month * 2% = 20
      expect(result.interest, 20.0);
    });

    test('calculateInterest - 1 month 15 days at 2%', () {
      final start = NepaliDateTime(2080, 1, 1);
      final end = NepaliDateTime(2080, 2, 16);
      // Baishakh has 31 days. So 1 month (Baishakh) + 15 days in Jestha.
      // Jestha days? Let's check.
      // The logic uses getDaysInMonth(end.year, end.month) which is Jestha.
      // Jestha 2080 has 32 days? (Wait, Nepali calendar varies).

      final result = ByajHelper.calculateInterest(
        principal: 1000,
        rate: 2,
        isMonthly: true,
        start: start,
        end: end,
      );

      final daysInJestha = ByajHelper.getDaysInMonth(2080, 2);
      final expectedT = 1.0 + (15.0 / daysInJestha);
      final expectedInterest = 1000 * expectedT * 2 / 100;

      expect(result.interest, expectedInterest);
    });

    test('calculateDuration - Year mismatch bug regression test', () {
      // Scenario: Loan taken on 2082-10-07 BS.
      // But stored in a standard DateTime field, so DateTime(2082, 10, 7)
      // which is interpreted as 2082 AD.
      final loanStartDate = DateTime(2082, 10, 7);

      // Today is 2082-12-25 BS
      final todayInBS = NepaliDateTime(2082, 12, 25);

      // Using the new safe conversion:
      final safeStart = loanStartDate.toNepaliSafe();

      expect(safeStart.year, 2082);
      expect(safeStart.month, 10);
      expect(safeStart.day, 7);

      final duration = ByajHelper.calculateDuration(safeStart, todayInBS);
      expect(duration.totalMonths, 2);
      expect(duration.days, 18);
    });
  });
}
