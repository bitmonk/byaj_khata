import 'dart:io';

import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:byaz_track/features/auth/data/source/auth_remote_source.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  AuthController({required this.remoteSource});
  final AuthRemoteSource remoteSource;

  Rx<TheStates> googleAuthState = TheStates.initial.obs;

  continueWithGoogle() async {
    googleAuthState.value = TheStates.loading;
    final result = await remoteSource.continueWithGoogle();
    result.fold(
      (l) {
        googleAuthState.value = TheStates.error;
      },
      (r) {
        googleAuthState.value = TheStates.success;
      },
    );
  }
}
