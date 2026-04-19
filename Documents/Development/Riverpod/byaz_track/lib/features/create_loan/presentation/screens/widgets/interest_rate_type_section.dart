import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/create_loan/presentation/controllers/create_loan_controller.dart';

class InterestRateTypeSection extends StatelessWidget {
  const InterestRateTypeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateLoanController>();
    final isDark = context.theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // color:
        //     isDark
        //         ? const Color(0xFF161B12)
        //         : const Color(
        //           0xFFF9FAF8,
        //         ), // light tint green/gray based on image
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? const Color(0xFF2D3628) : const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Interest Rate Type',
            style: context.text.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563),
            ),
          ),
          const VerticalSpacing(16),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => _SelectorCard(
                    title: 'Rupee (per 100)',
                    isSelected: controller.interestRateType.value == 0,
                    onTap: () => controller.interestRateType.value = 0,
                  ),
                ),
              ),
              const HorizontalSpacing(12),
              Expanded(
                child: Obx(
                  () => _SelectorCard(
                    title: 'Percentage (%)',
                    isSelected: controller.interestRateType.value == 1,
                    onTap: () => controller.interestRateType.value = 1,
                  ),
                ),
              ),
            ],
          ),
          const VerticalSpacing(24),
          Text(
            'Rate Value',
            style: context.text.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              // color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563),
            ),
          ),
          const VerticalSpacing(12),
          AppTextFormField(
            labelText: 'e.g. 2 or 18',
            hintStyle: context.text.bodyLarge?.copyWith(
              color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
              fontSize: 18,
            ),
            textInputType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) => controller.rateValue.value = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a rate value';
              }
              if (double.tryParse(value) == null || double.parse(value) <= 0) {
                return 'Please enter a valid rate';
              }
              return null;
            },
            fillColor:
                Colors
                    .transparent, // remove default fill color since it behaves like plain text input on image
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Text(
                      controller.interestRateType.value == 0
                          ? 'per month'
                          : 'per annum',
                      style: context.text.bodyMedium?.copyWith(
                        color:
                            isDark
                                ? const Color(0xFF9CA3AF)
                                : const Color(0xFF4B5563),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const VerticalSpacing(24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Icon(
                  Icons.info_outline,
                  size: 18,
                  color:
                      isDark
                          ? const Color(0xFF9CA3AF)
                          : const Color(0xFF4B5563),
                ),
              ),
              const HorizontalSpacing(8),
              Expanded(
                child: Text(
                  "In Nepali context, '2 Rupee' usually means \n2% per month (24% per annum).",
                  style: context.text.bodyMedium?.copyWith(
                    color:
                        isDark
                            ? const Color(0xFF9CA3AF)
                            : const Color(0xFF4B5563),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SelectorCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectorCard({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Theme.of(context).colorScheme.primary
                  : (isDark
                      ? Theme.of(context).colorScheme.surface
                      : Colors.white),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color:
                isSelected
                    ? Theme.of(context).colorScheme.primary
                    : (isDark
                        ? const Color(0xFF2D3628)
                        : const Color(0xFFE5E7EB)),
            width: 1,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: context.text.bodyMedium?.copyWith(
            color:
                isSelected
                    ? Colors.white
                    : (isDark ? Colors.white : AppColors.primaryText),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
