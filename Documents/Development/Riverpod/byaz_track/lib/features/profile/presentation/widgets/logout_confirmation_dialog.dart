import 'package:byaz_track/core/extension/extensions.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final bool isLoading;

  const LogoutConfirmationDialog({
    super.key,
    required this.onConfirm,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                    isDark
                        ? const Color(0xFF1B3219)
                        : colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.logout,
                color: isDark ? const Color(0xFF2E7D32) : colorScheme.primary,
                size: 28,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Log Out?',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : colorScheme.onSurface,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Are you sure you want to log out? You will need to sign in again to sync your data.',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color:
                    isDark
                        ? Colors.white.withOpacity(0.7)
                        : colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF188018),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  onConfirm(); // Execute logout logic
                },
                child:
                    isLoading
                        ? LoadingAnimationWidget.beat(
                          color: Colors.white,
                          size: 24,
                        )
                        : const Text(
                          'Log Out',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor:
                      isDark
                          ? Colors.white.withOpacity(0.8)
                          : colorScheme.onSurfaceVariant,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
