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
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get system => 'System';

  @override
  String get colorMode => 'Color Mode';

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

  @override
  String get preferences => 'PREFERENCES';

  @override
  String get calculationDefaults => 'Calculation Defaults';

  @override
  String get defaultRate => 'Default Rate';

  @override
  String get perAnnum => 'p.a';

  @override
  String get compoundFrequency => 'Compound Frequency';

  @override
  String get monthly => 'Monthly';

  @override
  String get yearly => 'Yearly';

  @override
  String get custom => 'Custom';

  @override
  String get nepaliCalendar => 'Nepali Calendar';

  @override
  String get bS => 'B.S';

  @override
  String get aD => 'A.D';

  @override
  String get dataAndSecurity => 'Data & Security';

  @override
  String get autoBackup => 'Auto Backup';

  @override
  String get biometricLock => 'Biometric Lock';

  @override
  String get exportData => 'Export Data';

  @override
  String get dangerZone => 'Danger Zone';

  @override
  String get resetAllData => 'Reset All Data';

  @override
  String get frequencyDescription =>
      'Choose how often interest is calculated and added to the principal to be calculated again.';

  @override
  String get monthlyDescription =>
      'Interest is added to the principal every month.';

  @override
  String get yearlyDescription =>
      'Interest is added to the principal once a year.';

  @override
  String get frequencyDisclaimer =>
      'This frequency will be used for compound interest calculations in all new ledgers.';

  @override
  String get defaultRateDescription =>
      'Set the default interest rate that will be pre-filled when you create a new loan ledger.';

  @override
  String get defaultRateDisclaimer =>
      'Changing this setting won\'t affect interest rates on your existing ledgers.';
}
