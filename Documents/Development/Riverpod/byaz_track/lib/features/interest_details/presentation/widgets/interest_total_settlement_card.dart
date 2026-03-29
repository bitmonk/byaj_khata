import 'package:byaz_track/core/extension/extensions.dart';

class InterestTotalSettlementCard extends StatelessWidget {
  const InterestTotalSettlementCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // Using colors directly matching the reference design for immediate visual accuracy
    const cardColor = Color(0xFF267D25); // Deep green
    final borderColor =
        isDark
            ? AppColorsDark.dividerColor
            : const Color(0xFFC3D0C3); // Faint greenish gray
    const contentColor = Color(0xFF0B3626); // Very dark green/slate for text

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          decoration: BoxDecoration(
            // color: cardColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'TOTAL SETTLEMENT AMOUNT',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: contentColor,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'रू  ',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: contentColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: '6,42,333',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: contentColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(
                      color: contentColor.withOpacity(0.2),
                      thickness: 1,
                      width: 24,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Principal: रू 5,00,000',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: contentColor.withOpacity(0.8),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Interest: रू 1,42,333',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: contentColor.withOpacity(0.8),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
