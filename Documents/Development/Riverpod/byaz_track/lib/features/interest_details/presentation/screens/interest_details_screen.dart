import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/create_loan/data/model/loan_model.dart';
import 'package:byaz_track/features/create_loan/presentation/controllers/create_loan_bindings.dart';
import 'package:byaz_track/features/create_loan/presentation/screens/create_loan_screen.dart';
import 'package:byaz_track/features/interest_details/presentation/controllers/interest_details_controller.dart';
import 'package:byaz_track/features/profile/presentation/widgets/confirmation_dialog.dart';
import '../widgets/interest_profile_header.dart';
import '../widgets/interest_summary_cards.dart';
import '../widgets/interest_accumulated_card.dart';
import '../widgets/interest_calculation_breakdown.dart';
import '../widgets/interest_total_settlement_card.dart';
import '../widgets/interest_action_buttons.dart';

class InterestDetailsScreen extends StatefulWidget {
  final String? loanId;
  const InterestDetailsScreen({super.key, this.loanId});

  @override
  State<InterestDetailsScreen> createState() => _InterestDetailsScreenState();
}

class _InterestDetailsScreenState extends State<InterestDetailsScreen> {
  @override
  void initState() {
    super.initState();
    interestDetailsController.fetchLoan(widget.loanId!);
  }

  final interestDetailsController = Get.find<InterestDetailsController>();
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

              onSelected: (String result) async {
                if (result == 'edit') {
                  CreateLoanInitializer.initialize();
                  await Get.to(
                    () => CreateLoanScreen(
                      loan: interestDetailsController.selectedLoan.value,
                    ),
                  );
                  if (widget.loanId != null) {
                    interestDetailsController.fetchLoan(widget.loanId!);
                  }
                }
              },
              itemBuilder:
                  (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'edit',
                      child: Text('Edit Loan'),
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
                                    interestDetailsController
                                        .deleteLoanState
                                        .value ==
                                    TheStates.loading,
                                onConfirm: () {
                                  interestDetailsController.deleteLoan(
                                    widget.loanId!,
                                    context,
                                  );
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
      body: RefreshIndicator(
        onRefresh: () async {
          await interestDetailsController.fetchLoan(widget.loanId!);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Obx(() {
            // Handle global loading/deleting state
            if (interestDetailsController.deleteLoanState.value ==
                TheStates.loading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: const Center(child: AppLoadingWidget(size: 40)),
              );
            }

            // Handle initial fetch loading state
            if (interestDetailsController.selectedLoan.value == null) {
              if (interestDetailsController.fetchLoanState.value ==
                  TheStates.loading) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: const Center(child: AppLoadingWidget(size: 40)),
                );
              }
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: const Center(child: Text('No data available')),
              );
            }

            // Main Content
            final loan = interestDetailsController.selectedLoan.value!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InterestProfileHeader(loan: loan),
                  const SizedBox(height: 24),
                  InterestSummaryCards(loan: loan),
                  const SizedBox(height: 24),
                  InterestAccumulatedCard(loan: loan),
                  const SizedBox(height: 32),
                  InterestCalculationBreakdown(loan: loan),
                  const SizedBox(height: 32),
                  InterestTotalSettlementCard(loan: loan),
                  const SizedBox(height: 32),
                  InterestActionButtons(loan: loan),
                  const SizedBox(height: 48),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
