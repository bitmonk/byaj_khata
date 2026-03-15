import 'package:byaz_track/features/profile/data/source/profile_remote_source.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  ProfileController({required this.remoteSource});
  final ProfileRemoteSource remoteSource;
}
