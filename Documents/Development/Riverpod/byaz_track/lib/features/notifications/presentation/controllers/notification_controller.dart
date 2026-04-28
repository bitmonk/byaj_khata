import 'package:byaz_track/features/notifications/data/source/notification_remote_source.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {

  final NotificationRemoteSource remoteSource;
  NotificationController({required this.remoteSource});
  
  final RxList<dynamic> notifications = <dynamic>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // For now, it's empty as per user request
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    notifications.clear(); // Ensure it's empty
    isLoading.value = false;
  }
}
