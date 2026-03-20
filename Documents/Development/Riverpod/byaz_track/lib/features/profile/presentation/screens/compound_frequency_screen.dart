import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CompoundFrequencyScreen extends StatefulWidget {
  const CompoundFrequencyScreen({super.key});

  @override
  State<CompoundFrequencyScreen> createState() =>
      _CompoundFrequencyScreenState();
}

class _CompoundFrequencyScreenState extends State<CompoundFrequencyScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final List<_FrequencyOption> options = [
      _FrequencyOption(
        title: l10n?.monthly ?? 'Monthly',
        description:
            l10n?.monthlyDescription ??
            'Interest is added to the principal every month.',
      ),
      _FrequencyOption(
        title: l10n?.yearly ?? 'Yearly',
        description:
            l10n?.yearlyDescription ??
            'Interest is added to the principal once a year.',
      ),
      // _FrequencyOption(
      //   title: l10n?.custom ?? 'Custom',
      //   description: 'Set a custom frequency for interest compounding.',
      // ),
    ];

    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          l10n?.compoundFrequency ?? 'Compound Frequency',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: context.textTheme.headlineMedium?.color,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: context.textTheme.headlineMedium?.color,
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
      body: Padding(
        padding: EdgeInsets.only(top: context.devicePaddingTop > 0 ? 0 : 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.compoundFrequency ?? 'Compound Frequency',
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n?.frequencyDescription ??
                          'Choose how often interest is added to the principal to be calculated again.',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.textTheme.bodyMedium?.color,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ...List.generate(options.length, (index) {
                      final option = options[index];
                      final isSelected = _selectedIndex == index;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildOptionCard(
                          option: option,
                          isSelected: isSelected,
                          onTap: () => setState(() => _selectedIndex = index),
                        ),
                      );
                    }),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: colorScheme.primary,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              l10n?.frequencyDisclaimer ??
                                  'This will be used for compounding interest calculations in all new ledgers.',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.textTheme.bodyMedium?.color,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                24,
                16,
                24,
                context.devicePaddingBottom + 24,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: Text(l10n?.savePreferenceButton ?? 'Save'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required _FrequencyOption option,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.04)
                  : Theme.of(context).cardTheme.color ??
                      Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).dividerColor.withOpacity(0.6),
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.title,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    option.description,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color:
                          isSelected
                              ? Theme.of(context).colorScheme.primary
                              : context.textTheme.bodyMedium?.color,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color:
                    isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).dividerColor,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FrequencyOption {
  final String title;
  final String description;

  _FrequencyOption({required this.title, required this.description});
}
