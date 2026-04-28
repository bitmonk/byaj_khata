import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/core/utils/byaj_helper.dart';
import 'package:byaz_track/features/create_loan/data/model/loan_model.dart';
import 'package:byaz_track/features/interest_details/presentation/controllers/interest_details_controller.dart';
import 'package:nepali_utils/nepali_utils.dart';

class InterestTotalSettlementCard extends StatelessWidget {
  final LoanModel loan;
  const InterestTotalSettlementCard({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<InterestDetailsController>();
    final isDark = theme.brightness == Brightness.dark;

    final borderColor =
        isDark ? AppColorsDark.dividerColor : const Color(0xFFC3D0C3);
    const contentColor = Color(0xFF0B3626); // Very dark green/slate for text

    // Calculate dynamic data
    final startNepali = loan.startDate.toNepaliSafe();
    final endNepali = NepaliDateTime.now();
    final isMonthly = loan.interestType == "0";

    final result = ByajHelper.calculateInterest(
      principal: loan.principalAmount.toDouble(),
      rate: loan.rateValue,
      isMonthly: isMonthly,
      start: startNepali,
      end: endNepali,
    );

    return Obx(() {
      final totalPaid = controller.totalPaid;
      final remainingDue = result.totalAmount - totalPaid;

      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: borderColor),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'TOTAL SETTLEMENT AMOUNT',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: 'रू  ',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: remainingDue.toStringAsFixed(0),
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 34,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: contentColor.withOpacity(0.1),
                        thickness: 1,
                        width: 24,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Principal: रू ${loan.principalAmount.toStringAsFixed(0)}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Interest: रू ${result.interest.toStringAsFixed(0)}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            if (totalPaid > 0) ...[
                              const SizedBox(height: 4),
                              Text(
                                'Paid: रू ${totalPaid.toStringAsFixed(0)}',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: const Color(0xFF268E2A),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
