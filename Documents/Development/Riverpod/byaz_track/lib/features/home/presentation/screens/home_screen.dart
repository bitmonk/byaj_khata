import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/home/presentation/widgets/net_balance_card.dart';
import 'package:byaz_track/features/home/presentation/widgets/summary_card.dart';

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
        child: Column(
          children: [
            NetBalanceCard(),
            SizedBox(height: 16),
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
          ],
        ),
      ),
    );
  }
}
