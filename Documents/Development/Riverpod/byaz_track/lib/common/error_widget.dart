import 'package:byaz_track/core/extension/extensions.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    this.error,
    this.onPressed,
    this.verticlePadding,
  });
  final String? error;
  final Function()? onPressed;
  final EdgeInsetsGeometry? verticlePadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: verticlePadding ?? const EdgeInsets.symmetric(vertical: 30),
      child: Center(
        child: Column(
          children: [
            Text(
              error ?? 'Something went wrong!\nPlease try again later.',
              textAlign: TextAlign.center,
              style: context.text.titleMedium!.copyWith(
                color: AppColors.appRed,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (onPressed != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 10,
                ),
                child: AppOutlinedButton(text: 'Retry', onPressed: onPressed),
              ),
          ],
        ),
      ),
    );
  }
}
