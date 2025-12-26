import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SquareFeatureCard extends StatelessWidget {
  const SquareFeatureCard({
    super.key,
    required this.title,
    this.icon,
    required this.onTap,
    this.backgroundColor,
    this.amount,
  });

  final String title;
  final String? amount;
  final IconData? icon;
  final VoidCallback onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        // color: AppColors.primary25, // Remove fallback to let theme handle it
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(icon, size: 48, color: Get.theme.colorScheme.primary),
            if (amount != null)
              Text(
                AppLocalizations.of(context)?.currency ?? 'Rs',
                textAlign: TextAlign.left,
              ),
            Text(
              amount ?? '0',
              textAlign: TextAlign.center,
              style: context.text.titleMedium?.copyWith(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
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
