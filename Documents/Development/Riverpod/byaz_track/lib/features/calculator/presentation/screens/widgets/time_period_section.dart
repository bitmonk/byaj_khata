import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/calculator/presentation/controllers/calculator_controller.dart';
import 'package:byaz_track/features/calculator/presentation/screens/widgets/nepali_calendar.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class TimePeriodSection extends StatelessWidget {
  const TimePeriodSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CalculatorController>();
    final colorScheme = context.theme.colorScheme;
    final isDark = context.theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time Period',
              style: context.text.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Obx(() {
              if (controller.startDate.value == null &&
                  controller.endDate.value == null) {
                return const SizedBox.shrink();
              }
              return GestureDetector(
                onTap: () {
                  controller.setStartDate(null);
                  controller.setEndDate(null);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Text(
                    'Clear',
                    style: context.text.bodyMedium?.copyWith(
                      color: AppColors.appRed,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
        const VerticalSpacing(10),
        GestureDetector(
          onTap: () async {
            final start = await NepaliCalendar.show(
              context,
              initialDate: controller.startDate.value,
            );
            if (start != null) {
              controller.setStartDate(start);

              // Ensure end date is not before start date
              if (controller.endDate.value != null &&
                  controller.endDate.value!.isBefore(start)) {
                controller.setEndDate(start);
              }

              if (context.mounted) {
                final end = await NepaliCalendar.show(
                  context,
                  initialDate: controller.endDate.value ?? start,
                  firstDate: start,
                );
                if (end != null) {
                  controller.setEndDate(end);
                }
              }
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
                        'Select Date Range',
                        style: context.text.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: isDark ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                      const VerticalSpacing(4),
                      Obx(() {
                        final start = controller.startDate.value;
                        final end = controller.endDate.value;

                        if (start == null && end == null) {
                          return Text(
                            'Tap to select date range',
                            style: context.text.labelLarge?.copyWith(
                              color: AppColors.subTitle,
                              fontSize: 14,
                            ),
                          );
                        }

                        final startStr =
                            start != null
                                ? NepaliDateFormat('yyyy-MM-dd').format(start)
                                : 'Select Start';
                        final endStr =
                            end != null
                                ? NepaliDateFormat('yyyy-MM-dd').format(end)
                                : 'Select End';

                        return Text(
                          'From: $startStr  To: $endStr',
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
