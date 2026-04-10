import 'package:byaz_track/core/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({
    super.key,
    this.size = 52,
    this.color = AppColors.appGreen,
  });
  const AppLoadingWidget.small({
    super.key,
    this.size = 36,
    this.color = AppColors.appGreen,
  });
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Center(child: LoadingAnimationWidget.beat(color: color, size: size));
  }
}
