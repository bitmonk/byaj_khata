import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/calculator/presentation/controllers/calculator_controller.dart';
import 'package:byaz_track/features/calculator/presentation/screens/widgets/interest_type_selector.dart';

class InterestTypeSection extends StatefulWidget {
  const InterestTypeSection({super.key});

  @override
  State<InterestTypeSection> createState() => _InterestTypeSectionState();
}

class _InterestTypeSectionState extends State<InterestTypeSection> {
  final controller = Get.find<CalculatorController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => InterestTypeSelector(
              selectedIndex: controller.interestType.value,
              onSelected: (index) {
                controller.interestType.value = index;
              },
            )),
      ],
    );
  }
}
