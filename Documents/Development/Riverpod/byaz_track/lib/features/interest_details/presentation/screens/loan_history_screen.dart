import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:byaz_track/features/interest_details/presentation/controllers/interest_details_controller.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';

class LoanHistoryScreen extends StatelessWidget {
  const LoanHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InterestDetailsController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final loan = controller.selectedLoan.value;
        if (loan == null) return const Center(child: Text('No loan data'));

        // Combine loan creation and payments into a single timeline list
        final events = <_HistoryEvent>[];

        // Add Creation Event
        events.add(
          _HistoryEvent(
            date: loan.startDate,
            title: 'Loan Created',
            subtitle:
                'Principal: Rs ${loan.principalAmount.toStringAsFixed(0)}',
            icon: Icons.add_business_rounded,
            color: Colors.blue,
          ),
        );

        // Add Payment Events
        final isLending = loan.transactionType == '0';
        for (final payment in controller.payments) {
          events.add(
            _HistoryEvent(
              date: payment.paymentDate,
              title: isLending ? 'Payment Received' : 'Payment Given',
              subtitle: 'Amount: Rs ${payment.amount.toStringAsFixed(0)}',
              icon: Icons.payments_rounded,
              color: const Color(0xFF268E2A),
            ),
          );
        }

        // Sort by date ascending (Creation at the top)
        events.sort((a, b) => a.date.compareTo(b.date));

        return ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            final isLast = index == events.length - 1;

            return IntrinsicHeight(
              child: Row(
                children: [
                  // Timeline line and icon
                  Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: event.color.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(event.icon, color: event.color, size: 20),
                      ),
                      if (!isLast)
                        Expanded(
                          child: Container(
                            width: 2,
                            color: theme.dividerColor.withOpacity(0.5),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Event details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              event.title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              event.date.toNepaliSafe().format('yyyy-MM-dd'),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.textTheme.bodySmall?.color,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event.subtitle,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodySmall?.color,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

class _HistoryEvent {
  final DateTime date;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  _HistoryEvent({
    required this.date,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}
