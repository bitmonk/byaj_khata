import 'dart:io';
import 'package:byaz_track/core/db/database_helper.dart';
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

        // Fetch and sync data from Supabase before going to dashboard
        await fetchAndSyncFromSupabase();

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

  Future<void> fetchAndSyncFromSupabase() async {
    try {
      debugPrint('Fetching loans from Supabase...');
      final response = await supabase.from('loans').select();

      if (response is List) {
        final List<dynamic> data = response;
        debugPrint(
          'Found ${data.length} loans on Supabase. Syncing to local DB...',
        );

        // Clear local DB first to ensure we have a fresh state for this user
        await DatabaseHelper.instance.clearDatabase();

        for (final item in data) {
          await DatabaseHelper.instance.insertLoanFromSupabase(
            item as Map<String, dynamic>,
          );
        }
        debugPrint('Sync completed successfully.');
      }
    } catch (e) {
      debugPrint('Error during Supabase sync: $e');
      // We don't want to block login if sync fails, but we should log it
    }
  }

  // Future<Either<AppError, String>> continueWithApple() async {
  //   try {} catch (e) {
  //     if (e is ApiErrorResponse) {
  //       return left(e);
  //     } else {
  //       return left(InternalAppError(message: e.toString()));
  //     }
  //   }
  // }
}
