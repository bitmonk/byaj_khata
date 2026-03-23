import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/calculator/presentation/controllers/calculator_controller.dart';
import 'package:byaz_track/features/calculator/presentation/screens/widgets/calculaor_header.dart';
import 'package:byaz_track/features/calculator/presentation/screens/widgets/calculation_summary_card.dart';
import 'package:byaz_track/features/calculator/presentation/screens/widgets/interest_rate_section.dart';
import 'package:byaz_track/features/calculator/presentation/screens/widgets/interest_type_section.dart';
import 'package:byaz_track/features/calculator/presentation/screens/widgets/time_period_section.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final controller = Get.find<CalculatorController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Calculator')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0).copyWith(top: context.devicePaddingTop),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InterestCalculateHeader(),
              VerticalSpacing(30),
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
                onChanged: (value) => controller.principalAmount.value = value,
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
              VerticalSpacing(20),
              InterestTypeSection(),
              VerticalSpacing(20),
              InterestRateSection(),
              VerticalSpacing(20),
              TimePeriodSection(),
              VerticalSpacing(24),
              const CalculationSummaryCard(),
              VerticalSpacing(300),
            ],
          ),
        ),
      ),
    );
  }
}
