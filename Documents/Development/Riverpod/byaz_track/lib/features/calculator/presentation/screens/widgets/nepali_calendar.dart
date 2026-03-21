import 'package:byaz_track/core/extension/extensions.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class NepaliCalendar {
  static Future<NepaliDateTime?> show(
    BuildContext context, {
    NepaliDateTime? initialDate,
    NepaliDateTime? firstDate,
    NepaliDateTime? lastDate,
  }) async {
    return await showNepaliDatePicker(
      context: context,
      initialDate: initialDate ?? NepaliDateTime.now(),
      firstDate: firstDate ?? NepaliDateTime(1970, 2, 5),
      lastDate: lastDate ?? NepaliDateTime(2250, 11, 6),
      initialDatePickerMode: DatePickerMode.day,
      builder: (context, child) {
        return Theme(
          data: context.theme,
          child: child!,
        );
      },
    );
  }
}
