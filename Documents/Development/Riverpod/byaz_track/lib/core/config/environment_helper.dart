import 'package:byaz_track/features/app/app_entry_point.dart';

enum EnvironmentKey { baseUrl, env }

class EnvironmentHelper {
  String? getValue(EnvironmentKey key) {
    switch (key) {
      case EnvironmentKey.baseUrl:
        return AppEntryPoint.envSettings!.baseUrl;
      case EnvironmentKey.env:
        return AppEntryPoint.envSettings?.appEnvironment.name;
    }
  }
}
