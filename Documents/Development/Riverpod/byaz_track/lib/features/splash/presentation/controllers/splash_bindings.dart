import 'package:get/get.dart';
import 'package:byaz_track/features/splash/data/source/splash_remote_source.dart';
import 'package:byaz_track/features/splash/presentation/controllers/splash_controller.dart';

class SplashBindings extends Bindings{
  @override
  void dependencies() {
    Get
      ..lazyPut(() => SplashRemoteSource(Get.find()))
      ..put(
        SplashController(
          remoteSource: Get.find<SplashRemoteSource>(),
        ),
      );
  }

}
class SplashInitializer {

  static void initialize(){
        Get
      ..lazyPut(() => SplashRemoteSource(Get.find()))
      ..put(
        SplashController(
          remoteSource: Get.find<SplashRemoteSource>(),
        ),
      );
  }
  static void destroy(){
        Get
      ..delete<SplashRemoteSource>()
      ..delete<SplashController>();

  }
}
