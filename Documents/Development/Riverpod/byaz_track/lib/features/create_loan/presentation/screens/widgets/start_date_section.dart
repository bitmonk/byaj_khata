import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/create_loan/presentation/controllers/create_loan_controller.dart';
import 'package:byaz_track/features/calculator/presentation/screens/widgets/nepali_calendar.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class StartDateSection extends StatelessWidget {
  const StartDateSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateLoanController>();
    final colorScheme = context.theme.colorScheme;
    final isDark = context.theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Start Date',
          style: context.text.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const VerticalSpacing(10),
        GestureDetector(
          onTap: () async {
            final start = await NepaliCalendar.show(
              context,
              initialDate: controller.startDate.value ?? NepaliDateTime.now(),
            );
            if (start != null) {
              controller.setStartDate(start);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? colorScheme.surface : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? colorScheme.outline : const Color(0xFFD1D5DB),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.appGreen,
                  size: 32,
                ),
                const HorizontalSpacing(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Start Date',
                        style: context.text.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: isDark ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                      const VerticalSpacing(4),
                      Obx(() {
                        final startStr =
                            controller.startDate.value != null
                                ? NepaliDateFormat(
                                  'yyyy-MM-dd',
                                ).format(controller.startDate.value!)
                                : 'Select Date';

                        return Text(
                          startStr,
                          style: context.text.labelLarge?.copyWith(
                            color: AppColors.subTitle,
                            fontSize: 14,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: isDark ? Colors.white : AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
