import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:byaz_track/core/extension/extensions.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    required this.text,
    this.textStyle,
    super.key,
    this.onPressed,
    this.textColor = AppColors.colorWhite,
    this.backgroundColor = AppColors.color7641C3,
    this.height = 58,
    this.progress,
    this.width = 271,
    this.isLoading = false,
    this.borderColor,
    this.borderRadius = 30,
    this.hasShadow = true,
    this.safePadding = false,
    this.leading,
  });
  const AppOutlinedButton.lightBlue({
    required this.text,
    this.textStyle,
    super.key,
    this.progress,
    this.onPressed,
    this.textColor = AppColors.textColor50,
    this.backgroundColor = AppColors.primary200,
    this.height = 52,
    this.width = double.infinity,
    this.isLoading = false,
    this.borderColor = AppColors.primary200,
    this.borderRadius = 24,
    this.hasShadow = true,
    this.safePadding = false,
    this.leading,
  });
  const AppOutlinedButton.button({
    required this.text,
    this.textStyle,
    super.key,
    this.progress,
    this.onPressed,
    this.textColor = AppColors.foundationPrimary500,
    this.backgroundColor = AppColors.foundationPrimary50,
    this.height = 52,
    this.width = double.infinity,
    this.isLoading = false,
    this.borderColor = AppColors.primary200,
    this.borderRadius = 30,
    this.hasShadow = true,
    this.safePadding = false,
    this.leading,
  });
  // old app buttonWhite
  const AppOutlinedButton.white({
    required this.text,
    this.textStyle,
    super.key,
    this.onPressed,
    this.progress,
    this.textColor = AppColors.textColor50,
    this.backgroundColor = AppColors.primary200,
    this.height = 52,
    this.width = double.infinity,
    this.isLoading = false,
    this.borderColor = AppColors.primary200,
    this.borderRadius = 16,
    this.hasShadow = true,
    this.safePadding = false,
    this.leading,
  });
  const AppOutlinedButton.withOutlined({
    required this.text,
    this.progress,
    this.textStyle,
    super.key,
    this.onPressed,
    this.textColor = AppColors.primary500,
    this.backgroundColor = AppColors.white,
    this.height = 52,
    this.width = double.infinity,
    this.isLoading = false,
    this.borderColor = AppColors.primary500,
    this.borderRadius = 24,
    this.hasShadow = true,
    this.safePadding = false,
    this.leading,
  });

  const AppOutlinedButton.orange({
    required this.text,
    this.textStyle,
    super.key,
    this.progress,
    this.onPressed,
    this.textColor = Colors.white,
    this.backgroundColor = AppColors.appRed,
    this.height = 52,
    this.width = double.infinity,
    this.isLoading = false,
    this.borderColor,
    this.borderRadius = 24,
    this.hasShadow = true,
    this.safePadding = false,
    this.leading,
  });

  final String text;
  final void Function()? onPressed;
  final Color textColor;
  final Color backgroundColor;

  final double? height;
  final double? width;
  final bool isLoading;
  final double borderRadius;
  final Color? borderColor;
  final double? progress;
  final bool hasShadow;
  final bool safePadding;
  final Widget? leading;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    return Padding(
      padding: safePadding ? EdgeInsets.only(bottom: 20.h) : EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          if (isEnabled) {
            HapticFeedback.lightImpact();
            AppUtils.unfocusKeyboard(context);
            onPressed?.call();
          }
        },
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            // border: Border.all(
            //   color: isEnabled
            //       ? (borderColor ?? backgroundColor)
            //       : Colors.transparent,
            // ),
            border: Border.all(color: borderColor ?? backgroundColor),
          ),
          child: Stack(
            children: [
              // 🔵 Progress fill background
              if (progress != null && progress! > 0)
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress!.clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary500,
                          // borderRadius: BorderRadius.horizontal(
                          //   left: Radius.circular(borderRadius),
                          //   right: Radius.circular(
                          //     progress! >= 0.95 ? borderRadius : 0,
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),

              // 🔤 Button content
              Center(
                child:
                    isLoading
                        ? const AppLoadingWidget.small(
                          color: AppColors.colorWhite,
                        )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (leading != null) leading!,
                            Text(
                              text,
                              style:
                                  textStyle ??
                                  context.text.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white,
                                  ),
                            ),
                          ],
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
