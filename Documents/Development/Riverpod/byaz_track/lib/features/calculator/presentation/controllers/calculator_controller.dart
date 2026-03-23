import 'package:get/get.dart';
import 'package:byaz_track/features/calculator/data/source/calculator_remote_source.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:byaz_track/core/extension/extensions.dart';

class CalculatorController extends GetxController {
  CalculatorController({required this.remoteSource});
  final CalculatorRemoteSource remoteSource;

  final Rx<NepaliDateTime?> startDate = Rx<NepaliDateTime?>(
    NepaliDateTime(2080, 1, 1),
  );
  final Rx<NepaliDateTime?> endDate = Rx<NepaliDateTime?>(NepaliDateTime.now());

  final RxString principalAmount = ''.obs;
  final RxString interestRate = ''.obs;
  final RxInt interestType = 0.obs;

  void setStartDate(NepaliDateTime? date) => startDate.value = date;
  void setEndDate(NepaliDateTime? date) => endDate.value = date;

  double get _principal => double.tryParse(principalAmount.value) ?? 0;
  double get _rate => double.tryParse(interestRate.value) ?? 0;

  Map<String, int> get duration {
    if (startDate.value == null || endDate.value == null) {
      return {'years': 0, 'months': 0, 'days': 0};
    }

    // Simple duration calculation for Nepali dates
    var start = startDate.value!;
    var end = endDate.value!;

    // Ensure end is after start
    if (end.isBefore(start)) {
      final temp = start;
      start = end;
      end = temp;
    }

    int years = end.year - start.year;
    int months = end.month - start.month;
    int days = end.day - start.day;

    if (days < 0) {
      months -= 1;
      // Approximate days in month as 30 for interest calculation
      days += 30;
    }
    if (months < 0) {
      years -= 1;
      months += 12;
    }

    return {'years': years, 'months': months, 'days': days};
  }

  double get totalMonths {
    final d = duration;
    return d['years']! * 12 + d['months']! + (d['days']! / 30.0);
  }

  double get calculatedInterest {
    if (_principal <= 0 || _rate <= 0) return 0;

    if (interestType.value == 0) {
      // Byaj (Rs. per 100 per month)
      return _principal * (_rate / 100) * totalMonths;
    } else {
      // Percentage (%) annually
      return (_principal * _rate * (totalMonths / 12)) / 100;
    }
  }

  String get totalInterestStr => calculatedInterest.toNepali();
  String get totalAmountStr => (_principal + calculatedInterest).toNepali();
  String get interestPercentageStr {
    if (_principal <= 0) return '0%';
    final p = (calculatedInterest / _principal) * 100;
    return '${p.toStringAsFixed(1)}%';
  }
}
