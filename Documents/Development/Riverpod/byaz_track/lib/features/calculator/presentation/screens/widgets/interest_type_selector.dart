import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/l10n/app_localizations.dart';

class InterestTypeSelector extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelected;

  const InterestTypeSelector({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: _SelectorCard(
            title: 'Byaj (Rs. per 100)',
            isSelected: selectedIndex == 0,
            onTap: () => onSelected(0),
          ),
        ),
        const HorizontalSpacing(12),
        Expanded(
          child: _SelectorCard(
            title: 'Percentage (%)',
            isSelected: selectedIndex == 1,
            onTap: () => onSelected(1),
          ),
        ),
      ],
    );
  }
}

class _SelectorCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectorCard({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final isDark = context.theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? colorScheme.primary
                  : (isDark ? colorScheme.surface : Colors.white),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color:
                isSelected
                    ? colorScheme.primary
                    : (isDark ? colorScheme.outline : const Color(0xFFD1D5DB)),
            width: 1.5,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: context.text.titleMedium?.copyWith(
            color:
                isSelected
                    ? Colors.white
                    : (isDark
                        ? colorScheme.onSurface
                        : const Color(0xFF374151)),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
