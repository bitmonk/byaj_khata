import 'package:get/get.dart';
import 'package:byaz_track/features/language_screen/data/source/language_screen_remote_source.dart';
import 'package:byaz_track/features/language_screen/presentation/controllers/language_screen_controller.dart';

class LanguageScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => LanguageScreenRemoteSource(Get.find()))
      ..put(
        LanguageScreenController(
          remoteSource: Get.find<LanguageScreenRemoteSource>(),
        ),
      );
  }
}

class LanguageScreenInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => LanguageScreenRemoteSource(Get.find()))
      ..put(
        LanguageScreenController(
          remoteSource: Get.find<LanguageScreenRemoteSource>(),
        ),
      );
  }

  static void destroy() {
    Get
      ..delete<LanguageScreenRemoteSource>()
      ..delete<LanguageScreenController>();
  }
}
