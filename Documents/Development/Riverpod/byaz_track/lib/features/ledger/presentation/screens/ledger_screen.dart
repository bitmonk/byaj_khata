import 'dart:convert';

import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/dashboard/presentation/controllers/dashboard_bindings.dart';
import 'package:byaz_track/features/interest_details/presentation/controllers/interest_details_bindings.dart';
import 'package:byaz_track/features/interest_details/presentation/screens/interest_details_screen.dart';
import 'package:byaz_track/features/ledger/presentation/widgets/ledger_list_item_card.dart';
import 'package:logger/web.dart';
import '../widgets/ledger_summary_card.dart';
import '../widgets/ledger_filter_tabs.dart';
import 'package:byaz_track/features/ledger/presentation/controllers/ledger_controller.dart';

class LedgerScreen extends StatefulWidget {
  const LedgerScreen({super.key});

  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = [
    'All',
    'Active',
    'Settled',
    'Overdue',
    'Upcoming',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Ledger')),
      body: Padding(
        padding: EdgeInsets.only(top: context.devicePaddingTop),
        child: RefreshIndicator(
          onRefresh: () async {
            await Get.find<LedgerController>().fetchLoans();
          },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(
                  12.0,
                ).copyWith(bottom: 16.0, top: 0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const LedgerHeader(),
                    const VerticalSpacing(16),
                    AppTextFormField(
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'Search borrower or lender...',
                      prefixIcon: const Icon(Icons.person_search_outlined),
                    ),
                    const VerticalSpacing(16),
                    Row(
                      children: [
                        Expanded(
                          child: LedgerSummaryCard(
                            title: 'Total Receivables',
                            amount: 'Rs 4,50,000',
                            trendPercentage: '+5.2%',
                            isPositiveTrend: true,
                          ),
                        ),
                        const HorizontalSpacing(12),
                        Expanded(
                          child: LedgerSummaryCard(
                            title: 'Monthly Interest',
                            amount: 'Rs 9,000',
                            trendPercentage: '+2.1%',
                            isPositiveTrend: true,
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyTabBarDelegate(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  //   topPadding: context.devicePaddingTop,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: LedgerFilterTabs(
                      tabs: _tabs,
                      selectedIndex: _selectedTabIndex,
                      onTabSelected: (index) {
                        setState(() {
                          _selectedTabIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                ).copyWith(top: 8.0, bottom: 12.0),
                sliver: Obx(() {
                  final controller = Get.find<LedgerController>();

                  if (controller.fetchLoanState.value == TheStates.initial) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  }

                  if (controller.loans.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Center(child: Text('No loans found.')),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final loan = controller.loans[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: LedgerListItemCard(
                          loan: loan,
                          onTap: () {
                            InterestDetailsInitializer.initialize();
                            print(loan.transactionType);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        InterestDetailsScreen(loan: loan),
                              ),
                            );
                          },
                        ),
                      );
                    }, childCount: controller.loans.length),
                  );
                }),
              ),
              SliverPadding(padding: EdgeInsets.only(bottom: 120)),
            ],
          ),
        ),
      ),
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final Color backgroundColor;
  final double topPadding;

  _StickyTabBarDelegate({
    required this.child,
    required this.backgroundColor,
    this.topPadding = 0.0,
  });

  @override
  double get minExtent => 50.0 + topPadding;

  @override
  double get maxExtent => 50.0 + topPadding;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.only(top: topPadding),
      alignment: Alignment.center,
      child: child,
    );
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.topPadding != topPadding;
  }
}

class LedgerHeader extends StatelessWidget {
  const LedgerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'My Ledger',
                style: context.text.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Your loans and interests',
                style: context.text.bodyLarge?.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade200,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.help_outline,
              size: 20,
              color: Colors.black54,
            ),
            tooltip: 'Ledger help',
          ),
        ),
      ],
    );
  }
}
