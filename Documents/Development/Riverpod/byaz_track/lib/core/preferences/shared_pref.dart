import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/core/preferences/preferences.dart';
// import 'package:byaz_track/features/login/data/model/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  AppSharedPref(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  Future<void> saveIsFirstRun(String value) async {
    await sharedPreferences.setString(PreferenceKeys.isFirstRun, value);
    debugPrint('✅ Saved isFirstRun to SharedPreferences: $value');
  }

  Future<String> getIsFirstRun() async {
    final value = sharedPreferences.getString(PreferenceKeys.isFirstRun);
    debugPrint('✅ Retrieved isFirstRun from SharedPreferences: $value');
    return value ?? 'true';
  }

  Future<void> remove(key) async {
    await sharedPreferences.remove(key);
  }

  Future<String?> getAccessToken() async {
    final value = sharedPreferences.getString(PreferenceKeys.accessToken);
    return value;
  }

  Future<void> saveAccessToken(String value) async {
    await sharedPreferences.setString(PreferenceKeys.accessToken, value);
  }

  Future<String?> getRefreshToken() async {
    final value = sharedPreferences.getString(PreferenceKeys.refreshToken);
    return value;
  }

  Future<void> setUserId(String userId) async {
    await sharedPreferences.setString(PreferenceKeys.userId, userId);
    debugPrint('✅ Saved userId to SharedPreferences: $userId');
  }

  String? getUserIdFromProfileSync() {
    final userId = sharedPreferences.getString(PreferenceKeys.userId);
    debugPrint('Retrieved userId from SharedPreferences: $userId');
    return userId;
  }

  Future<void> saveRefreshToken(String value) async {
    await sharedPreferences.setString(PreferenceKeys.refreshToken, value);
  }

  Future<void> saveString(String key, String val) async {
    await sharedPreferences.setString(key, val);
  }

  Future<String?> getString(String val) async {
    final value = sharedPreferences.getString(val);
    return value;
  }

  // Future<void> saveUserModel(ProfileModel value) async {
  //   await sharedPreferences.setString(
  //     PreferenceKeys.userProfile,
  //     jsonEncode(value),
  //   );
  // }

  // Future<ProfileModel?> getUserModel() async {
  //   final value = sharedPreferences.getString(PreferenceKeys.userProfile);
  //   if (value != null) {
  //     return ProfileModel.fromJson(jsonDecode(value));
  //   } else {
  //     return null;
  //   }
  // }

  Future<void> removeAll() async {
    await sharedPreferences.clear();
  }
}
