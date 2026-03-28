import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/create_loan/presentation/controllers/create_loan_controller.dart';

class TransactionTypeSection extends StatelessWidget {
  const TransactionTypeSection({super.key});

  @override
  Widget build(BuildContext context) {
    // using Get.put if controller hasn't been put yet, or just Get.find because Dashboard initializes or bindings initialize it.
    // Let's ensure it's found. Since mason generated create_loan_bindings, it might be bound. But just to be sure...
    final controller = Get.find<CreateLoanController>();
    final isDark = context.theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transaction Type',
          style: context.text.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563),
          ),
        ),
        const VerticalSpacing(12),
        Row(
          children: [
            Expanded(
              child: Obx(
                () => _SelectorCard(
                  title: 'I Lent (Investment)',
                  isSelected: controller.transactionType.value == 0,
                  onTap: () => controller.transactionType.value = 0,
                ),
              ),
            ),
            const HorizontalSpacing(12),
            Expanded(
              child: Obx(
                () => _SelectorCard(
                  title: 'I Borrowed (Debt)',
                  isSelected: controller.transactionType.value == 1,
                  onTap: () => controller.transactionType.value = 1,
                ),
              ),
            ),
          ],
        ),
      ],
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
