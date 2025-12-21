import 'package:byaz_track/core/extension/extensions.dart';

class UiHelper {
  static void showloaderdialog(BuildContext context, {bool canPop = false}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const AppLoadingWidget.small();
      },
    );
  }
}
