import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/add/presentation/screens/add_screen.dart';
import 'package:byaz_track/features/calculator/data/source/calculator_remote_source.dart';
import 'package:byaz_track/features/create_loan/presentation/screens/create_loan_screen.dart';
import 'package:byaz_track/features/calculator/presentation/controllers/calculator_controller.dart';
import 'package:byaz_track/features/calculator/presentation/screens/calculator_screen.dart';
import 'package:byaz_track/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:byaz_track/features/home/presentation/screens/home_screen.dart';
import 'package:byaz_track/features/ledger/presentation/controllers/ledger_bindings.dart';
import 'package:byaz_track/features/ledger/presentation/screens/ledger_screen.dart';
import 'package:byaz_track/features/profile/presentation/screens/profile_screen.dart';
import 'package:byaz_track/features/settings/presentation/controllers/profile_bindings.dart';
import 'package:flutter/services.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, this.initialIndex = 0, this.customPages});
  final int initialIndex;
  final List<Widget>? customPages;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  final dashboardController = Get.find<DashboardController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<int> _navigationStack = [];

  List<String> name = ["Home", "Ledger", "Calculator", "Profile"];
  bool _isShowingDefaultPage = true;

  final List<IconData> unColoredImageList = [
    Icons.home_outlined,
    Icons.account_balance_wallet_outlined,
    Icons.calculate_outlined,
    Icons.person_outline,
  ];
  final List<IconData> coloredImageList = [
    Icons.home,
    Icons.account_balance_wallet,
    Icons.calculate,
    Icons.person,
  ];

  List<Widget> _defaultPages = [];
  late List<Widget> _pages;

  void _initializePages() {
    ProfileInitializer.initialize();
    LedgerInitializer.initialize();
    _defaultPages = [
      const HomeScreen(),
      const LedgerScreen(),
      const CalculatorScreen(),
      const ProfileScreen(),
      const AddScreen(),
    ];
  }

  void onItemTapped(int index) {
    if (dashboardController.currentIndex.value == index) {
      return;
    }

    _navigationStack.add(dashboardController.currentIndex.value);
    setState(() {
      dashboardController.currentIndex.value = index;
      _isShowingDefaultPage = true;
      if (widget.customPages != null) {
        _pages = _defaultPages;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    dashboardController.currentIndex.value = widget.initialIndex;
    _isShowingDefaultPage = widget.customPages == null;
    Get.put(
      CalculatorController(remoteSource: CalculatorRemoteSource(Get.find())),
    );

    _initializePages();
    _pages = widget.customPages ?? _defaultPages;
  }

  @override
  void dispose() {
    ProfileInitializer.destroy();
    LedgerInitializer.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        if (_navigationStack.isNotEmpty) {
          setState(() {
            dashboardController.currentIndex.value =
                _navigationStack.removeLast();
            _isShowingDefaultPage = true;
            if (widget.customPages != null) {
              _pages = _defaultPages;
            }
          });
        } else if (dashboardController.currentIndex.value != 0) {
          setState(() {
            dashboardController.currentIndex.value = 0;
            _isShowingDefaultPage = true;
            if (widget.customPages != null) {
              _pages = _defaultPages;
            }
          });
        } else {
          SystemNavigator.pop();
        }
      },
      child: Obx(
        () => Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          key: _scaffoldKey,
          extendBody: true,
          body: IndexedStack(
            index:
                dashboardController.currentIndex.value >= _pages.length
                    ? 0
                    : dashboardController.currentIndex.value,
            children: _pages,
          ),
          floatingActionButton:
              isKeyboardOpen
                  ? null
                  : FloatingActionButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.createLoan);
                    },
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: const CircleBorder(),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            leftCornerRadius: 24,
            rightCornerRadius: 24,
            height: 70,
            elevation: 1,
            borderWidth: BorderSide.strokeAlignInside,
            itemCount: coloredImageList.length,
            tabBuilder: (int index, bool isActive) {
              final color =
                  isActive
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(
                            context,
                          ).textTheme.bodyMedium?.color?.withOpacity(0.5) ??
                          Colors.grey;

              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(
                        isActive
                            ? coloredImageList[index]
                            : unColoredImageList[index],
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Text(
                            name[index],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: color,
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(top: 2),
                            height: 3,
                            width: 6,
                            decoration: BoxDecoration(
                              color:
                                  isActive
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
                Theme.of(context).scaffoldBackgroundColor,
            activeIndex:
                _isShowingDefaultPage
                    ? (dashboardController.currentIndex.value == 4
                        ? -1
                        : dashboardController.currentIndex.value)
                    : -1,
            splashColor: Theme.of(context).scaffoldBackgroundColor,
            splashSpeedInMilliseconds: 300,
            notchSmoothness: NotchSmoothness.smoothEdge,
            gapLocation: GapLocation.center,
            onTap: (index) => onItemTapped(index),
          ),
        ),
      ),
    );
  }
}
