import 'package:nepali_utils/nepali_utils.dart';

extension ShowDataInOwnFormat on DateTime {
  String toYYMMDD() {
    final monthStr = month < 10 ? '0$month' : '$month';
    final dayStr = day < 10 ? '0$day' : '$day';
    return '$year-$monthStr-$dayStr';
  }

  /// Safely converts a DateTime to NepaliDateTime.
  /// Handles cases where a Nepali year (e.g. 2082) might be stored
  /// as an AD year in a standard DateTime field.
  NepaliDateTime toNepaliSafe() {
    if (this is NepaliDateTime) return this as NepaliDateTime;

    // If year is > 2070, it's almost certainly already a Nepali year (BS)
    // currently stored in a DateTime wrapper (interpreting it as AD).
    // In this case, we just "reset" it as a NepaliDateTime.
    if (year > 2070) {
      return NepaliDateTime(year, month, day, hour, minute, second);
    }

    // Otherwise, convert from AD to BS normally.
    return NepaliDateTime.fromDateTime(this);
  }

  String toBS() {
    return NepaliDateFormat('yyyy-MM-dd').format(toNepaliSafe());
  }
}
