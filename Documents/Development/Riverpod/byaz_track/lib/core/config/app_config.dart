import 'package:byaz_track/core/build_variants/app_environment_enum.dart';
import 'package:byaz_track/core/extension/extensions.dart';

class AppConfiguration {
  const AppConfiguration({required this.baseUrl, required this.appEnvironment});
  final String baseUrl;

  final AppEnvironment appEnvironment;
  static const development = AppConfiguration(
    baseUrl: AppEndpoints.baseUrl,
    appEnvironment: AppEnvironment.development,
  );

  static const production = AppConfiguration(
    baseUrl: AppEndpoints.baseUrl,
    appEnvironment: AppEnvironment.production,
  );
  static const staging = AppConfiguration(
    baseUrl: AppEndpoints.baseUrl,
    appEnvironment: AppEnvironment.staging,
  );
}
