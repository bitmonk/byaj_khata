import 'package:byaz_track/core/extension/extensions.dart';
import 'dart:async';
import 'package:byaz_track/core/config/app_config.dart';
import 'package:byaz_track/core/preferences/preferences.dart';
import 'package:byaz_track/core/preferences/shared_pref.dart';
import 'package:byaz_track/features/app/app_initializer.dart';
import 'package:byaz_track/features/app/my_app.dart';
// import 'package:byaz_track/features/profile/presentation/controllers/profile_bindings.dart';

class AppEntryPoint {
  AppEntryPoint(AppConfiguration buildVariant) {
    envSettings = buildVariant;
    initializeStartUpDependenciesAndRun();
  }
  static AppConfiguration? envSettings;

  static Future<void> initializeStartUpDependenciesAndRun() async {
    await AppInitializer.init();

    // Always start with splash screen, it will handle the navigation
    runApp(MyApp(initialRoute: AppRoutes.splash));
  }
}
