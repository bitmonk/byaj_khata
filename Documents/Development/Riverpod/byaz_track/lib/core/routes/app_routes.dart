import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/auth/presentation/controllers/auth_bindings.dart';
import 'package:byaz_track/features/auth/presentation/screens/auth_screen.dart';
import 'package:byaz_track/features/create_loan/presentation/controllers/create_loan_bindings.dart';
import 'package:byaz_track/features/create_loan/presentation/screens/create_loan_screen.dart';
import 'package:byaz_track/features/dashboard/presentation/controllers/dashboard_bindings.dart';
import 'package:byaz_track/features/dashboard/presentation/screens/dashboard_screen.dart';

import 'package:byaz_track/features/home/presentation/screens/home_screen.dart';
import 'package:byaz_track/features/interest_details/presentation/controllers/interest_details_bindings.dart';
import 'package:byaz_track/features/interest_details/presentation/screens/interest_details_screen.dart';
import 'package:byaz_track/features/interest_details/presentation/screens/loan_history_screen.dart';
import 'package:byaz_track/features/profile/presentation/screens/interest_type_screen.dart';
import 'package:byaz_track/features/profile/presentation/screens/language_screen.dart';
import 'package:byaz_track/features/profile/presentation/screens/theme_screen.dart';
import 'package:byaz_track/features/profile/presentation/screens/compound_frequency_screen.dart';
import 'package:byaz_track/features/profile/presentation/screens/default_rate_screen.dart';
import 'package:byaz_track/features/notifications/presentation/controllers/notification_bindings.dart';
import 'package:byaz_track/features/notifications/presentation/screens/notification_screen.dart';
import 'package:byaz_track/features/splash/presentation/controllers/splash_bindings.dart';
import 'package:byaz_track/features/splash/presentation/screens/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String auth = '/auth';
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String theme = '/theme';
  static const String language = '/language';
  static const String interestType = '/interestType';
  static const String compoundFrequency = '/compoundFrequency';
  static const String defaultRate = '/defaultRate';
  static const String createLoan = '/createLoan';
  static const String interestDetails = '/interestDetails';
  static const String notifications = '/notifications';
  static const String loanHistory = '/loanHistory';

  static List<GetPage<dynamic>>? appPages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: auth,
      page: () => const AuthScreen(),
      binding: AuthBindings(),
    ),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(
      name: dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBindings(),
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
    GetPage(
      name: interestDetails,
      page: () => const InterestDetailsScreen(),
      binding: InterestDetailsBindings(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCirc,
    ),
    GetPage(
      name: notifications,
      page: () => const NotificationScreen(),
      binding: NotificationBindings(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCirc,
    ),
    GetPage(
      name: loanHistory,
      page: () => const LoanHistoryScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCirc,
    ),
  ];
}
