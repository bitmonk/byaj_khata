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
}
