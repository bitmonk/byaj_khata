import 'package:byaz_track/core/extension/string_extension.dart';

class AppValidators {
  static String? required(String? value) {
    if (value.isNullOrEmpty()) {
      return 'This Field is required';
    }
    return null;
  }

  static String? match(String? value, String? matchValue) {
    if (value != matchValue) {
      return 'Passwords does not match';
    }
    return null;
  }
}
