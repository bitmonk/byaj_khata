// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'Language';

  @override
  String get helloWorld => 'Hello World';

  @override
  String get multiLanguage => 'Multi Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get currency => 'Rs';

  @override
  String get choosePreferredLanguage => 'Choose your preferred language';

  @override
  String get pickLanguageDescription =>
      'Pick the language you want to use in ByajTracker';

  @override
  String get continueButton => 'Continue';

  @override
  String get theme => 'Theme';

  @override
  String get defaultInterestType => 'Default Interest Type';

  @override
  String get defaultMethodHeader => 'Default Method';

  @override
  String get defaultMethodDescription =>
      'Choose how you want to calculate interest across your ledgers by default.';

  @override
  String get rupeeMethodTitle => 'Rupee (per 100 / monthly)';

  @override
  String get rupeeMethodDescription =>
      'Common in informal lending. Calculate interest based on a fixed amount (e.g., Rs2) per Rs100 every month.';

  @override
  String get percentageMethodTitle => 'Percentage (%)';

  @override
  String get percentageMethodDescription =>
      'Standard banking method. Calculate interest as an annual (APR) or monthly percentage rate on the principal.';

  @override
  String get settingDisclaimer =>
      'This setting will be applied to all new loans. You can still override this calculation type for individual loans during creation.';

  @override
  String get savePreferenceButton => 'Save';
}
