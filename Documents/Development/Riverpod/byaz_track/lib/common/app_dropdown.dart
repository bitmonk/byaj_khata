import 'package:byaz_track/core/extension/extensions.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    required this.items,
    super.key,
    this.value,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.validator,
    this.prefixIcon,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.fillColor = AppColors.white,
    this.focusedBorderColor = AppColors.neutral50,
    this.enabledBorderColor = AppColors.textColor200,
    this.borderWidth = 1.0,
    this.hintStyle,
    this.icon,
    this.labelStyle,
    this.style,
    this.errorStyle,
    this.filled = true,
  });

  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? hintText;
  final String? labelText;
  final String? Function(T?)? validator;
  final Widget? prefixIcon;
  final BorderRadius borderRadius;
  final Color fillColor;
  final Icon? icon;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final double borderWidth;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final TextStyle? errorStyle;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: fillColor, // Set dropdown popup background color
      ),
      child: DropdownButtonFormField<T>(
        value: value,
        items:
            items.map((DropdownMenuItem<T> item) {
              return DropdownMenuItem<T>(
                value: item.value,
                child: DefaultTextStyle(
                  style: context.text.titleMedium!,
                  child: item.child,
                ),
              );
            }).toList(),
        onChanged: onChanged,
        validator: validator,
        icon: icon,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: labelText,
          labelStyle:
              labelStyle ??
              AppTextStyles.titleSm.copyWith(
                color: AppColors.textColor100,
                fontSize: 16,
              ),
          filled: filled,
          fillColor: fillColor,
          hintText: hintText,
          hintStyle:
              hintStyle ??
              AppTextStyles.titleMd.copyWith(
                color: AppColors.textColor50,
                fontWeight: FontWeight.w400,
              ),
          contentPadding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: enabledBorderColor,
              width: borderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: focusedBorderColor,
              width: borderWidth,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: AppColors.colorRed,
              width: borderWidth,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color: AppColors.appRed, width: borderWidth),
          ),
          errorStyle:
              errorStyle ??
              context.text.titleMedium!.copyWith(
                color: AppColors.colorRed,
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
          suffixIconConstraints: const BoxConstraints(
            maxHeight: 36,
            minWidth: 40,
          ),
          prefixIcon: prefixIcon,
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 24,
            minWidth: 24,
          ),
        ),
        style:
            style ??
            context.text.titleMedium!.copyWith(
              color: Colors.white, // Set dropdown selected text color
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }
}
