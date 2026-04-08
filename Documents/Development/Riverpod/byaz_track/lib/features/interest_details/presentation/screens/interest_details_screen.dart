import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/create_loan/data/model/loan_model.dart';
import 'package:byaz_track/features/interest_details/presentation/controllers/interest_details_controller.dart';
import 'package:byaz_track/features/profile/presentation/widgets/confirmation_dialog.dart';
import '../widgets/interest_profile_header.dart';
import '../widgets/interest_summary_cards.dart';
import '../widgets/interest_accumulated_card.dart';
import '../widgets/interest_calculation_breakdown.dart';
import '../widgets/interest_total_settlement_card.dart';
import '../widgets/interest_action_buttons.dart';

class InterestDetailsScreen extends GetView<InterestDetailsController> {
  final LoanModel? loan;
  const InterestDetailsScreen({super.key, this.loan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interest Details'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              offset: const Offset(0, 50),
              elevation: 10,
              shadowColor: Colors.black,

              onSelected: (String result) {
                // Handle different menu option selections here
                print('Selected option: $result');
              },
              itemBuilder:
                  (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'edit',
                      child: Text('Edit Loan'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'share',
                      child: Text('Share Details'),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Text(
                        'Delete Loan',
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => ConfirmationDialog(
                                title: 'Delete Loan',
                                message:
                                    'Are you sure you want to delete this loan? This action cannot be undone.',
                                confirmText: 'Delete',
                                cancelText: 'Cancel',
                                icon: Icons.delete,
                                isLoading:
                                    controller.deleteLoanState.value ==
                                    TheStates.loading,
                                onConfirm: () {
                                  controller.deleteLoan(loan!.id!, context);
                                },
                              ),
                        );
                      },
                    ),
                  ],
            ),
          ),
        ],
      ),
      body: Obx(
        () =>
            controller.deleteLoanState.value == TheStates.loading
                ? const Center(child: AppLoadingWidget(size: 40))
                : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InterestProfileHeader(loan: loan!),
                      const SizedBox(height: 24),
                      InterestSummaryCards(loan: loan),
                      const SizedBox(height: 24),
                      InterestAccumulatedCard(loan: loan!),
                      const SizedBox(height: 32),
                      InterestCalculationBreakdown(loan: loan!),
                      const SizedBox(height: 32),
                      InterestTotalSettlementCard(loan: loan!),
                      const SizedBox(height: 32),
                      InterestActionButtons(loan: loan!),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
      ),
    );
  }
}
