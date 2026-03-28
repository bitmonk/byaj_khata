import 'package:get/get.dart';
import 'package:byaz_track/features/create_loan/data/source/create_loan_remote_source.dart';
import 'package:byaz_track/features/create_loan/presentation/controllers/create_loan_controller.dart';

class CreateLoanBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => CreateLoanRemoteSource(Get.find()))
      ..put(
        CreateLoanController(remoteSource: Get.find<CreateLoanRemoteSource>()),
      );
  }
}

class CreateLoanInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => CreateLoanRemoteSource(Get.find()))
      ..put(
        CreateLoanController(remoteSource: Get.find<CreateLoanRemoteSource>()),
      );
  }

  static void destroy() {
    Get
      ..delete<CreateLoanRemoteSource>()
      ..delete<CreateLoanController>();
  }
}
