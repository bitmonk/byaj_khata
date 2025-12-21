import 'package:byaz_track/core/extension/extensions.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    required this.label,
    super.key,
    this.onTap,
    this.color = AppColors.foundationPrimary500,
    this.fontSize = 12,
    this.padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
  });
  const AppTextButton.grey({
    required this.label,
    super.key,
    this.onTap,
    this.color = AppColors.textColor200,
    this.fontSize = 16,
    this.padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
  });
  final String label;
  final Color color;
  final double fontSize;
  final void Function()? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: padding,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: context.text.titleMedium!.copyWith(
            color: color,
            fontSize: fontSize,
            letterSpacing: 0.6,
          ),
        ),
      ),
    );
  }
}
