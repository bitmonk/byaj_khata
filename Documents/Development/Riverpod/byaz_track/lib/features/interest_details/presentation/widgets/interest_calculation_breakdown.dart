import 'package:byaz_track/core/extension/extensions.dart';

class InterestCalculationBreakdown extends StatelessWidget {
  const InterestCalculationBreakdown({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final borderColor =
        isDark
            ? AppColorsDark.dividerColor
            : const Color(0xFFC3D0C3); // Faint greenish gray
    final textColorPrimary =
        isDark ? AppColorsDark.textPrimary : const Color(0xFF1E1E1E);
    final textColorSecondary =
        isDark ? AppColorsDark.textSecondary : const Color(0xFF5A5A5A);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Calculation Breakdown',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: textColorPrimary,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(24),
            color: isDark ? theme.colorScheme.surface : Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CalculationStepRow(
                number: '1',
                title: 'Monthly Interest',
                calculation: 'रू 5,00,000 × 2% = रू 10,000',
              ),
              const SizedBox(height: 24),
              _CalculationStepRow(
                number: '2',
                title: 'Full Months (14)',
                calculation: 'रू 10,000 × 14 = रू 1,40,000',
              ),
              const SizedBox(height: 24),
              _CalculationStepRow(
                number: '3',
                title: 'Extra Days (7)',
                calculation: 'रू 333.33/day × 7 = रू 2,333',
              ),
              const SizedBox(height: 32),
              Divider(color: borderColor, thickness: 1),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Byaj',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: textColorSecondary.withOpacity(0.9),
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'रू 1,42,333',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: textColorPrimary,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CalculationStepRow extends StatelessWidget {
  final String number;
  final String title;
  final String calculation;

  const _CalculationStepRow({
    required this.number,
    required this.title,
    required this.calculation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final numberColor =
        isDark ? AppColorsDark.success500 : const Color(0xFF2E8B57);
    final textColorPrimary =
        isDark ? AppColorsDark.textPrimary : const Color(0xFF1E1E1E);
    final textColorSecondary =
        isDark ? AppColorsDark.textSecondary : const Color(0xFF5A5A5A);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 32,
          child: Text(
            number,
            style: theme.textTheme.titleLarge?.copyWith(
              color: numberColor,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textColorPrimary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                calculation,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: textColorSecondary,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
