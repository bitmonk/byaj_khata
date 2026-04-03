import 'dart:io';

import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/auth/presentation/controllers/auth_controller.dart';
import 'package:byaz_track/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor =
        isDark ? const Color(0xFF1E2A1E) : const Color(0xFF1E2A1E);

    return Scaffold(
      backgroundColor: const Color(0xFF1A2218),
      body: Column(
        children: [
          // ── Hero image section ──
          Expanded(
            flex: 4,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background gradient standing in for landscape photo
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF3A5A3A), // dark forest top
                        Color(0xFF2A4020),
                        Color(0xFF1A2A18), // fades into card bg
                      ],
                    ),
                  ),
                ),
                // Landscape photo – cover-fit so it always fills the box
                Positioned.fill(
                  child: Assets.images.img1.image(
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                // Strong bottom-fade so the photo dissolves into the bg
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.30, 0.65, 0.85, 1.0],
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Color(0xFF1A2218).withAlpha(128),
                          Color(0xFF1A2218).withAlpha(200),
                          Color(0xFF1A2218),
                        ],
                      ),
                    ),
                  ),
                ),
                // Logo + app name centred in hero
                Positioned(
                  bottom: 32,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // App icon badge
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD6EAD6),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.45),
                              blurRadius: 24,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Assets.images.byajKhata.image(
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'ByajTracker',
                        style: context.text.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Nepali Interest Ledger',
                        style: context.text.bodyMedium?.copyWith(
                          color: Colors.white70,
                          fontSize: 14,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom content card ──
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              color: const Color(0xFF1A2218),
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  20,
                  28,
                  20,
                  context.devicePaddingBottom + 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Welcome heading
                    Text(
                      'Welcome',
                      style: context.text.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 28,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Choose a method to get started',
                      style: context.text.bodyMedium?.copyWith(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Continue with Google
                    Obx(
                      () => _AuthButton(
                        onTap: () {
                          authController.continueWithGoogle();
                        },
                        icon: Assets.images.googlelight.image(),
                        label: 'Continue with Google',
                        isLoading:
                            authController.googleAuthState.value ==
                            TheStates.loading,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Continue with Apple
                    if (Platform.isIOS)
                      _AuthButton(
                        onTap: () {},
                        icon: const Icon(
                          Icons.apple,
                          color: Colors.white,
                          size: 22,
                        ),
                        label: 'Continue with Apple',
                      ),
                    if (Platform.isIOS) const SizedBox(height: 28),

                    // ── OR divider ──
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.white.withOpacity(0.12),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            'OR',
                            style: context.text.bodyMedium?.copyWith(
                              color: Colors.white38,
                              fontSize: 12,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.white.withOpacity(0.12),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // ── Offline Mode card ──
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        onTap: () => Get.offAllNamed(AppRoutes.dashboard),
                        borderRadius: BorderRadius.circular(16),
                        splashColor: AppColors.primary.withValues(alpha: 0.12),
                        highlightColor: AppColors.primary.withValues(
                          alpha: 0.06,
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: cardColor.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.08),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              children: [
                                // Offline icon badge
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.cloud_off_rounded,
                                    color: AppColors.primary,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Offline Mode',
                                        style: context.text.bodyLarge?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Save data locally on this device',
                                        style: context.text.bodyMedium
                                            ?.copyWith(
                                              color: Colors.white54,
                                              fontSize: 12,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right_rounded,
                                  color: Colors.white38,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ── Footer ──
                    Text(
                      'Securely manage your Sawa and Byaj',
                      style: context.text.bodyMedium?.copyWith(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_rounded,
                          size: 12,
                          color: Colors.white38,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'End-to-end encrypted storage',
                          style: context.text.bodyMedium?.copyWith(
                            color: Colors.white38,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Auth button ────────────────────────────────────────────────────────────────

class _AuthButton extends StatelessWidget {
  const _AuthButton({
    required this.onTap,
    required this.icon,
    required this.label,
    this.isLoading = false,
  });

  final VoidCallback onTap;
  final Widget icon;
  final String label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: const Color(0xFF1E2A1E).withOpacity(0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child:
                isLoading
                    ? Center(
                      child: LoadingAnimationWidget.beat(
                        color: Colors.white,
                        size: 24,
                      ),
                    )
                    : Row(
                      children: [
                        SizedBox(width: 24, height: 24, child: icon),
                        const Spacer(),
                        Text(
                          label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.white38,
                          size: 20,
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
