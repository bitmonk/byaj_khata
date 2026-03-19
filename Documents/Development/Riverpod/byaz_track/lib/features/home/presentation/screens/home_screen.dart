import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/home/presentation/widgets/home_header.dart';
import 'package:byaz_track/features/home/presentation/widgets/interest_growth_chart.dart';
import 'package:byaz_track/features/home/presentation/widgets/net_balance_card.dart';
import 'package:byaz_track/features/home/presentation/widgets/summary_card.dart';
import 'package:byaz_track/features/home/presentation/widgets/upcoming_collections_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0).copyWith(top: context.devicePaddingTop),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: context.devicePaddingBottom + 100),
          child: Column(
            children: [
              const HomeHeader(),
              const SizedBox(height: 20),
              const NetBalanceCard(),

              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      title: 'Lending',
                      amount: 'रू 8.4L',
                      percentage: '+2.1%',
                      isPositive: true,
                      icon: Icons.call_made,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: SummaryCard(
                      title: 'Borrowing',
                      amount: 'रू 2.1L',
                      percentage: '-1.5%',
                      isPositive: false,
                      icon: Icons.call_received,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const InterestGrowthChart(),
              const SizedBox(height: 20),
              const UpcomingCollectionsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
