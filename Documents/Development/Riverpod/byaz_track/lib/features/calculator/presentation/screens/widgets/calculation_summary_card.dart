import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/calculator/presentation/controllers/calculator_controller.dart';

class CalculationSummaryCard extends StatelessWidget {
  const CalculationSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CalculatorController>();
    final isDark = context.theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161B12) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? const Color(0xFF2D3628) : const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Calculation Summary',
                style: context.text.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: isDark ? Colors.white : AppColors.primaryText,
                ),
              ),
            ],
          ),
          const VerticalSpacing(24),
          _SummaryItem(
            label: 'Principal (Sawa)',
            value: Obx(
              () => Text(
                'रु ${controller.principalAmount.value.isEmpty ? "0" : controller.principalAmount.value}',
              ),
            ),
          ),
          const VerticalSpacing(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _SummaryLabel(label: 'Total Interest (Byaj)'),
              Row(
                children: [
                  Obx(
                    () => Text(
                      'रु ${controller.totalInterestStr}',
                      style: context.text.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: isDark ? Colors.white : AppColors.primaryText,
                      ),
                    ),
                  ),
                  const HorizontalSpacing(8),
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isDark
                                ? const Color(0xFF22281D)
                                : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '+${controller.interestPercentageStr}',
                        style: context.text.labelSmall?.copyWith(
                          color:
                              isDark
                                  ? const Color(0xFF9CA3AF)
                                  : AppColors.secondaryText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const VerticalSpacing(20),
          const Divider(color: Color(0xFF30363D), height: 1),
          const VerticalSpacing(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: context.text.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: isDark ? Colors.white : AppColors.primaryText,
                ),
              ),
              Obx(
                () => Text(
                  'रु ${controller.totalAmountStr}',
                  style: context.text.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: AppColors.appGreen,
                  ),
                ),
              ),
            ],
          ),
          const VerticalSpacing(20),
          Container(
            height: 10,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.appGreen.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.7, // Stylized progress
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.appGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final Widget value;

  const _SummaryItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _SummaryLabel(label: label),
        DefaultTextStyle(
          style:
              context.text.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: isDark ? Colors.white : AppColors.primaryText,
              ) ??
              const TextStyle(),
          child: value,
        ),
      ],
    );
  }
}

class _SummaryLabel extends StatelessWidget {
  final String label;
  const _SummaryLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: context.text.bodyMedium?.copyWith(
        color: const Color(0xFF9CA3AF),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
