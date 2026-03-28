import 'package:flutter/material.dart';

class UpcomingCollectionItem {
  final String name;
  final String dueText;
  final String amount;
  final String status;
  final String initials;
  final Color avatarColor;

  const UpcomingCollectionItem({
    required this.name,
    required this.dueText,
    required this.amount,
    required this.status,
    required this.initials,
    required this.avatarColor,
  });
}

class UpcomingCollectionsWidget extends StatelessWidget {
  final List<UpcomingCollectionItem> items;

  const UpcomingCollectionsWidget({
    super.key,
    this.items = const [
      UpcomingCollectionItem(
        name: 'Rajesh Kumar',
        initials: 'RK',
        dueText: 'Due in 2 days',
        amount: 'Rs 12,500',
        status: 'INTEREST ONLY',
        avatarColor: Color(0xFF10B981),
      ),
      UpcomingCollectionItem(
        name: 'Sunita Sharma',
        initials: 'SS',
        dueText: 'Due tomorrow',
        amount: 'Rs 4,200',
        status: 'MONTHLY INTEREST',
        avatarColor: Color(0xFFF59E0B),
      ),
      UpcomingCollectionItem(
        name: 'Rahul Varma',
        initials: 'RV',
        dueText: 'Due in 5 days',
        amount: 'Rs 8,000',
        status: 'FULL SETTLEMENT',
        avatarColor: Color(0xFF3B82F6),
      ),
    ],
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Collections',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: colorScheme.onBackground,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.primary,
                textStyle: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {},
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: theme.dividerTheme.color ?? colorScheme.outline,
              width: 0.8,
            ),
          ),
          child: Column(
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isLast = index == items.length - 1;
              return Container(
                decoration: BoxDecoration(
                  border:
                      isLast
                          ? null
                          : Border(
                            bottom: BorderSide(
                              color:
                                  theme.dividerTheme.color?.withOpacity(0.22) ??
                                  colorScheme.outline.withOpacity(0.22),
                              width: 0.8,
                            ),
                          ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: item.avatarColor.withOpacity(0.15),
                      foregroundColor: item.avatarColor,
                      radius: 20,
                      child: Text(
                        item.initials,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.dueText,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item.amount,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.status,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
