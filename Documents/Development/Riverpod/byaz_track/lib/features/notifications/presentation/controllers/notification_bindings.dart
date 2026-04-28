import 'package:byaz_track/features/notifications/data/source/notification_remote_source.dart';
import 'package:byaz_track/features/notifications/presentation/controllers/notification_controller.dart';
import 'package:get/get.dart';
import 'package:byaz_track/features/profile/data/source/profile_remote_source.dart';
import 'package:byaz_track/features/profile/presentation/controllers/profile_controller.dart';

class NotificationBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => NotificationRemoteSource(Get.find()))
      ..put(
        NotificationController(
          remoteSource: Get.find<NotificationRemoteSource>(),
        ),
      );
  }
}

class NotificationInitializer {
  static void initialize() {
    Get
      ..lazyPut(() => ProfileRemoteSource(Get.find()))
      ..put(ProfileController(remoteSource: Get.find<ProfileRemoteSource>()));
  }

  static void destroy() {
    Get
      ..delete<ProfileRemoteSource>()
      ..delete<ProfileController>();
  }
}
