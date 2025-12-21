import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:byaz_track/core/config/environment_helper.dart';
import 'package:byaz_track/core/dio_provider/dio_api_client.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/core/preferences/preferences.dart';
import 'package:byaz_track/core/preferences/shared_pref.dart';
import 'package:byaz_track/core/push_notification/firebase_notification_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInitializer {
  static Future<void> init() async {
    // Detect fresh install and clear storage if necessary
    final secureStorage = const FlutterSecureStorage();
    final sharedPreferences = await SharedPreferences.getInstance();
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;
    final savedVersion = await secureStorage.read(key: 'app_version');

    if (savedVersion == null || savedVersion != currentVersion) {
      // Fresh install or app version changed, clear storage
      await secureStorage.deleteAll();
      await sharedPreferences.clear();
      await secureStorage.write(key: 'app_version', value: currentVersion);
      await sharedPreferences.setString(PreferenceKeys.isFirstRun, 'true');
      print(
        'Fresh install or version change detected, cleared storage and set isFirstRun to true',
      );
    }

    if (Platform.isAndroid) {
      unawaited(_setHighRefreshRate());
    }

    unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Initialize dependencies
    injectDependencies(sharedPreferences, secureStorage);
  }

  static Future<void> _setHighRefreshRate() async {
    try {
      await FlutterDisplayMode.setHighRefreshRate();
    } catch (e) {
      debugPrint('Error setting high refresh rate: $e');
    }
  }

  static void injectDependencies(
    SharedPreferences sharedPreferences,
    FlutterSecureStorage secureStorage,
  ) {
    Get
      ..put(secureStorage)
      ..lazyPut(() => FirebaseNotificationService())
      ..put(sharedPreferences)
      ..put(AppSharedPref(sharedPreferences))
      ..put(Preferences(secureStorage, Get.find<AppSharedPref>()))
      ..put(Dio())
      ..put(EnvironmentHelper())
      ..put(DioApiClient(Get.find(), Get.find(), Get.find()));
  }
}
