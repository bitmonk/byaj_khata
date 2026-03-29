import 'package:byaz_track/core/extension/extensions.dart';

class InterestActionButtons extends StatelessWidget {
  const InterestActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final borderColor =
        isDark ? AppColorsDark.dividerColor : const Color(0xFFC3D0C3);
    final primaryColor = const Color(0xFF268E2A); // Matching screenshot green
    final darkTextColor =
        isDark ? AppColorsDark.textPrimary : const Color(0xFF1E1E1E);
    final darkGreenText = const Color(
      0xFF0C2B1D,
    ); // Dark text on green background

    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              side: BorderSide(color: borderColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              backgroundColor:
                  isDark ? theme.colorScheme.surface : Colors.white,
            ),
            icon: Icon(Icons.add_circle_outline, color: darkTextColor),
            label: Text(
              'Add Payment',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: darkTextColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 0,
            ),
            icon: Icon(Icons.check_circle_outline, color: AppColors.white),
            label: Text(
              'Settle Loan',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
