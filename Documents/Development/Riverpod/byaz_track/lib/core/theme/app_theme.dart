import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData appTheme(BuildContext context) => ThemeData(
    useMaterial3: true,
    fontFamily: FontFamily.inter,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      background: AppColors.background,
      onBackground: AppColors.primaryText,
      surface: AppColors.surface,
      onSurface: AppColors.primaryText,
      error: AppColors.error,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: const TextTheme(
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
      backgroundColor: AppColors.surface,
      type: BottomNavigationBarType.fixed,
    ),
  );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
    useMaterial3: true,
    fontFamily: FontFamily.inter,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColorsDark.scaffoldBackground,
    textTheme: AppTextStyle.lightTextTheme.apply(
      bodyColor: AppColorsDark.textPrimary,
      displayColor: AppColorsDark.textPrimary,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColorsDark.primary500,
      brightness: Brightness.dark,
      surface: AppColorsDark.surfaceBackground,
      onSurface: AppColorsDark.textPrimary,
    ),
    cardTheme: CardThemeData(
      color: AppColorsDark.cardBackground,
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        backgroundColor: AppColorsDark.primary500,
        foregroundColor: AppColorsDark.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColorsDark.primary500),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColorsDark.cardBackground,
      selectedItemColor: AppColorsDark.primary500,
      unselectedItemColor: AppColorsDark.neutral600,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    dividerTheme: DividerThemeData(
      color: AppColorsDark.dividerColor,
      thickness: 1,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColorsDark.surfaceBackground,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColorsDark.borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColorsDark.borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColorsDark.appBarBackground,
      foregroundColor: AppColorsDark.textPrimary,
      elevation: 0,
      surfaceTintColor: AppColorsDark.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
  );
}
