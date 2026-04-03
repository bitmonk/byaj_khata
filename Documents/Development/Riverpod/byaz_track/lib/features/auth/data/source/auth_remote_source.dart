import 'dart:io';

import 'package:byaz_track/core/dio_provider/api_response.dart';
import 'package:byaz_track/core/dio_provider/dio_api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteSource {
  AuthRemoteSource(this._client);
  final DioApiClient _client;
  final supabase = Supabase.instance.client;
  Future<Either<AppError, String>> continueWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(
        serverClientId: dotenv.env['WEB_CLIENT'],
        clientId:
            Platform.isAndroid
                ? dotenv.env['ANDROID_CLIENT']
                : dotenv.env['IOS_CLIENT'],
      );
      GoogleSignInAccount account = await googleSignIn.authenticate();

      String idToken = account.authentication.idToken ?? '';
      final authorization =
          await account.authorizationClient.authorizationForScopes([
            'email',
            'profile',
          ]) ??
          await account.authorizationClient.authorizeScopes([
            'email',
            'profile',
          ]);
      final result = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization.accessToken,
      );
      if (result.user != null && result.session != null) {
        debugPrint(
          {
            'user': result.user?.toJson(),
            'session': result.session?.toJson(),
          }.toString(),
        );
        Get.offAllNamed(AppRoutes.dashboard);
      }
      return right('success');
    } catch (e) {
      if (e is ApiErrorResponse) {
        return left(e);
      } else {
        return left(InternalAppError(message: e.toString()));
      }
    }
  }
}
