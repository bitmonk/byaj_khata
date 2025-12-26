import 'package:byaz_track/features/create/presentation/screens/create_screen.dart';
import 'package:byaz_track/features/dashboard/presentation/dashboard_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splash = '/';
  static const String create = '/create';
  static List<GetPage<dynamic>>? appPages = [
    GetPage(name: splash, page: () => const DashboardScreen()),
    GetPage(name: create, page: () => CreateScreen()),
  ];
}
