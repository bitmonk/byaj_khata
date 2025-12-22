import 'package:byaz_track/core/language/language_controller.dart';
import 'package:byaz_track/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final languageController = LanguageController.instance;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.selectLanguage)),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            RadioListTile<String>(
              title: const Text('English'),
              value: 'en',
              groupValue: languageController.locale.languageCode,
              onChanged: (value) {
                if (value != null) {
                  languageController.setLanguage(value);
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('नेपाली (Nepali)'),
              value: 'ne',
              groupValue: languageController.locale.languageCode,
              onChanged: (value) {
                if (value != null) {
                  languageController.setLanguage(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
