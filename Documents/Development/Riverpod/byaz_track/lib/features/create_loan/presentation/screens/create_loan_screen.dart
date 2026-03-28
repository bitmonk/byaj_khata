import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/create_loan/presentation/controllers/create_loan_controller.dart';
import 'package:byaz_track/features/create_loan/presentation/screens/widgets/transaction_type_section.dart';
import 'package:byaz_track/features/create_loan/presentation/screens/widgets/start_date_section.dart';
import 'package:byaz_track/features/create_loan/presentation/screens/widgets/interest_rate_type_section.dart';
import 'package:byaz_track/features/create_loan/presentation/screens/widgets/action_buttons_section.dart';

class CreateLoanScreen extends StatefulWidget {
  const CreateLoanScreen({super.key});

  @override
  State<CreateLoanScreen> createState() => _CreateLoanScreenState();
}

class _CreateLoanScreenState extends State<CreateLoanScreen> {
  @override
  void initState() {
    super.initState();
    // // Ensure the controller is put in context if not using bindings
    // if (!Get.isRegistered<CreateLoanController>()) {
    //   Get.put(CreateLoanController(remoteSource: Get.find()));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Loan')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                textInputType: TextInputType.numberWithOptions(),
                onChanged: (value) {},
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
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Icon(Icons.person, color: AppColors.appGreen),
                ),
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
              ),
              const VerticalSpacing(32),
              ActionButtonsSection(
                onSave: () {
                  // TODO: Implement save logic
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
    );
  }
}
