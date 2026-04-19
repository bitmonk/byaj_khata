import 'dart:convert';

import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/dashboard/presentation/controllers/dashboard_bindings.dart';
import 'package:byaz_track/features/interest_details/presentation/controllers/interest_details_bindings.dart';
import 'package:byaz_track/features/interest_details/presentation/screens/interest_details_screen.dart';
import 'package:byaz_track/features/ledger/presentation/widgets/ledger_list_item_card.dart';
import 'package:byaz_track/features/profile/presentation/widgets/confirmation_dialog.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/web.dart';
import '../widgets/ledger_summary_card.dart';
import '../widgets/ledger_filter_tabs.dart';
import 'package:byaz_track/features/ledger/presentation/controllers/ledger_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LedgerScreen extends StatefulWidget {
  const LedgerScreen({super.key});

  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  final List<String> _tabs = [
    'All',
    'Active',
    'Settled',
    // 'Overdue',
    'Upcoming',
    'Borrowed',
    'Lent',
  ];

  final ledgerController = Get.find<LedgerController>();

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
                      onChanged: (value) {
                        ledgerController.searchLoan(value);
                      },
                    ),
                    const VerticalSpacing(16),
                    Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: LedgerSummaryCard(
                              title: 'Total Receivables',
                              amount:
                                  'Rs ${ledgerController.totalReceivables.value.toStringAsFixed(0)}',
                              trendPercentage:
                                  ledgerController.receivablesTrend.value,
                              isPositiveTrend:
                                  ledgerController.isReceivablesPositive.value,
                            ),
                          ),
                          const HorizontalSpacing(12),
                          Expanded(
                            child: LedgerSummaryCard(
                              title: 'Monthly Interest',
                              amount:
                                  'Rs ${ledgerController.monthlyInterest.value.toStringAsFixed(0)}',
                              trendPercentage:
                                  ledgerController.interestTrend.value,
                              isPositiveTrend:
                                  ledgerController.isInterestPositive.value,
                            ),
                          ),
                        ],
                      ),
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
                    child: Obx(
                      () => LedgerFilterTabs(
                        tabs: _tabs,
                        selectedIndex: ledgerController.selectedTabIndex.value,
                        onTabSelected: (index) {
                          ledgerController.selectedTabIndex.value = index;
                          ledgerController.setFilter(_tabs[index]);
                        },
                      ),
                    ),
                  ),
                ),
              ),

              Obx(() {
                if (ledgerController.searchLoanState.value ==
                        TheStates.loading ||
                    ledgerController.refreshLedgerState.value ==
                        TheStates.loading) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Center(
                        child: LoadingAnimationWidget.beat(
                          // leftDotColor: AppColors.appGreen,
                          // rightDotColor: AppColors.appGreen,
                          color: AppColors.appGreen,
                          size: 36,
                        ),
                      ),
                    ),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ).copyWith(top: 8.0, bottom: 12.0),
                  sliver: Obx(() {
                    final controller = Get.find<LedgerController>();

                    if (controller.fetchLoanState.value == TheStates.initial) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Center(
                            child: LoadingAnimationWidget.beat(
                              // leftDotColor: AppColors.appGreen,
                              // rightDotColor: AppColors.appGreen,
                              color: AppColors.appGreen,
                              size: 36,
                            ),
                          ),
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
                          child: Slidable(
                                key: ValueKey(loan.id),
                                endActionPane: ActionPane(
                                  dismissible: DismissiblePane(
                                    onDismissed: () {
                                      controller.deleteLoan(loan.id, context);
                                    },
                                    closeOnCancel: true,
                                    key: ValueKey(loan.id),
                                  ),
                                  motion: const DrawerMotion(),
                                  extentRatio: 0.4,
                                  children: [
                                    SlidableAction(
                                      key: ValueKey(loan.id),
                                      onPressed: (context) {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (context) => Obx(
                                                () => ConfirmationDialog(
                                                  title: 'Delete Loan',
                                                  message:
                                                      'Are you sure you want to delete this loan?',
                                                  confirmText: 'Delete',
                                                  cancelText: 'Cancel',
                                                  icon: Icons.delete,
                                                  isLoading:
                                                      controller
                                                          .deleteLoanState
                                                          .value ==
                                                      TheStates.loading,
                                                  onConfirm: () {
                                                    controller.deleteLoan(
                                                      loan.id,
                                                      context,
                                                    );
                                                  },
                                                ),
                                              ),
                                        );
                                      },
                                      backgroundColor: AppColors.appGreen,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',

                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ],
                                ),
                                child: LedgerListItemCard(
                                  loan: loan,
                                  onTap: () {
                                    InterestDetailsInitializer.initialize();
                                    print(loan.transactionType);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => InterestDetailsScreen(
                                              loan: loan,
                                            ),
                                      ),
                                    );
                                  },
                                ),
                              )
                              .animate(delay: (index * 30).ms)
                              .fade(duration: 400.ms, curve: Curves.easeOut)
                              .slideY(
                                begin: 0.1,
                                end: 0,
                                duration: 400.ms,
                                curve: Curves.easeOutBack,
                              ),
                        );
                      }, childCount: controller.loans.length),
                    );
                  }),
                );
              }),
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
