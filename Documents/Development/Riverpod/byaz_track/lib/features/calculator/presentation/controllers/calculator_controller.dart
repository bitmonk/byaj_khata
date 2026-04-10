import 'package:get/get.dart';
import 'package:byaz_track/features/calculator/data/source/calculator_remote_source.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/core/utils/byaj_helper.dart';
import 'package:nepali_utils/nepali_utils.dart';

class CalculatorController extends GetxController {
  CalculatorController({required this.remoteSource});
  final CalculatorRemoteSource remoteSource;

  final Rx<NepaliDateTime?> startDate = Rx<NepaliDateTime?>(null);
  final Rx<NepaliDateTime?> endDate = Rx<NepaliDateTime?>(null);

  final RxString principalAmount = ''.obs;
  final RxString interestRate = ''.obs;
  final RxInt interestType = 0.obs;

  void setStartDate(NepaliDateTime? date) => startDate.value = date;
  void setEndDate(NepaliDateTime? date) => endDate.value = date;

  double get principal => double.tryParse(principalAmount.value) ?? 0;
  double get _rate => double.tryParse(interestRate.value) ?? 0;

  /// Computed interest result using ByajHelper
  InterestResult? get interestResult {
    if (principal <= 0 ||
        _rate <= 0 ||
        startDate.value == null ||
        endDate.value == null) {
      return null;
    }

    return ByajHelper.calculateInterest(
      principal: principal,
      rate: _rate,
      isMonthly: interestType.value == 0,
      start: startDate.value!,
      end: endDate.value!,
    );
  }

  String get durationStr {
    final result = interestResult;
    if (result == null) return '0 days';
    return result.duration.toString();
  }

  double get calculatedInterest => interestResult?.interest ?? 0;

  String get totalInterestStr => calculatedInterest.toStringAsFixed(0);

  double get monthlyInterest {
    if (principal <= 0 || _rate <= 0) return 0;
    if (interestType.value == 0) {
      // Byaj (Rs. per 100 per month)
      return principal * (_rate / 100);
    } else {
      // Percentage (%) annually -> monthly = (rate/12)%
      return (principal * (_rate / 12)) / 100;
    }
  }

  String get monthlyInterestStr => monthlyInterest.toStringAsFixed(2);

  String get totalAmountStr =>
      (principal + (interestResult?.interest ?? 0)).toStringAsFixed(2);

  String get interestPercentageStr {
    if (principal <= 0) return '0%';
    final p = (calculatedInterest / principal) * 100;
    return '${p.toStringAsFixed(1)}%';
  }
}
