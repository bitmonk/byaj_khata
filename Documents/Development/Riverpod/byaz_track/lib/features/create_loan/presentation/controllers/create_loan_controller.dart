import 'package:get/get.dart';
import 'package:byaz_track/features/create_loan/data/source/create_loan_remote_source.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class CreateLoanController extends GetxController {
  CreateLoanController({required this.remoteSource});
  final CreateLoanRemoteSource remoteSource;

  final RxInt transactionType = 0.obs;
  final Rx<NepaliDateTime?> startDate = Rx<NepaliDateTime?>(NepaliDateTime.now());
  final RxInt interestRateType = 0.obs;
  final RxString rateValue = ''.obs;

  void setStartDate(NepaliDateTime? date) => startDate.value = date;
}
