import 'package:byaz_track/core/constants/app_colors.dart';
import 'package:byaz_track/core/language/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byaz_track/gen/fonts.gen.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  /// LIGHT THEME
  static ThemeData lightTheme(BuildContext context) {
    final isNepali = LanguageController.instance.isNepali;
    final baseFont =
        isNepali ? GoogleFonts.mukta().fontFamily : FontFamily.inter;

    return ThemeData(
      useMaterial3: true,
      fontFamily: baseFont,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        surface: AppColors.background,
        onSurface: AppColors.primaryText,
        error: AppColors.error,
        onError: Colors.white,
        secondaryContainer: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme:
          isNepali
              ? GoogleFonts.muktaTextTheme(
                const TextTheme(
                  headlineMedium: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w800,
                    fontSize: 28,
                  ),
                  bodyLarge: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 16,
                  ),
                  bodyMedium: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 14,
                  ),
                  labelLarge: TextStyle(
                    color: AppColors.secondaryText,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              )
              : const TextTheme(
                headlineMedium: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                ),
                bodyLarge: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 16,
                ),
                bodyMedium: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 14,
                ),
                labelLarge: TextStyle(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),

      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.divider, width: 1),
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.secondaryText,
        backgroundColor: AppColors.white,
        type: BottomNavigationBarType.fixed,
      ),

      /// APP BAR
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryText,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),

      /// BUTTONS
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primary),
      ),

      /// INPUT FIELDS
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        hintStyle: const TextStyle(color: AppColors.secondaryText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }

  /// DARK THEME
  static ThemeData darkTheme(BuildContext context) {
    final isNepali = LanguageController.instance.isNepali;
    final baseFont =
        isNepali ? GoogleFonts.mukta().fontFamily : FontFamily.inter;

    return ThemeData(
      useMaterial3: true,
      fontFamily: baseFont,
      brightness: Brightness.dark,

      /// COLOR SCHEME
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        surface: Color(0xFF0D1117), // main background
        onSurface: Color(0xFFE6EDF3), // text color
        error: Color(0xFFEF4444),
        onError: Colors.white,
        secondaryContainer: Color(0xFF161B22),
      ),

      /// BACKGROUND
      scaffoldBackgroundColor: const Color(0xFF0D1117),

      /// TEXT
      textTheme:
          isNepali
              ? GoogleFonts.muktaTextTheme(
                const TextTheme(
                  headlineMedium: TextStyle(
                    color: Color(0xFFE6EDF3),
                    fontWeight: FontWeight.w800,
                    fontSize: 28,
                  ),
                  bodyLarge: TextStyle(color: Color(0xFFE6EDF3), fontSize: 16),
                  bodyMedium: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                  labelLarge: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              )
              : const TextTheme(
                headlineMedium: TextStyle(
                  color: Color(0xFFE6EDF3),
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                ),
                bodyLarge: TextStyle(color: Color(0xFFE6EDF3), fontSize: 16),
                bodyMedium: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                labelLarge: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),

      /// CARDS
      cardTheme: CardThemeData(
        color: const Color(0xFF161B22),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0xFF30363D), width: 1),
        ),
      ),

      /// BUTTONS
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primary),
      ),

      /// INPUT FIELDS
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF161B22),

        hintStyle: const TextStyle(color: Color(0xFF6B7280)),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF30363D)),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF30363D)),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),

      /// NAVIGATION BAR
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF161B22),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Color(0xFF6B7280),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      /// DIVIDER
      dividerTheme: const DividerThemeData(
        color: Color(0xFF30363D),
        thickness: 1,
      ),

      /// APP BAR
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF161B22),
        foregroundColor: Color(0xFFE6EDF3),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
    );
  }
}

/// FINANCE STATUS COLORS
class FinanceColors {
  static const lent = Color(0xFF22C55E);
  static const borrowed = Color(0xFFEF4444);
  static const pending = Color(0xFFF59E0B);
  static const settled = Color(0xFF6B7280);
}
