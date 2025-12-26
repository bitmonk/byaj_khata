import 'package:byaz_track/features/create/data/source/create_screen_remote_source.dart';
import 'package:byaz_track/features/create/presentation/controllers/create_screen_controller.dart';
import 'package:get/get.dart';

class CreateScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => CreateScreenRemoteSource(Get.find()))
      ..put(
        CreateScreenController(
          remoteSource: Get.find<CreateScreenRemoteSource>(),
        ),
      );
  }
}

class CreateScreenInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => CreateScreenRemoteSource(Get.find()))
      ..put(
        CreateScreenController(
          remoteSource: Get.find<CreateScreenRemoteSource>(),
        ),
      );
  }

  static void destroy() {
    Get
      ..delete<CreateScreenRemoteSource>()
      ..delete<CreateScreenController>();
  }
}
