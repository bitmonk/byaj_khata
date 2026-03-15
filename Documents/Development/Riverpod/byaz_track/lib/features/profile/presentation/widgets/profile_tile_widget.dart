import 'package:byaz_track/core/extension/extensions.dart';
import 'package:flutter/material.dart';

class ProfileTileWidget extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;

  const ProfileTileWidget({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.trailing,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
        child: Row(
          children: [
            Icon(
              leadingIcon,
              color: iconColor ?? colorScheme.primary,
              size: 24,
            ),
            const HorizontalSpacing(16),
            Expanded(
              child: Text(
                title,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
