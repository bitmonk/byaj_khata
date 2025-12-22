import 'package:get/get.dart';
import 'package:byaz_track/features/{{name}}/data/source/{{name.snakeCase()}}_remote_source.dart';

class {{name.pascalCase()}}Controller extends GetxController{
  {{name.pascalCase()}}Controller({required this.remoteSource});
  final {{name.pascalCase()}}RemoteSource remoteSource;


}
