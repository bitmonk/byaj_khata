import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:byaz_track/core/theme/theme_controller.dart';
import 'package:byaz_track/core/extension/extensions.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      backgroundColor: Get.theme.cardColor,
      appBar: AppBar(title: const Text('Appearance'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose your interface color:',
              style: context.text.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),

            // Three theme options in a Facebook-style layout
            Obx(
              () => Column(
                children: [
                  _ThemeOption(
                    icon: Icons.light_mode_outlined,
                    title: 'Light',
                    description: 'A clean, bright interface',
                    isSelected: themeController.themeMode == ThemeMode.light,
                    onTap: () => themeController.useLightTheme(),
                  ),
                  const SizedBox(height: 12),

                  _ThemeOption(
                    icon: Icons.dark_mode_outlined,
                    title: 'Dark',
                    description: 'Easier on your eyes in low light',
                    isSelected: themeController.themeMode == ThemeMode.dark,
                    onTap: () => themeController.useDarkTheme(),
                  ),
                  const SizedBox(height: 12),

                  _ThemeOption(
                    icon: Icons.brightness_auto_outlined,
                    title: 'System',
                    description: 'Automatically match your system settings',
                    isSelected: themeController.themeMode == ThemeMode.system,
                    onTap: () => themeController.useSystemTheme(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.icon,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        final theme = Theme.of(context);

        // Bright color for selected state
        const brightColor = AppColors.primary600; // Bright cyan/blue

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      isSelected
                          ? brightColor
                          : (isDarkMode
                              ? Colors.grey[700]!
                              : Colors.grey[300]!),
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(12),
                color:
                    isSelected
                        ? brightColor.withOpacity(0.1)
                        : Colors.transparent,
              ),
              child: Row(
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? brightColor
                              : (isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[200]),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 28,
                      color:
                          isSelected
                              ? Colors.white
                              : (isDarkMode
                                  ? Colors.grey[400]
                                  : Colors.grey[700]),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Title and Description
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: context.text.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.headlineLarge?.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                isDarkMode
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Radio Indicator
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            isSelected
                                ? brightColor
                                : (isDarkMode
                                    ? Colors.grey[600]!
                                    : Colors.grey[400]!),
                        width: 2,
                      ),
                    ),
                    child:
                        isSelected
                            ? Center(
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: brightColor,
                                ),
                              ),
                            )
                            : null,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
