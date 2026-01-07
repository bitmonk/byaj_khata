import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:byaz_track/core/constants/app_colors.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/calculator/presentation/calculator_screen.dart';
import 'package:byaz_track/features/create/presentation/screens/create_screen.dart';
import 'package:byaz_track/features/home/presentation/home.dart';
import 'package:byaz_track/features/profile/presentation/profile_screen.dart';
import 'package:byaz_track/features/theme_example/theme_screen.dart';
import 'package:byaz_track/features/transactions/presentation/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:byaz_track/features/create/presentation/controllers/create_screen_bindings.dart';
import 'package:byaz_track/features/create/presentation/controllers/create_screen_controller.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, this.initialIndex = 0, this.customPages});
  final int initialIndex;
  final List<Widget>? customPages;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  int _bottomNavIndex = 0;
  bool isScrollingDown = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<int> _navigationStack = [];
  List<String> name = ["Home", "Activity", "Calculate", "Profile"];
  bool _isShowingDefaultPage = true;

  final List<IconData> unColoredImageList = [
    Icons.home_outlined,
    Icons.book,
    Icons.calculate,
    Icons.person_outline,
  ];
  final List<IconData> coloredImageList = [
    Icons.home,
    Icons.book,
    Icons.calculate,
    Icons.person,
  ];

  List<Widget> _defaultPages = [];
  List<Widget> _pages = [];

  String? _errorMessage;

  void _initializePages() {
    _defaultPages = [
      const HomeScreen(),
      const TransactionsScreen(),
      CalculatorScreen(),
      ProfileScreen(),
      // ThemeExampleScreen(),
      CreateScreen(),
    ];
  }

  void onItemTapped(int index) {
    if (_bottomNavIndex == index) {
      return;
    }
    setState(() {
      _bottomNavIndex = index;
      _isShowingDefaultPage = true;
      if (widget.customPages != null) {
        _pages = _defaultPages;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _bottomNavIndex = widget.initialIndex;
    CreateScreenInitializer.initialize();
    _initializePages();
    if (widget.customPages != null) {
      _pages = widget.customPages!;
    } else {
      _pages = _defaultPages;
    }
  }

  Widget _buildErrorScreen() {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: AppColors.appRed),
            const SizedBox(height: 16),
            Text(
              _errorMessage ?? 'An error occurred',
              style: context.text.bodyLarge?.copyWith(color: AppColors.appRed),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () {}, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return _buildErrorScreen();
    }

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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    Get.find<CreateScreenController>().loadContacts();
                  },
                  backgroundColor:
                      _bottomNavIndex == 4
                          ? AppColors.primary600
                          : AppColors.neutral600,
                  shape: const CircleBorder(),
                  child: Icon(Icons.add, color: AppColors.white),
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
                isActive ? AppColors.primary600 : AppColors.neutral600;

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
                          style: context.text.titleLarge!.copyWith(
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
                                    ? AppColors.primary600
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
              Theme.of(context).cardColor,
          activeIndex: _isShowingDefaultPage ? _bottomNavIndex : -1,
          // splashColor: Theme.of(context).splashColor,
          // splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.smoothEdge,
          gapLocation: GapLocation.center,
          onTap: (index) => onItemTapped(index),
        ),
      ),
    );
  }
}
