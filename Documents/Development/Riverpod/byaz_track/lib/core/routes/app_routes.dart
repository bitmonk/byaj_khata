import 'package:byaz_track/features/dashboard/presentation/screens/dashboard_screen.dart';

import 'package:byaz_track/features/home/presentation/screens/home_screen.dart';
import 'package:byaz_track/features/profile/presentation/screens/interest_type_screen.dart';
import 'package:byaz_track/features/profile/presentation/screens/language_screen.dart';
import 'package:byaz_track/features/profile/presentation/screens/theme_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String theme = '/theme';
  static const String language = '/language';
  static const String interestType = '/interestType';

  static List<GetPage<dynamic>>? appPages = [
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: dashboard, page: () => const DashboardScreen()),
    GetPage(name: theme, page: () => const ThemeScreen()),
    GetPage(name: language, page: () => const LanguageScreen()),
    GetPage(name: interestType, page: () => const InterestTypeScreen()),
  ];
}
