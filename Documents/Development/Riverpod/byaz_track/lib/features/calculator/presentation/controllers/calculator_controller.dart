import 'package:get/get.dart';
import 'package:byaz_track/features/calculator/data/source/calculator_remote_source.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class CalculatorController extends GetxController {
  CalculatorController({required this.remoteSource});
  final CalculatorRemoteSource remoteSource;

  final Rx<NepaliDateTime?> startDate = Rx<NepaliDateTime?>(
    NepaliDateTime(2080, 1, 1),
  );
  final Rx<NepaliDateTime?> endDate = Rx<NepaliDateTime?>(NepaliDateTime.now());

  void setStartDate(NepaliDateTime? date) => startDate.value = date;
  void setEndDate(NepaliDateTime? date) => endDate.value = date;
}
