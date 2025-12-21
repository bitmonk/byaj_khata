import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/gen/fonts.gen.dart';

class AppTheme {
  static ThemeData appTheme(BuildContext context) => ThemeData(
    useMaterial3: true,

    fontFamily: FontFamily.inter,
    brightness: Brightness.light,

    textTheme: AppTextStyle.lightTextTheme,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary500),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: const RoundedRectangleBorder(),
        backgroundColor: AppColors.primary500,
        foregroundColor: AppColors.colorWhite,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: AppColors.primary500,
        foregroundColor: AppColors.colorWhite,
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(context.text.titleMedium),
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: WidgetStatePropertyAll(AppColors.primary500),
      ),
    ),

    appBarTheme: AppBarTheme(
      surfaceTintColor: AppColors.transparent,
      systemOverlayStyle: AppUtils.statusBarDarkStyle(),
      backgroundColor: AppColors.transparent,
      foregroundColor: AppColors.white,
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

    colorScheme: ColorScheme.dark(
      primary: AppColorsDark.primary500,
      secondary: AppColorsDark.primary400,
      surface: AppColorsDark.surfaceBackground,
      error: AppColorsDark.error500,
      onPrimary: AppColorsDark.white,
      onSecondary: AppColorsDark.white,
      onSurface: AppColorsDark.textPrimary,
      onError: AppColorsDark.white,
    ),

    cardTheme: const CardThemeData(
      color: AppColorsDark.cardBackground,
      elevation: 2,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: const RoundedRectangleBorder(),
        backgroundColor: AppColorsDark.primary500,
        foregroundColor: AppColorsDark.white,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: AppColorsDark.primary500,
        foregroundColor: AppColorsDark.white,
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(context.text.titleMedium),
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: WidgetStatePropertyAll(AppColorsDark.primary500),
      ),
    ),

    appBarTheme: AppBarTheme(
      surfaceTintColor: AppColorsDark.transparent,
      systemOverlayStyle: AppUtils.statusBarLightStyle(),
      backgroundColor: AppColorsDark.appBarBackground,
      foregroundColor: AppColorsDark.white,
      elevation: 0,
    ),

    dividerTheme: DividerThemeData(
      color: AppColorsDark.dividerColor,
      thickness: 1,
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColorsDark.surfaceBackground,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColorsDark.borderColor),
      ),
    ),
  );
}
