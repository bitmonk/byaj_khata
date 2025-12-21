import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:byaz_track/core/preferences/shared_pref.dart';

class PreferenceKeys {
  static const String isFirstRun = 'isFirstRun';
  static const String isLoggedIn = 'isLoggedIn';
  static const String accessToken = 'ACCESS_TOKEN';
  static const String deviceToken = 'DEVICE_TOKEN';
  static const String refreshToken = 'REFRESH_TOKEN';
  static const String themeMode = 'IS_DARK_MODE';
  static const String userProfile = 'userProfile';
  static const String hasSeenExplainer = 'hasSeenExplainer';
  static const String userId = 'userId';
}

class Preferences {
  const Preferences(this._secureStorage, this._appSharedPref);
  final FlutterSecureStorage _secureStorage;
  final AppSharedPref _appSharedPref;

  Future<void> saveIsFirstRun() async {
    await _appSharedPref.saveIsFirstRun('false');
  }

  Future<String> getIsFirstRun() async {
    return await _appSharedPref.getIsFirstRun();
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: PreferenceKeys.accessToken);
  }

  // Uncomment and implement other methods as needed
  /*
  Future<void> saveString(String name, String value) async {
    await _secureStorage.write(key: name.toLowerCase(), value: value);
  }

  Future<void> saveModel(String name, Object value) async {
    await _secureStorage.write(
      key: name.toLowerCase(),
      value: value.toString(),
    );
  }

  Future<void> userData(String name, String value) async {
    await _secureStorage.write(key: name.toLowerCase(), value: value);
  }

  Future<void> saveBool(String name, {required bool value}) async {
    await _secureStorage.write(
      key: name.toLowerCase(),
      value: value.toString(),
    );
  }

  Future<void> saveLOGOUT() async {
    await _secureStorage.deleteAll();
  }

  Future<String?> getString(String name) async {
    final value = await _secureStorage.read(key: name.toLowerCase());
    return value;
  }

  Future<bool> getBool(String name) async {
    final value = await _secureStorage.read(key: name.toLowerCase());
    return value == 'true';
  }

  Future<bool> getBoolTrueIfNull(String name) async {
    final value = await _secureStorage.read(key: name.toLowerCase());
    return !(value == 'false');
  }

  Future<int> getInt(String name) async {
    final value = await _secureStorage.read(key: name.toLowerCase());
    final intValue = value ?? '0';
    return int.parse(intValue);
  }

  Future<void> saveInt(String name, int value) async {
    await _secureStorage.write(
      key: name.toLowerCase(),
      value: value.toString(),
    );
  }

  Future<void> remove(String name) async {
    await _secureStorage.delete(key: name.toLowerCase());
  }

  Future<void> removeAll() async {
    await _secureStorage.deleteAll();
  }
  */
}
