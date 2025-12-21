import 'package:flutter/services.dart';

class NativeBridge {
  static const _channel = MethodChannel('com.example.native_flutter/native_channel');

  static Future<String?> getIntentData() async {
    final data = await _channel.invokeMethod('getIntentData');
    return data;
  }
}
