import 'package:byaz_track/core/extension/extensions.dart';
import 'dart:async';
import 'package:byaz_track/core/config/app_config.dart';
import 'package:byaz_track/features/app/app_initializer.dart';
import 'package:byaz_track/features/app/my_app.dart';

class AppEntryPoint {
  AppEntryPoint(AppConfiguration buildVariant) {
    envSettings = buildVariant;
    initializeStartUpDependenciesAndRun();
  }
  static AppConfiguration? envSettings;

  static Future<void> initializeStartUpDependenciesAndRun() async {
    await AppInitializer.init();

    runApp(MyApp(initialRoute: AppRoutes.splash));
  }
}
