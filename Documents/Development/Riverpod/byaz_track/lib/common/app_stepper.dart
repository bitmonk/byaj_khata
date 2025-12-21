import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:byaz_track/core/extension/extensions.dart';

class AppStepper extends StatelessWidget {
  const AppStepper({required this.index, super.key});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        8,
        (i) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color:
                index == i
                    ? AppColors.primary500
                    : AppColors.primary500.withAlpha(51),
            borderRadius: BorderRadius.circular(51.r),
          ),
          height: 6.h,
          width: 20.w,
        ),
      ),
    );
  }
}
