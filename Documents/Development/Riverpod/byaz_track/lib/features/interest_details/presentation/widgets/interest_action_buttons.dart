import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/create_loan/data/model/loan_model.dart';
import 'package:byaz_track/features/interest_details/presentation/controllers/interest_details_controller.dart';
import 'package:byaz_track/features/interest_details/presentation/widgets/add_payment_dialog.dart';
import 'package:byaz_track/features/ledger/presentation/widgets/ledger_list_item_card.dart';
import 'package:byaz_track/features/profile/presentation/widgets/confirmation_dialog.dart';

class InterestActionButtons extends StatelessWidget {
  final LoanModel loan;
  InterestActionButtons({super.key, required this.loan});

  final interestDetailsController = Get.find<InterestDetailsController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final borderColor =
        isDark ? AppColorsDark.dividerColor : const Color(0xFFC3D0C3);
    final primaryColor = const Color(0xFF268E2A); // Matching screenshot green
    final darkTextColor =
        isDark ? AppColorsDark.textPrimary : const Color(0xFF1E1E1E);
    final darkGreenText = const Color(
      0xFF0C2B1D,
    ); // Dark text on green background
    bool isSettled = loan.loanStatus == LedgerItemStatus.settled;
    print(isSettled);
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed:
                () => showDialog(
                  context: context,
                  builder: (context) => AddPaymentDialog(loan: loan),
                ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              side: BorderSide(color: borderColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              backgroundColor:
                  isDark ? theme.colorScheme.surface : Colors.white,
            ),
            icon: Icon(Icons.add_circle_outline, color: darkTextColor),
            label: Text(
              'Add Payment',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: darkTextColor,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Obx(
          () => Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                isSettled
                    ? null
                    : showDialog(
                      context: context,
                      builder:
                          (context) => ConfirmationDialog(
                            title: 'Settle Loan',
                            message:
                                'Are you sure you want to settle this loan? This action cannot be undone.',
                            confirmText: 'Settle',
                            cancelText: 'Cancel',
                            icon: Icons.check_circle,
                            isLoading:
                                interestDetailsController
                                    .settleLoanState
                                    .value ==
                                TheStates.loading,
                            onConfirm: () {
                              interestDetailsController.settleLoan(
                                loan.id,
                                DateTime.now(),
                                context,
                              );
                            },
                          ),
                    );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                backgroundColor:
                    isSettled ? Colors.grey.withAlpha(30) : primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              icon: Icon(
                isSettled ? Icons.check_circle : Icons.check_circle_outline,
                color: AppColors.white,
              ),
              label:
                  interestDetailsController.settleLoanState.value ==
                          TheStates.loading
                      ? const AppLoadingWidget(size: 20)
                      : Text(
                        isSettled ? 'Settled' : 'Settle Loan',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: darkTextColor,
                          fontSize: 18,
                        ),
                      ),
            ),
          ),
        ),
      ],
    );
  }
}
