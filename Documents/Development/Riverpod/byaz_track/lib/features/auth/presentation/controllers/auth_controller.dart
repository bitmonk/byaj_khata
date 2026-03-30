import 'package:get/get.dart';
import 'package:byaz_track/features/auth/data/source/auth_remote_source.dart';

class AuthController extends GetxController{
  AuthController({required this.remoteSource});
  final AuthRemoteSource remoteSource;


}
