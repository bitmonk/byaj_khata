import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/create_loan/data/model/loan_model.dart';
import 'package:byaz_track/features/create_loan/presentation/controllers/create_loan_controller.dart';
import 'package:byaz_track/features/create_loan/presentation/screens/widgets/transaction_type_section.dart';
import 'package:byaz_track/features/create_loan/presentation/screens/widgets/start_date_section.dart';
import 'package:byaz_track/features/create_loan/presentation/screens/widgets/interest_rate_type_section.dart';
import 'package:byaz_track/features/create_loan/presentation/screens/widgets/action_buttons_section.dart';
import 'package:byaz_track/features/create_loan/presentation/screens/widgets/contact_list_bottom_sheet.dart';
import 'package:byaz_track/features/home/presentation/controllers/home_controller.dart';

class CreateLoanScreen extends StatefulWidget {
  final LoanModel? loan;
  const CreateLoanScreen({super.key, this.loan});

  @override
  State<CreateLoanScreen> createState() => _CreateLoanScreenState();
}

class _CreateLoanScreenState extends State<CreateLoanScreen> {
  final _formKey = GlobalKey<FormState>();
  final createLoanController = Get.find<CreateLoanController>();

  @override
  void initState() {
    super.initState();
    if (widget.loan != null) {
      createLoanController.prefillData(widget.loan!);
    } else {
      createLoanController.resetData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.loan != null ? 'Edit Loan' : 'Create Loan'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpacing(8),
                const TransactionTypeSection(),
                const VerticalSpacing(16),
                Text(
                  'Principal Amount (Sawa)',
                  style: context.text.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                VerticalSpacing(10),
                AppTextFormField(
                  labelText: 'Enter amount',
                  textInputType: const TextInputType.numberWithOptions(),
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a principal amount';
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) <= 0) {
                      return 'Please enter a valid positive amount';
                    }
                    return null;
                  },
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'रु',
                      style: TextStyle(
                        color: AppColors.appGreen,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  controller: createLoanController.principalAmountController,
                ),
                const VerticalSpacing(20),
                const StartDateSection(),
                const VerticalSpacing(24),
                const InterestRateTypeSection(),
                const VerticalSpacing(24),
                Text(
                  'Party Name',
                  style: context.text.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                VerticalSpacing(10),
                AppTextFormField(
                  labelText: 'Who is this with?',
                  textInputType: TextInputType.text,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a party name';
                    }
                    return null;
                  },
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Icon(Icons.person, color: AppColors.appGreen),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.contacts_outlined,
                      color: AppColors.appGreen,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return ContactListBottomSheet(
                            onContactSelected: (contact) {
                              createLoanController.partyNameController.text =
                                  contact.displayName;
                            },
                          );
                        },
                      );
                    },
                  ),
                  controller: createLoanController.partyNameController,
                ),
                VerticalSpacing(24),
                Text(
                  'Notes (Optional)',
                  style: context.text.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                VerticalSpacing(10),
                AppTextFormField(
                  labelText: 'Add details or purpose...',
                  textInputType: TextInputType.text,
                  onChanged: (value) {},
                  controller: createLoanController.notesController,
                ),
                const VerticalSpacing(32),
                ActionButtonsSection(
                  buttonText: widget.loan != null ? 'Update' : 'Save',
                  onSave: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.loan != null) {
                        createLoanController.updateLoan(
                          id: widget.loan!.id,
                          transactionType:
                              createLoanController.transactionType.value
                                  .toString(),
                          principalAmount: int.parse(
                            createLoanController.principalAmountController.text,
                          ),
                          startDate:
                              createLoanController.startDate.value!
                                  .toDateTime(),
                          interestType:
                              createLoanController.interestRateType.value
                                  .toString(),
                          rateValue: double.parse(
                            createLoanController.rateValueController.text,
                          ),
                          partyName:
                              createLoanController.partyNameController.text,
                          notes: createLoanController.notesController.text,
                          loanStatus: widget.loan!.loanStatus,
                          createdAt: widget.loan!.createdAt,
                          context: context,
                        );
                      } else {
                        createLoanController.insertLoan(
                          transactionType:
                              createLoanController.transactionType.value
                                  .toString(),
                          principalAmount: int.parse(
                            createLoanController.principalAmountController.text,
                          ),
                          startDate:
                              createLoanController.startDate.value!
                                  .toDateTime(),
                          interestType:
                              createLoanController.interestRateType.value
                                  .toString(),
                          rateValue: double.parse(
                            createLoanController.rateValueController.text,
                          ),
                          partyName:
                              createLoanController.partyNameController.text,
                          notes: createLoanController.notesController.text,
                          context: context,
                        );
                      }
                    }
                  },
                  onCancel: () {
                    Get.back();
                  },
                ),
                const VerticalSpacing(32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
