import 'package:flutter/material.dart';
import 'package:byaz_track/core/constants/app_colors.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final String percentage;
  final bool isPositive;
  final IconData icon;

  const SummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.percentage,
    required this.isPositive,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = isPositive ? AppColors.success : colorScheme.error;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // color: colorScheme.onSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              Theme.of(context).dividerTheme.color?.withOpacity(0.5) ??
              colorScheme.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            amount,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                isPositive ? Icons.trending_up : Icons.trending_down,
                color: color,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                percentage,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
