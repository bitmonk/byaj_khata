import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData appTheme(BuildContext context) => ThemeData(
    useMaterial3: true,
    fontFamily: FontFamily.inter,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    textTheme: AppTextStyle.lightTextTheme.apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary500,
      brightness: Brightness.light,
      surface: AppColors.cardBackground,
      onSurface: AppColors.textPrimary,
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardBackground,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        backgroundColor: AppColors.primary500,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary500,
        textStyle: context.text.titleMedium,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.cardBackground,
      selectedItemColor: AppColors.primary500,
      unselectedItemColor: AppColors.neutral600,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    dividerTheme: DividerThemeData(color: AppColors.dividerColor, thickness: 1),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.transparent,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      surfaceTintColor: AppColors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
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
