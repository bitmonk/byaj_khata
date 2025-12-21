// features/dashboard/presentation/widgets/square_feature_card.dart
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:flutter/material.dart';

class SquareFeatureCard extends StatelessWidget {
  const SquareFeatureCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: backgroundColor, // Remove fallback to let theme handle it
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Get.theme.colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.text.titleMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Icon(icon, size: 48, color: AppColors.foundation500),
        //     const SizedBox(height: 16),
        //     Text(
        //       title,
        //       textAlign: TextAlign.center,
        //       style: context.text.titleMedium?.copyWith(
        //         fontSize: 16,
        //         fontWeight: FontWeight.w600,
        //         color: AppColors.neutral900,
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
