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
        Obx(() {
          final isByajType = controller.interestType.value == 0;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: AppTextFormField(
                  controller: _controller,
                  hintText: isByajType ? 'e.g. 2 or 3' : 'e.g. 12 or 18',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 15,
                  ),
                  textInputType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child:
                        isByajType
                            ? Center(
                              widthFactor: 1,
                              child: Text(
                                'रु',
                                style: TextStyle(
                                  color: AppColors.appGreen,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                            : const Icon(
                              Icons.percent,
                              color: AppColors.appGreen,
                              size: 26,
                            ),
                  ),
                ),
              ),
              const HorizontalSpacing(12),
              _RateButton(
                label: isByajType ? 'Rs. 2' : '12%',
                isSelected:
                    isByajType
                        ? controller.interestRate.value == '2'
                        : controller.interestRate.value == '12',
                onTap: () => _onRateSelected(isByajType ? '2' : '12'),
              ),
              const HorizontalSpacing(8),
              _RateButton(
                label: isByajType ? 'Rs. 3' : '18%',
                isSelected:
                    isByajType
                        ? controller.interestRate.value == '3'
                        : controller.interestRate.value == '18',
                onTap: () => _onRateSelected(isByajType ? '3' : '18'),
              ),
            ],
          );
        }),
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
