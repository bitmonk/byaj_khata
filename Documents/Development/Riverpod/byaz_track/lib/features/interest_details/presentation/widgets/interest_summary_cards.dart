import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/create_loan/data/model/loan_model.dart';

class InterestSummaryCards extends StatelessWidget {
  final LoanModel? loan;
  const InterestSummaryCards({super.key, this.loan});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final borderColor =
        isDark ? AppColorsDark.dividerColor : const Color(0xFFC3D0C3);
    final textColorPrimary =
        isDark ? AppColorsDark.textPrimary : const Color(0xFF1E1E1E);
    final textColorSecondary =
        isDark ? AppColorsDark.textSecondary : const Color(0xFF5A5A5A);

    String primaryRateText = '-';
    String secondaryRateText = '-';

    if (loan != null) {
      final rateStr =
          loan!.rateValue == loan!.rateValue.truncateToDouble()
              ? loan!.rateValue.toInt().toString()
              : loan!.rateValue.toString();

      if (loan!.interestType == '1') {
        primaryRateText = '$rateStr% / yr';
        final monthly = loan!.rateValue / 12;
        final monthlyStr =
            monthly == monthly.truncateToDouble()
                ? monthly.toInt().toString()
                : monthly.toStringAsFixed(2);
        secondaryRateText = 'रू $monthlyStr / mo';
      } else {
        primaryRateText = 'रू $rateStr / mo';
        final yearly = loan!.rateValue * 12;
        final yearlyStr =
            yearly == yearly.truncateToDouble()
                ? yearly.toInt().toString()
                : yearly.toStringAsFixed(2);
        secondaryRateText = '$yearlyStr% Yearly';
      }
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Principal (Sawa)',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: textColorSecondary,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'रू ${loan?.principalAmount ?? 0}',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: textColorPrimary,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Interest Rate',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: textColorSecondary,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    primaryRateText,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: textColorPrimary,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    secondaryRateText,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: textColorSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
