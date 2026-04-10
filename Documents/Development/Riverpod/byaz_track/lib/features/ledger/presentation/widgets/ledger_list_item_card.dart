import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/create_loan/data/model/loan_model.dart';

enum LedgerItemStatus { active, settled, overdue }

class LedgerListItemCard extends StatelessWidget {
  final LoanModel loan;
  final VoidCallback onTap;

  const LedgerListItemCard({
    super.key,
    required this.loan,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardColor = isDark ? theme.colorScheme.surface : Colors.white;
    final borderColor =
        isDark
            ? AppColorsDark.dividerColor
            : const Color(0xFFC3D0C3); // Faint greenish gray

    // Dynamic Status Colors
    Color statusBgColor;
    Color statusTextColor;
    String statusText;

    switch (loan.loanStatus) {
      case LedgerItemStatus.active:
        statusBgColor =
            isDark ? AppColorsDark.neutral700 : const Color(0xFFF1F5F9);
        statusTextColor =
            isDark ? AppColorsDark.textPrimary : AppColors.textPrimary;
        statusText = 'Active';
        break;
      case LedgerItemStatus.settled:
        statusBgColor =
            isDark ? AppColorsDark.success100 : const Color(0xFFDCFCE7);
        statusTextColor =
            isDark ? AppColorsDark.success500 : const Color(0xFF166534);
        statusText = 'Settled';
        break;
      case LedgerItemStatus.overdue:
        statusBgColor =
            isDark ? AppColorsDark.error200 : const Color(0xFFFEE2E2);
        statusTextColor =
            isDark ? AppColorsDark.error500 : const Color(0xFF991B1B);
        statusText = 'Overdue';
        break;
    }

    final textColorPrimary =
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary;
    final textColorSecondary =
        isDark ? AppColorsDark.textSecondary : AppColors.textSecondary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Name & Date + Status Badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loan.partyName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: textColorPrimary,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Loaned on ${loan.startDate.toBS()}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: textColorSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    statusText,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: statusTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),
            Divider(color: borderColor, thickness: 1),
            const SizedBox(height: 6),

            // Middle: Principal & Interest
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Principal (Sawa)',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: textColorSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Rs ${loan.principalAmount}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: textColorPrimary,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Interest (${loan.rateValue}%)',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: textColorSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Rs ${loan.rateValue}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.success,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Footer: Last Collected
            Row(
              children: [
                Icon(
                  Icons.history,
                  size: 14,
                  color: textColorSecondary.withOpacity(0.8),
                ),
                const SizedBox(width: 4),
                Text(
                  'Last collected: N/A',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: textColorSecondary.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
