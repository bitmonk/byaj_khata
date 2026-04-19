import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/home/presentation/controllers/home_controller.dart';
import 'package:byaz_track/features/home/presentation/widgets/home_header.dart';
import 'package:byaz_track/features/home/presentation/widgets/interest_growth_chart.dart';
import 'package:byaz_track/features/home/presentation/widgets/net_balance_card.dart';
import 'package:byaz_track/features/home/presentation/widgets/summary_card.dart';
import 'package:byaz_track/features/home/presentation/widgets/upcoming_collections_widget.dart';
import 'package:byaz_track/features/interest_details/presentation/controllers/interest_details_bindings.dart';
import 'package:byaz_track/features/interest_details/presentation/screens/interest_details_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => controller.fetchStats(),
        child: Padding(
          padding: EdgeInsets.all(16.0).copyWith(top: context.devicePaddingTop),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(bottom: context.devicePaddingBottom + 100),
            child: Obx(() {
              final stats = controller.stats.value;

              return Column(
                children: [
                  const HomeHeader(),
                  const SizedBox(height: 20),
                  NetBalanceCard(
                    totalBalance: 'रू ${stats.netBalance.toStringAsFixed(0)}',
                    monthlyIncome:
                        'रू ${stats.monthlyIncome.toStringAsFixed(0)}',
                    avgRate: '${stats.avgRate.toStringAsFixed(1)}% /mo',
                    nextCollection: stats.nextCollection,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: SummaryCard(
                          title: 'Lending',
                          amount:
                              'रू ${(stats.totalLending / 1000).toStringAsFixed(1)}K',
                          percentage: '+${stats.lendingGrowth}%',
                          isPositive: true,
                          icon: Icons.call_made,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SummaryCard(
                          title: 'Borrowing',
                          amount:
                              'रू ${(stats.totalBorrowing / 1000).toStringAsFixed(1)}K',
                          percentage: '${stats.borrowingGrowth}%',
                          isPositive: false,
                          icon: Icons.call_received,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const InterestGrowthChart(),
                  const SizedBox(height: 20),
                  if (stats.upcomingCollections.isNotEmpty)
                    UpcomingCollectionsWidget(
                      items: stats.upcomingCollections,
                      onTap: (loan) {
                        InterestDetailsInitializer.initialize();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => InterestDetailsScreen(loan: loan),
                          ),
                        );
                      },
                    ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
