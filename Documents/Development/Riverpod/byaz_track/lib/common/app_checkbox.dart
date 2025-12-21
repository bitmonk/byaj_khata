import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:byaz_track/core/extension/extensions.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({required this.value, super.key, this.onChanged});
  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.h,
      width: 24.w,
      child: Checkbox(
        side: WidgetStateBorderSide.resolveWith(
          (states) => BorderSide(
            width: states.contains(WidgetState.selected) ? 4 : 2,
            color:
                states.contains(WidgetState.selected)
                    ? AppColors.primary500
                    : AppColors.neutral100,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        fillColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected)
                  ? AppColors.primary500
                  : AppColors.colorWhite,
        ),
        value: value,
        onChanged: onChanged,
        checkColor: Colors.white,
      ),
    );
  }
}
