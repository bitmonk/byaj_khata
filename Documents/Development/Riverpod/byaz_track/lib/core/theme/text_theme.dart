import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/gen/fonts.gen.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextTheme get lightTextTheme => const TextTheme().copyWith(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
  );

  static TextStyle get _baseHeadline => TextStyle(
    fontFamily: FontFamily.inter,
    color: AppColors.neutral900,
    height: 1.2,
  );

  static TextStyle get displayLarge => _baseHeadline.copyWith();
  static TextStyle get displayMedium =>
      _baseHeadline.copyWith(fontSize: AppFontSize.displayMedium);
  static TextStyle get displaySmall =>
      _baseHeadline.copyWith(fontSize: AppFontSize.displaySmall);

  static TextStyle get headlineLarge =>
      _baseHeadline.copyWith(fontSize: AppFontSize.headlineLarge);
  static TextStyle get headlineMedium =>
      _baseHeadline.copyWith(fontSize: AppFontSize.headlineMedium);
  static TextStyle get headlineSmall =>
      _baseHeadline.copyWith(fontSize: AppFontSize.headlineSmall);
  static TextStyle get titleLarge =>
      _baseHeadline.copyWith(fontSize: AppFontSize.titleLarge);
  static TextStyle get titleMedium =>
      _baseHeadline.copyWith(fontSize: AppFontSize.titleMedium);
  static TextStyle get titleSmall =>
      _baseHeadline.copyWith(fontSize: AppFontSize.titleSmall);
}
