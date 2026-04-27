import 'package:byaz_track/core/enum/the_states.dart';
import 'package:byaz_track/core/routes/app_routes.dart';
import 'package:byaz_track/features/profile/data/source/profile_remote_source.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  ProfileController({required this.remoteSource});
  final ProfileRemoteSource remoteSource;

  Rx<TheStates> logoutState = TheStates.initial.obs;
  Rxn<User> user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    user.value = Supabase.instance.client.auth.currentUser;
  }

  Future<void> logout() async {
    logoutState.value = TheStates.loading;
    final result = await remoteSource.logout();
    result.fold(
      (l) {
        logoutState.value = TheStates.error;
        Get.snackbar('Error', l.message);
      },
      (r) {
        logoutState.value = TheStates.success;
        Get.offAllNamed(AppRoutes.auth);
      },
    );
  }
}
