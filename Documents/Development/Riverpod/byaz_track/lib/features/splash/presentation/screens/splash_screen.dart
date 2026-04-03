import 'package:byaz_track/core/extension/extensions.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();

    nextScreen();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  nextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    if (supabase.auth.currentSession == null) {
      Get.offAllNamed(AppRoutes.auth);
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A2218) : AppColors.background,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6EAD6),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(
                              isDark ? 0.45 : 0.25,
                            ),
                            blurRadius: 30,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Assets.images.byajKhata.image(fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'ByajTracker',
                      style: context.text.headlineMedium?.copyWith(
                        color: isDark ? Colors.white : AppColors.primaryText,
                        fontWeight: FontWeight.w800,
                        fontSize: 34,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Nepali Interest Ledger',
                      style: context.text.bodyMedium?.copyWith(
                        color:
                            isDark ? Colors.white70 : AppColors.secondaryText,
                        fontSize: 16,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
