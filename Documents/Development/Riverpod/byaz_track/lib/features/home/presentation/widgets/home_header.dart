import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color;
    final user = Supabase.instance.client.auth.currentUser;
    final fullName =
        user?.userMetadata?['full_name'] ??
        user?.userMetadata?['name'] ??
        'User';
    final firstName = fullName.split(' ').first;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Namaste, $firstName',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Your interest overview for today',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: textColor?.withOpacity(0.75),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: theme.dividerColor.withOpacity(0.55),
              width: 1.2,
            ),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none,
              color: theme.iconTheme.color,
              size: 24,
            ),
            splashRadius: 22,
          ),
        ),
      ],
    );
  }
}
