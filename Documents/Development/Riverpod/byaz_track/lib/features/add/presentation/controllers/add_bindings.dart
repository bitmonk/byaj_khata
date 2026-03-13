import 'package:get/get.dart';
import 'package:byaz_track/features/add/data/source/add_remote_source.dart';
import 'package:byaz_track/features/add/presentation/controllers/add_controller.dart';

class AddBindings extends Bindings{
  @override
  void dependencies() {
    Get
      ..lazyPut(() => AddRemoteSource(Get.find()))
      ..put(
        AddController(
          remoteSource: Get.find<AddRemoteSource>(),
        ),
      );
  }

}
class AddInitializer {

  static void initialize(){
        Get
      ..lazyPut(() => AddRemoteSource(Get.find()))
      ..put(
        AddController(
          remoteSource: Get.find<AddRemoteSource>(),
        ),
      );
  }
  static void destroy(){
        Get
      ..delete<AddRemoteSource>()
      ..delete<AddController>();

  }
}
