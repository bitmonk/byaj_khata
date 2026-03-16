import 'package:byaz_track/core/constants/app_colors.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/core/theme/theme_controller.dart';
import 'package:byaz_track/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  final ThemeController _themeController = ThemeController.instance;
  int _selectedAccent = 0;

  List<_ThemeModeOption> get _modes => [
    _ThemeModeOption(
      title: AppLocalizations.of(context)?.light ?? 'Light',
      icon: Icons.wb_sunny_outlined,
      mode: ThemeMode.light,
    ),
    _ThemeModeOption(
      title: AppLocalizations.of(context)?.dark ?? 'Dark',
      icon: Icons.nightlight_round,
      mode: ThemeMode.dark,
    ),
    _ThemeModeOption(
      title: AppLocalizations.of(context)?.system ?? 'System Default',
      icon: Icons.brightness_auto,
      mode: ThemeMode.system,
    ),
  ];

  final List<_AccentOption> _accents = [
    _AccentOption(label: 'Forest', color: const Color(0xFF228B22)),
    _AccentOption(label: 'Teal', color: const Color(0xFF009688)),
    _AccentOption(label: 'Blue', color: const Color(0xFF2196F3)),
    _AccentOption(label: 'Purple', color: const Color(0xFF9C27B0)),
  ];

  int get _selectedMode =>
      _modes.indexWhere((m) => m.mode == _themeController.themeMode);

  @override
  Widget build(BuildContext context) {
    final accent = _accents[_selectedAccent].color;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.theme ?? 'Theme',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Theme.of(context).textTheme.headlineMedium?.color,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).textTheme.headlineMedium?.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Theme.of(context).dividerColor, height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          24,
          24,
          24,
          context.devicePaddingBottom + 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // COLOR MODE
            Text(
              AppLocalizations.of(context)?.colorMode ?? 'Color Mode',
              style: context.textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                // letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(_modes.length, (index) {
              final mode = _modes[index];
              final isSelected = _selectedMode == index;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () {
                    _themeController.setThemeMode(_modes[index].mode);
                    setState(() {});
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? accent.withOpacity(0.04)
                              : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color:
                            isSelected
                                ? accent
                                : Theme.of(
                                  context,
                                ).dividerColor.withOpacity(0.6),
                        width: isSelected ? 2 : 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          mode.icon,
                          color: isSelected ? accent : AppColors.secondaryText,
                          size: 24,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            mode.title,
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                          ),
                        ),
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color:
                              isSelected
                                  ? accent
                                  : Theme.of(context).dividerColor,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 28),

            // ACCENT COLOR
            Text(
              'ACCENT COLOR',
              style: context.textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: List.generate(_accents.length, (index) {
                final a = _accents[index];
                final isSelected = _selectedAccent == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedAccent = index),
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: a.color,
                            shape: BoxShape.circle,
                            border:
                                isSelected
                                    ? Border.all(color: a.color, width: 3)
                                    : null,
                            boxShadow:
                                isSelected
                                    ? [
                                      BoxShadow(
                                        color: a.color.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                    : null,
                          ),
                          child:
                              isSelected
                                  ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 26,
                                  )
                                  : null,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          a.label,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight:
                                isSelected
                                    ? FontWeight.w700
                                    : FontWeight.normal,
                            color:
                                isSelected
                                    ? Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.color
                                    : Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),

            // PREVIEW
            Text(
              'PREVIEW',
              style: context.textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.03),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: accent.withOpacity(0.25), width: 1.5),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: accent.withOpacity(0.15),
                    child: Icon(Icons.person, color: accent, size: 26),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rajesh Kumar',
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Last payment 2 days ago',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹12,450',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: accent,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'PRINCIPAL',
                        style: context.textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          fontSize: 11,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
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

class _ThemeModeOption {
  final String title;
  final IconData icon;
  final ThemeMode mode;
  _ThemeModeOption({
    required this.title,
    required this.icon,
    required this.mode,
  });
}

class _AccentOption {
  final String label;
  final Color color;
  _AccentOption({required this.label, required this.color});
}
