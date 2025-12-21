import 'package:byaz_track/core/extension/extensions.dart';

class AppTextStyles {
  // Private constructor
  const AppTextStyles._();

  // Static const instances
  static const TextStyle titleMd = TextStyle(
    fontWeight: FontWeight.w600,
    color: AppColors.textColor50,
    fontSize: 16,
  );
  static const TextStyle titleHeading = TextStyle(
    fontWeight: FontWeight.w600,
    color: AppColors.textColor50,
    fontSize: 20,
  );
  static const TextStyle textHeadingH3 = TextStyle(
    fontWeight: FontWeight.w600,
    color: AppColors.textColor50,
    fontSize: 20,
  );
  static const TextStyle titleSm = TextStyle(
    fontWeight: FontWeight.w400,
    color: AppColors.textColor50,
    fontSize: 14,
  );
  static const TextStyle textCaptionC2 = TextStyle(
    fontWeight: FontWeight.w400,
    color: AppColors.textColor100,
    fontSize: 12,
  );
  static const TextStyle textBodyB1 = TextStyle(
    fontWeight: FontWeight.w600,
    color: AppColors.textColor50,
    fontSize: 16,
  );
  static const TextStyle textBodyB2 = TextStyle(
    fontWeight: FontWeight.w400,
    color: AppColors.textColor50,
    fontSize: 16,
  );
  static const TextStyle textBodyB3 = TextStyle(
    fontWeight: FontWeight.w400,
    color: AppColors.textColor50,
    fontSize: 14,
  );
  static const TextStyle textBodyB4 = TextStyle(
    fontWeight: FontWeight.w400,
    color: AppColors.textColor50,
    fontSize: 12,
  );
  static const TextStyle textSmallS2 = TextStyle(
    fontWeight: FontWeight.w400,
    color: AppColors.textColor200,
    fontSize: 10,
  );
  static const TextStyle lightBodySubHeader = TextStyle(
    fontWeight: FontWeight.w400,
    color: AppColors.colorE6F4FF,
    // fontStyle: Inter,
    fontSize: 12,
  );
  //  old app text Styles
  static const TextStyle textHd = TextStyle(
    fontWeight: FontWeight.w600,
    color: AppColors.textColor50,
    fontSize: 20,
  );

  static const TextStyle titleXS = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle subtitleMDSemibold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle subtitleMDBold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle subtitleSM = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle subtitleMD = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle titleLg = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle subtitleLgBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle subtitleMdMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle subtitleMDRegular = TextStyle(fontSize: 18);

  static const TextStyle typography3Regular = TextStyle(fontSize: 16);

  static const TextStyle typographyOneRegular = TextStyle(fontSize: 16);

  static const TextStyle bodySmRegular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodySmMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.neutral600,
  );

  static const TextStyle bodyLGRegular = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.neutral900,
  );
  static const TextStyle bodyMDsemibold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.neutral700,
  );

  static const TextStyle bodyMDMedium = TextStyle(fontWeight: FontWeight.w500);

  static const TextStyle bodyMDRegular = TextStyle(fontSize: 14);

  static const TextStyle bodyLGMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bodyLG = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodyLGMBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static TextStyle bodyB5 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor50,
  );

  static const TextStyle captionRegular = TextStyle(
    color: AppColors.neutral600,
    fontSize: 12,
  );
  static const TextStyle captionRegularprimary = TextStyle(
    color: AppColors.primary400,
    fontSize: 12,
  );
  static const TextStyle captionMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  // Customizable text style factory (non-const)
  static TextStyle custom({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
  }) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }
}
