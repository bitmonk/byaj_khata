import 'package:get/get.dart';
import 'package:byaz_track/features/ledger/data/source/ledger_remote_source.dart';
import 'package:byaz_track/features/ledger/presentation/controllers/ledger_controller.dart';

class LedgerBindings extends Bindings{
  @override
  void dependencies() {
    Get
      ..lazyPut(() => LedgerRemoteSource(Get.find()))
      ..put(
        LedgerController(
          remoteSource: Get.find<LedgerRemoteSource>(),
        ),
      );
  }

}
class LedgerInitializer {

  static void initialize(){
        Get
      ..lazyPut(() => LedgerRemoteSource(Get.find()))
      ..put(
        LedgerController(
          remoteSource: Get.find<LedgerRemoteSource>(),
        ),
      );
  }
  static void destroy(){
        Get
      ..delete<LedgerRemoteSource>()
      ..delete<LedgerController>();

  }
}
