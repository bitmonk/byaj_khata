import 'package:byaz_track/core/extension/extensions.dart';

class InterestProfileHeader extends StatelessWidget {
  const InterestProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final textColorPrimary =
        isDark ? AppColorsDark.textPrimary : AppColors.textPrimary;
    final textColorSecondary =
        isDark ? AppColorsDark.textSecondary : AppColors.textSecondary;

    final badgeBgColor =
        isDark
            ? AppColorsDark.success100.withOpacity(0.1)
            : const Color(0xFFEAF5EA);
    final badgeColor =
        isDark
            ? AppColorsDark.success500
            : const Color(0xFF2E8B57); // Green shade

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: badgeColor,
          child: Text(
            'JD',
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Doe',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: textColorPrimary,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: textColorSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Started: 15 Jestha, 2080',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: textColorSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: badgeBgColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: badgeColor),
          ),
          child: Text(
            'Active',
            style: theme.textTheme.labelLarge?.copyWith(
              color: badgeColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
