import 'package:byaz_track/features/dashboard/presentation/screens/dashboard_screen.dart';

import 'package:byaz_track/features/home/presentation/screens/home_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static List<GetPage<dynamic>>? appPages = [
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: dashboard, page: () => const DashboardScreen()),
  ];
}
