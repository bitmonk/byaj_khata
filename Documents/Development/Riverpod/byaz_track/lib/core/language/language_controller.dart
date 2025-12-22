import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  static LanguageController get instance => Get.find();

  final _box = GetStorage();
  final String _key = 'languageCode';

  final Rx<Locale> _locale = const Locale('en').obs;

  Locale get locale => _locale.value;

  @override
  void onInit() {
    super.onInit();
    _loadLanguageFromStorage();
  }

  /// Load saved language from storage
  void _loadLanguageFromStorage() {
    final savedLanguage = _box.read(_key);
    if (savedLanguage != null) {
      _locale.value = Locale(savedLanguage);
    } else {
      // Default to English if no language is saved
      _locale.value = const Locale('en');
    }
  }

  /// Save language to storage
  Future<void> _saveLanguageToStorage(String languageCode) async {
    await _box.write(_key, languageCode);
  }

  /// Change app language
  Future<void> setLanguage(String languageCode) async {
    if (_locale.value.languageCode == languageCode) return;

    final newLocale = Locale(languageCode);
    _locale.value = newLocale;
    await _saveLanguageToStorage(languageCode);
    Get.updateLocale(newLocale);
  }

  /// Check if current language is English
  bool get isEnglish => _locale.value.languageCode == 'en';

  /// Check if current language is Nepali
  bool get isNepali => _locale.value.languageCode == 'ne';
}
