import 'dart:ui';

import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/home/presentation/controllers/home_controller.dart';
import 'package:byaz_track/features/home/presentation/widgets/home_header.dart';
import 'package:byaz_track/features/home/presentation/widgets/interest_growth_chart.dart';
import 'package:byaz_track/features/home/presentation/widgets/net_balance_card.dart';
import 'package:byaz_track/features/home/presentation/widgets/summary_card.dart';
import 'package:byaz_track/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:byaz_track/features/home/presentation/widgets/upcoming_collections_widget.dart';
import 'package:byaz_track/features/interest_details/presentation/controllers/interest_details_bindings.dart';
import 'package:byaz_track/features/interest_details/presentation/screens/interest_details_screen.dart';
import 'package:byaz_track/features/ledger/presentation/controllers/ledger_controller.dart';
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      // appBar: AppBar(
      //   title: const Text('Dashboard'),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.notifications_none_rounded),
      //       onPressed: () {},
      //     ),
      //     const SizedBox(width: 8),
      //   ],
      // ),
      body: Stack(
        children: [
          // Background Blobs for Glassmorphism
          Positioned(
            top: -50,
            right: -50,
            child: _BackgroundBlob(
              color: theme.colorScheme.primary.withOpacity(0.15),
              size: 250,
            ),
          ),
          Positioned(
            top: 150,
            left: -80,
            child: _BackgroundBlob(
              color: Colors.blue.withOpacity(0.1),
              size: 300,
            ),
          ),
          Positioned(
            bottom: 100,
            right: -100,
            child: _BackgroundBlob(
              color: Colors.purple.withOpacity(0.08),
              size: 350,
            ),
          ),

          // Main Content
          Padding(
            padding: EdgeInsets.only(top: context.devicePaddingTop),
            child: RefreshIndicator(
              onRefresh: () => controller.fetchStats(),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final stats = controller.stats.value;

                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const HomeHeader(),
                    const SizedBox(height: 20),
                    NetBalanceCard(
                      totalBalance: '${stats.netBalance.toStringAsFixed(0)}',
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
                                  (context) =>
                                      InterestDetailsScreen(loan: loan),
                            ),
                          );
                        },
                        onViewAll: () {
                          Get.find<DashboardController>().currentIndex.value =
                              1;
                          final ledgerController = Get.find<LedgerController>();
                          ledgerController.selectedTabIndex.value = 3;
                          ledgerController.setFilter('Upcoming');
                        },
                      ),
                    const VerticalSpacing(150),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BackgroundBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}
