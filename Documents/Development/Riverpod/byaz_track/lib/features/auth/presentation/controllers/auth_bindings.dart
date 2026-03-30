import 'package:get/get.dart';
import 'package:byaz_track/features/auth/data/source/auth_remote_source.dart';
import 'package:byaz_track/features/auth/presentation/controllers/auth_controller.dart';

class AuthBindings extends Bindings{
  @override
  void dependencies() {
    Get
      ..lazyPut(() => AuthRemoteSource(Get.find()))
      ..put(
        AuthController(
          remoteSource: Get.find<AuthRemoteSource>(),
        ),
      );
  }

}
class AuthInitializer {

  static void initialize(){
        Get
      ..lazyPut(() => AuthRemoteSource(Get.find()))
      ..put(
        AuthController(
          remoteSource: Get.find<AuthRemoteSource>(),
        ),
      );
  }
  static void destroy(){
        Get
      ..delete<AuthRemoteSource>()
      ..delete<AuthController>();

  }
}
