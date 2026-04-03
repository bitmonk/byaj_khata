import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/auth/presentation/controllers/auth_bindings.dart';
import 'package:byaz_track/features/auth/presentation/screens/auth_screen.dart';
import 'package:byaz_track/features/create_loan/presentation/controllers/create_loan_bindings.dart';
import 'package:byaz_track/features/create_loan/presentation/screens/create_loan_screen.dart';
import 'package:byaz_track/features/dashboard/presentation/screens/dashboard_screen.dart';

import 'package:byaz_track/features/home/presentation/screens/home_screen.dart';
import 'package:byaz_track/features/profile/presentation/screens/interest_type_screen.dart';
import 'package:byaz_track/features/profile/presentation/screens/language_screen.dart';
import 'package:byaz_track/features/profile/presentation/screens/theme_screen.dart';
import 'package:byaz_track/features/profile/presentation/screens/compound_frequency_screen.dart';
import 'package:byaz_track/features/profile/presentation/screens/default_rate_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String auth = '/auth';
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String theme = '/theme';
  static const String language = '/language';
  static const String interestType = '/interestType';
  static const String compoundFrequency = '/compoundFrequency';
  static const String defaultRate = '/defaultRate';
  static const String createLoan = '/createLoan';

  static List<GetPage<dynamic>>? appPages = [
    GetPage(
      name: auth,
      page: () => const AuthScreen(),
      binding: AuthBindings(),
    ),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(
      name: dashboard,
      page: () => const DashboardScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCirc,
    ),
    GetPage(name: theme, page: () => const ThemeScreen()),
    GetPage(name: language, page: () => const LanguageScreen()),
    GetPage(name: interestType, page: () => const InterestTypeScreen()),
    GetPage(
      name: compoundFrequency,
      page: () => const CompoundFrequencyScreen(),
    ),
    GetPage(name: defaultRate, page: () => const DefaultRateScreen()),
    GetPage(
      name: createLoan,
      page: () => const CreateLoanScreen(),
      binding: CreateLoanBindings(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCirc,
    ),
  ];
}
