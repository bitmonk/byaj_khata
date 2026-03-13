import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/add/presentation/screens/add_screen.dart';
import 'package:byaz_track/features/calculator/presentation/screens/calculator_screen.dart';
import 'package:byaz_track/features/home/presentation/screens/home_screen.dart';
import 'package:byaz_track/features/ledger/presentation/screens/ledger_screen.dart';
import 'package:byaz_track/features/profile/presentation/screens/profile_screen.dart';
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
  var _bottomNavIndex = 0;
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
    _defaultPages = [
      const HomeScreen(),
      const LedgerScreen(),
      const CalculatorScreen(),
      const ProfileScreen(),
      const AddScreen(),
    ];
  }

  void onItemTapped(int index) {
    if (_bottomNavIndex == index) {
      return;
    }

    if (_bottomNavIndex != index) {
      _navigationStack.add(_bottomNavIndex);
      setState(() {
        _bottomNavIndex = index;
        _isShowingDefaultPage = true;
        if (widget.customPages != null) {
          _pages = _defaultPages;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _bottomNavIndex = widget.initialIndex;
    _isShowingDefaultPage = widget.customPages == null;

    _initializePages();
    _pages = widget.customPages ?? _defaultPages;
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
            _bottomNavIndex = _navigationStack.removeLast();
            _isShowingDefaultPage = true;
            if (widget.customPages != null) {
              _pages = _defaultPages;
            }
          });
        } else if (_bottomNavIndex != 0) {
          setState(() {
            _bottomNavIndex = 0;
            _isShowingDefaultPage = true;
            if (widget.customPages != null) {
              _pages = _defaultPages;
            }
          });
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        extendBody: true,
        body: IndexedStack(
          index: _bottomNavIndex >= _pages.length ? 0 : _bottomNavIndex,
          children: _pages,
        ),
        floatingActionButton:
            isKeyboardOpen
                ? null
                : FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _isShowingDefaultPage = true;
                      _bottomNavIndex = 4;
                      if (widget.customPages != null) {
                        _pages = _defaultPages;
                      }
                    });
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          leftCornerRadius: 24,
          rightCornerRadius: 24,
          height: 70,
          elevation: 1,
          borderWidth: BorderSide.strokeAlignInside,
          itemCount: coloredImageList.length,
          tabBuilder: (int index, bool isActive) {
            final color =
                isActive ? Theme.of(context).primaryColor : Colors.grey;

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
                                    ? Theme.of(context).primaryColor
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
          backgroundColor: Colors.white,
          activeIndex:
              _isShowingDefaultPage
                  ? (_bottomNavIndex == 4 ? -1 : _bottomNavIndex)
                  : -1,
          splashColor: Colors.white,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.smoothEdge,
          gapLocation: GapLocation.center,
          onTap: (index) => onItemTapped(index),
        ),
      ),
    );
  }
}
