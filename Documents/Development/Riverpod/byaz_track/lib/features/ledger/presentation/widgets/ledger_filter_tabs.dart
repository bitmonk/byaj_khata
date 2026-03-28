import 'package:byaz_track/core/extension/extensions.dart';

class LedgerFilterTabs extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const LedgerFilterTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedIndex == index;
          final theme = Theme.of(context);
          final isDark = theme.brightness == Brightness.dark;

          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: InkWell(
              onTap: () => onTabSelected(index),
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? AppColors.primary
                          : (isDark ? theme.colorScheme.surface : Colors.white),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color:
                        isSelected
                            ? AppColors.primary
                            : (isDark
                                ? AppColorsDark.dividerColor
                                : AppColors.dividerColor.withOpacity(0.6)),
                  ),
                ),
                child: Text(
                  tabs[index],
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color:
                        isSelected
                            ? Colors.white
                            : (isDark
                                ? AppColorsDark.textSecondary
                                : AppColors.textPrimary.withOpacity(0.8)),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
