import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/calculator/presentation/controllers/calculator_controller.dart';

class InterestRateSection extends StatefulWidget {
  final TextEditingController? controller;
  const InterestRateSection({super.key, this.controller});

  @override
  State<InterestRateSection> createState() => _InterestRateSectionState();
}

class _InterestRateSectionState extends State<InterestRateSection> {
  late TextEditingController _controller;
  final controller = Get.find<CalculatorController>();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(() {
      controller.interestRate.value = _controller.text;
    });
  }

  void _onRateSelected(String rate) {
    setState(() {
      _controller.text = rate;
      controller.interestRate.value = rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interest Rate',
          style: context.text.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const VerticalSpacing(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: AppTextFormField(
                controller: _controller,
                hintText: 'e.g. 2 or 3',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 15,
                ),
                textInputType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 14),
                  child: Icon(
                    Icons.percent,
                    color: AppColors.appGreen,
                    size: 26,
                  ),
                ),
              ),
            ),
            const HorizontalSpacing(12),
            Obx(() => _RateButton(
                  label: 'Rs. 2',
                  isSelected: controller.interestRate.value == '2',
                  onTap: () => _onRateSelected('2'),
                )),
            const HorizontalSpacing(8),
            Obx(() => _RateButton(
                  label: 'Rs. 3',
                  isSelected: controller.interestRate.value == '3',
                  onTap: () => _onRateSelected('3'),
                )),
          ],
        ),
      ],
    );
  }
}

class _RateButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RateButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final isDark = context.theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54, // Match default height of TextFormField
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? colorScheme.primary
                  : (isDark ? colorScheme.surface : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isSelected
                    ? colorScheme.primary
                    : (isDark ? colorScheme.outline : const Color(0xFFD1D5DB)),
            width: 1.2,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: context.text.bodyMedium?.copyWith(
            color: isSelected ? Colors.white : Color(0xFF9CA3AF),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
