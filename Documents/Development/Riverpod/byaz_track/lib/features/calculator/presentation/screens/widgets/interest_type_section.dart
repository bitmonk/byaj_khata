import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/calculator/presentation/screens/widgets/interest_type_selector.dart';

class InterestTypeSection extends StatefulWidget {
  const InterestTypeSection({super.key});

  @override
  State<InterestTypeSection> createState() => _InterestTypeSectionState();
}

class _InterestTypeSectionState extends State<InterestTypeSection> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InterestTypeSelector(
          selectedIndex: _selectedIndex,
          onSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ],
    );
  }
}
