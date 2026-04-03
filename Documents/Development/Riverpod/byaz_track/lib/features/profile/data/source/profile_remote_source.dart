import 'package:byaz_track/core/dio_provider/api_error.dart';
import 'package:byaz_track/core/dio_provider/api_response.dart';
import 'package:byaz_track/core/dio_provider/dio_api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRemoteSource {
  ProfileRemoteSource(this._client);
  final DioApiClient _client;
  final supabase = Supabase.instance.client;

  Future<Either<AppError, String>> logout() async {
    try {
      await supabase.auth.signOut();
      if (supabase.auth.currentUser == null) {
        debugPrint('Logout successful');
        return right('Logout successful');
      } else {
        return left(
          InternalAppError(message: 'Logout failed. Please try again.'),
        );
      }
    } catch (e) {
      if (e is ApiErrorResponse) {
        return left(e);
      } else {
        return left(InternalAppError(message: e.toString()));
      }
    }
  }
}
