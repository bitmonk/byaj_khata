import 'package:byaz_track/core/extension/extensions.dart';

enum LedgerItemStatus { active, settled, overdue }

class LedgerListItemCard extends StatelessWidget {
  final String name;
  final String loanedDate;
  final LedgerItemStatus status;
  final String principalAmount;
  final String interestAmount;
  final String interestRateText;
  final String lastCollectedDate;

  const LedgerListItemCard({
    super.key,
    required this.name,
    required this.loanedDate,
    required this.status,
    required this.principalAmount,
    required this.interestAmount,
    required this.interestRateText,
    required this.lastCollectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardColor = isDark ? theme.colorScheme.surface : Colors.white;
    final borderColor =
        isDark
            ? AppColorsDark.dividerColor
            : AppColors.dividerColor.withOpacity(0.5);

    // Dynamic Status Colors
    Color statusBgColor;
    Color statusTextColor;
    String statusText;

    switch (status) {
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

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
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
                      name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: textColorPrimary,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Loaned on $loanedDate',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: textColorSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(16),
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

          const SizedBox(height: 16),
          Divider(color: borderColor, thickness: 1),
          const SizedBox(height: 16),

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
                    const SizedBox(height: 4),
                    Text(
                      principalAmount,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: textColorPrimary,
                        fontSize: 20,
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
                      'Interest ($interestRateText)',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: textColorSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      interestAmount,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.success,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Footer: Last Collected
          Row(
            children: [
              Icon(
                Icons.history,
                size: 16,
                color: textColorSecondary.withOpacity(0.8),
              ),
              const SizedBox(width: 6),
              Text(
                'Last collected: $lastCollectedDate',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: textColorSecondary.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
