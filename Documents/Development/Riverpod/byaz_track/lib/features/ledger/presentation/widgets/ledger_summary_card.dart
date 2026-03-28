import 'package:byaz_track/core/extension/extensions.dart';

class LedgerSummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final String trendPercentage;
  final bool isPositiveTrend;

  const LedgerSummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.trendPercentage,
    required this.isPositiveTrend,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final surfaceColor =
        isDark ? AppColorsDark.surfaceBackground : AppColors.cardBackground;
    final titleColor =
        isDark ? AppColorsDark.textSecondary : AppColors.textSecondary;
    final amountColor =
        theme.textTheme.titleLarge?.color ??
        (isDark ? AppColorsDark.textPrimary : AppColors.textPrimary);
    final trendColor = isPositiveTrend ? AppColors.success : AppColors.error;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).colorScheme.surface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              isDark
                  ? AppColorsDark.dividerColor
                  : AppColors.dividerColor.withOpacity(0.5),
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: titleColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            amount,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: amountColor,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                isPositiveTrend ? Icons.trending_up : Icons.trending_down,
                color: trendColor,
                size: 18,
              ),
              const SizedBox(width: 4),
              Text(
                trendPercentage,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: trendColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
