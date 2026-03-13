import 'package:get/get.dart';
import 'package:byaz_track/features/calculator/data/source/calculator_remote_source.dart';
import 'package:byaz_track/features/calculator/presentation/controllers/calculator_controller.dart';

class CalculatorBindings extends Bindings{
  @override
  void dependencies() {
    Get
      ..lazyPut(() => CalculatorRemoteSource(Get.find()))
      ..put(
        CalculatorController(
          remoteSource: Get.find<CalculatorRemoteSource>(),
        ),
      );
  }

}
class CalculatorInitializer {

  static void initialize(){
        Get
      ..lazyPut(() => CalculatorRemoteSource(Get.find()))
      ..put(
        CalculatorController(
          remoteSource: Get.find<CalculatorRemoteSource>(),
        ),
      );
  }
  static void destroy(){
        Get
      ..delete<CalculatorRemoteSource>()
      ..delete<CalculatorController>();

  }
}
