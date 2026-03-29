import 'package:get/get.dart';
import 'package:byaz_track/features/interest_details/data/source/interest_details_remote_source.dart';
import 'package:byaz_track/features/interest_details/presentation/controllers/interest_details_controller.dart';

class InterestDetailsBindings extends Bindings{
  @override
  void dependencies() {
    Get
      ..lazyPut(() => InterestDetailsRemoteSource(Get.find()))
      ..put(
        InterestDetailsController(
          remoteSource: Get.find<InterestDetailsRemoteSource>(),
        ),
      );
  }

}
class InterestDetailsInitializer {

  static void initialize(){
        Get
      ..lazyPut(() => InterestDetailsRemoteSource(Get.find()))
      ..put(
        InterestDetailsController(
          remoteSource: Get.find<InterestDetailsRemoteSource>(),
        ),
      );
  }
  static void destroy(){
        Get
      ..delete<InterestDetailsRemoteSource>()
      ..delete<InterestDetailsController>();

  }
}
