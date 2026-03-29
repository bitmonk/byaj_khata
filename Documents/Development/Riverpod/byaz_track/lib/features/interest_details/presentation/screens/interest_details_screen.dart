import 'package:byaz_track/core/extension/extensions.dart';
import '../widgets/interest_profile_header.dart';
import '../widgets/interest_summary_cards.dart';
import '../widgets/interest_accumulated_card.dart';
import '../widgets/interest_calculation_breakdown.dart';
import '../widgets/interest_total_settlement_card.dart';
import '../widgets/interest_action_buttons.dart';

class InterestDetailsScreen extends StatelessWidget {
  const InterestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interest Details'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(icon: const Icon(Icons.share), onPressed: () {}),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const InterestProfileHeader(),
            const SizedBox(height: 24),
            const InterestSummaryCards(),
            const SizedBox(height: 24),
            const InterestAccumulatedCard(),
            const SizedBox(height: 32),
            const InterestCalculationBreakdown(),
            const SizedBox(height: 32),
            const InterestTotalSettlementCard(),
            const SizedBox(height: 32),
            const InterestActionButtons(),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
