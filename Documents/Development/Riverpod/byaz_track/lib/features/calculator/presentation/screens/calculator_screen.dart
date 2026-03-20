import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/calculator/presentation/screens/widgets/calculaor_header.dart';
import 'package:byaz_track/features/calculator/presentation/screens/widgets/interest_rate_section.dart';
import 'package:byaz_track/features/calculator/presentation/screens/widgets/interest_type_section.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Calculator')),
      body: Padding(
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

            // const Divider(height: 1),
            // const Expanded(child: Center(child: Text('Calculator Screen'))),
          ],
        ),
      ),
    );
  }
}
