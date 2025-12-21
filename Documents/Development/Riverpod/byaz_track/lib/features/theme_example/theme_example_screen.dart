import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:byaz_track/core/theme/theme_controller.dart';
import 'package:byaz_track/core/widgets/theme_toggle_widget.dart';
import 'package:byaz_track/core/extension/extensions.dart';

/// Example screen showing how to use the theme system
class ThemeExampleScreen extends StatelessWidget {
  const ThemeExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Example'),
        actions: [
          // Simple toggle button in app bar
          const ThemeToggleButton(),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Mode Selector Widget
            const Text(
              'Select Theme Mode:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            const ThemeToggleWidget(),

            const SizedBox(height: 32),

            // Current Theme Status
            Obx(
              () => Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Theme Status',
                        style: context.text.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      _StatusRow(
                        'Theme Mode:',
                        themeController.themeMode
                            .toString()
                            .split('.')
                            .last
                            .toUpperCase(),
                      ),
                      _StatusRow(
                        'Is Dark Mode:',
                        themeController.isDarkMode ? 'Yes' : 'No',
                      ),
                      _StatusRow(
                        'Is Light Mode:',
                        themeController.isLightMode ? 'Yes' : 'No',
                      ),
                      _StatusRow(
                        'Is System Mode:',
                        themeController.isSystemMode ? 'Yes' : 'No',
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Manual Theme Control Buttons
            const Text(
              'Manual Controls:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () => themeController.useLightTheme(),
              icon: const Icon(Icons.light_mode),
              label: const Text('Set Light Theme'),
            ),
            const SizedBox(height: 8),

            ElevatedButton.icon(
              onPressed: () => themeController.useDarkTheme(),
              icon: const Icon(Icons.dark_mode),
              label: const Text('Set Dark Theme'),
            ),
            const SizedBox(height: 8),

            ElevatedButton.icon(
              onPressed: () => themeController.useSystemTheme(),
              icon: const Icon(Icons.brightness_auto),
              label: const Text('Use System Theme'),
            ),
            const SizedBox(height: 8),

            OutlinedButton.icon(
              onPressed: () => themeController.toggleTheme(),
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Toggle Light/Dark'),
            ),

            const SizedBox(height: 32),

            // UI Preview
            const Text(
              'UI Preview:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sample Card', style: context.text.titleMedium),
                    const SizedBox(height: 8),
                    Text(
                      'This is how cards look in the current theme. The background and text colors automatically adapt.',
                      style: context.text.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => themeController.toggleTheme(),
        child: Obx(
          () => Icon(
            themeController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          ),
        ),
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatusRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(
            value,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
