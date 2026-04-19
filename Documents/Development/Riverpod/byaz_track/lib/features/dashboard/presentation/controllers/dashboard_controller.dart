import 'package:get/get.dart';
import 'package:byaz_track/features/dashboard/data/source/dashboard_remote_source.dart';

class DashboardController extends GetxController {
  DashboardController({required this.remoteSource});
  final DashboardRemoteSource remoteSource;

  final RxInt currentIndex = 0.obs;

  void changeTabIndex(int index) {
    currentIndex.value = index;
  }
}
