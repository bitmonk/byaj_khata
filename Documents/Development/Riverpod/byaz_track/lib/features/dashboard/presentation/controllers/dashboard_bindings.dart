import 'package:get/get.dart';
import 'package:byaz_track/features/dashboard/data/source/dashboard_remote_source.dart';
import 'package:byaz_track/features/dashboard/presentation/controllers/dashboard_controller.dart';

class DashboardBindings extends Bindings{
  @override
  void dependencies() {
    Get
      ..lazyPut(() => DashboardRemoteSource(Get.find()))
      ..put(
        DashboardController(
          remoteSource: Get.find<DashboardRemoteSource>(),
        ),
      );
  }

}
class DashboardInitializer {

  static void initialize(){
        Get
      ..lazyPut(() => DashboardRemoteSource(Get.find()))
      ..put(
        DashboardController(
          remoteSource: Get.find<DashboardRemoteSource>(),
        ),
      );
  }
  static void destroy(){
        Get
      ..delete<DashboardRemoteSource>()
      ..delete<DashboardController>();

  }
}
