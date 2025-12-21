import 'package:byaz_track/features/dashboard/presentation/dashboard_screen.dart';
import 'package:byaz_track/features/home/presentation/home.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splash = '/';
  static List<GetPage<dynamic>>? appPages = [
    GetPage(name: splash, page: () => const DashboardScreen()),
  ];
}
