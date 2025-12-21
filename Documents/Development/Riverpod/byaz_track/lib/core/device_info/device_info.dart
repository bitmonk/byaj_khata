import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String> getUniqueDeviceId() async {
  final deviceInfo = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;

      return iosInfo.identifierForVendor ?? '';
    }
    return '';
  } catch (e) {
    // print('Error getting device info: $e');
    return '';
  }
}

String get deviceType => Platform.isAndroid
    ? 'android'
    : Platform.isIOS
        ? 'ios'
        : 'other';
