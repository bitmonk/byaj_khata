import 'package:byaz_track/core/extension/extensions.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLoadingWidget.small(color: AppColors.colorWhite);
  }
}
