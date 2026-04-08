import 'package:nepali_utils/nepali_utils.dart';

/// Class to represent the duration between two Nepali dates
class ByajDuration {
  final int years;
  final int months;
  final int days;
  final int totalMonths;
  final int totalDays;

  ByajDuration({
    required this.years,
    required this.months,
    required this.days,
    required this.totalMonths,
    required this.totalDays,
  });

  @override
  String toString() {
    List<String> parts = [];
    if (years > 0) parts.add('$years year${years > 1 ? 's' : ''}');
    if (months > 0) parts.add('$months month${months > 1 ? 's' : ''}');
    if (days > 0) parts.add('$days day${days > 1 ? 's' : ''}');
    return parts.isEmpty ? '0 days' : parts.join(', ');
  }
}

/// Class to represent the result of interest calculation
class InterestResult {
  final ByajDuration duration;
  final double interest;
  final double totalAmount;
  final double rate;
  final bool isMonthly;

  InterestResult({
    required this.duration,
    required this.interest,
    required this.totalAmount,
    required this.rate,
    required this.isMonthly,
  });
}

class ByajHelper {
  /// Calculates the duration between two Nepali dates accurately
  static ByajDuration calculateDuration(NepaliDateTime start, NepaliDateTime end) {
    // Ensure end is after start
    bool isNegative = end.isBefore(start);
    NepaliDateTime s = isNegative ? end : start;
    NepaliDateTime e = isNegative ? start : end;

    int years = e.year - s.year;
    int months = e.month - s.month;
    int days = e.day - s.day;

    if (days < 0) {
      months -= 1;
      // Get days in the previous month of the end date
      int prevMonth = e.month - 1;
      int prevYear = e.year;
      if (prevMonth == 0) {
        prevMonth = 12;
        prevYear -= 1;
      }
      days += getDaysInMonth(prevYear, prevMonth);
    }

    if (months < 0) {
      years -= 1;
      months += 12;
    }

    int totalMonths = (years * 12) + months;
    int totalDays = e.difference(s).inDays;

    return ByajDuration(
      years: isNegative ? -years : years,
      months: isNegative ? -months : months,
      days: isNegative ? -days : days,
      totalMonths: isNegative ? -totalMonths : totalMonths,
      totalDays: isNegative ? -totalDays : totalDays,
    );
  }

  /// Gets the number of days in a specific Nepali month
  static int getDaysInMonth(int year, int month) {
    // Nepali months can have 29 to 32 days
    // Using the trick: first day of next month minus one day
    int nextMonth = month + 1;
    int nextYear = year;
    if (nextMonth > 12) {
      nextMonth = 1;
      nextYear += 1;
    }
    return NepaliDateTime(nextYear, nextMonth, 1)
        .subtract(const Duration(days: 1))
        .day;
  }

  /// Calculates interest based on principal, rate, and dates
  /// [rate] is percentage. 
  /// If [isMonthly] is true, rate is per month (e.g. 2% per month).
  /// If [isMonthly] is false, rate is per annum (e.g. 18% per year).
  static InterestResult calculateInterest({
    required double principal,
    required double rate,
    required bool isMonthly,
    required NepaliDateTime start,
    required NepaliDateTime end,
  }) {
    final duration = calculateDuration(start, end);
    
    // For fractional part calculation:
    // We use the days in the month where the 'extra days' would fall.
    // Usually, this is the month after the full months are completed.
    int daysInCurrentMonth = getDaysInMonth(end.year, end.month);
    
    double tMonths = duration.totalMonths + (duration.days / daysInCurrentMonth);
    double interest;

    if (isMonthly) {
      // Interest = (P * T_months * R_monthly) / 100
      interest = (principal * tMonths * rate) / 100;
    } else {
      // Interest = (P * T_years * R_annual) / 100
      double tYears = tMonths / 12.0;
      interest = (principal * tYears * rate) / 100;
    }

    return InterestResult(
      duration: duration,
      interest: interest,
      totalAmount: principal + interest,
      rate: rate,
      isMonthly: isMonthly,
    );
  }

  /// Simple total amount calculation
  static double calculateTotalAmount(double principal, double interest) {
    return principal + interest;
  }
}
