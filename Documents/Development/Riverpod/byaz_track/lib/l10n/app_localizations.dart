import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ne.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ne'),
  ];

  /// Language name in English
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// A programmer's greeting
  ///
  /// In en, this message translates to:
  /// **'Hello World'**
  String get helloWorld;

  /// App title
  ///
  /// In en, this message translates to:
  /// **'Multi Language'**
  String get multiLanguage;

  /// Title for language selection screen
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// Currency symbol
  ///
  /// In en, this message translates to:
  /// **'Rs'**
  String get currency;

  /// No description provided for @choosePreferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language'**
  String get choosePreferredLanguage;

  /// No description provided for @pickLanguageDescription.
  ///
  /// In en, this message translates to:
  /// **'Pick the language you want to use in ByajTracker'**
  String get pickLanguageDescription;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @defaultInterestType.
  ///
  /// In en, this message translates to:
  /// **'Default Interest Type'**
  String get defaultInterestType;

  /// No description provided for @defaultMethodHeader.
  ///
  /// In en, this message translates to:
  /// **'Default Method'**
  String get defaultMethodHeader;

  /// No description provided for @defaultMethodDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose how you want to calculate interest across your ledgers by default.'**
  String get defaultMethodDescription;

  /// No description provided for @rupeeMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Rupee (per 100 / monthly)'**
  String get rupeeMethodTitle;

  /// No description provided for @rupeeMethodDescription.
  ///
  /// In en, this message translates to:
  /// **'Common in informal lending. Calculate interest based on a fixed amount (e.g., Rs2) per Rs100 every month.'**
  String get rupeeMethodDescription;

  /// No description provided for @percentageMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Percentage (%)'**
  String get percentageMethodTitle;

  /// No description provided for @percentageMethodDescription.
  ///
  /// In en, this message translates to:
  /// **'Standard banking method. Calculate interest as an annual (APR) or monthly percentage rate on the principal.'**
  String get percentageMethodDescription;

  /// No description provided for @settingDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This setting will be applied to all new loans. You can still override this calculation type for individual loans during creation.'**
  String get settingDisclaimer;

  /// No description provided for @savePreferenceButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get savePreferenceButton;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'PREFERENCES'**
  String get preferences;

  /// No description provided for @calculationDefaults.
  ///
  /// In en, this message translates to:
  /// **'Calculation Defaults'**
  String get calculationDefaults;

  /// No description provided for @defaultRate.
  ///
  /// In en, this message translates to:
  /// **'Default Rate'**
  String get defaultRate;

  /// No description provided for @perAnnum.
  ///
  /// In en, this message translates to:
  /// **'p.a'**
  String get perAnnum;

  /// No description provided for @compoundFrequency.
  ///
  /// In en, this message translates to:
  /// **'Compound Frequency'**
  String get compoundFrequency;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearly;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// No description provided for @nepaliCalendar.
  ///
  /// In en, this message translates to:
  /// **'Nepali Calendar'**
  String get nepaliCalendar;

  /// No description provided for @bS.
  ///
  /// In en, this message translates to:
  /// **'B.S'**
  String get bS;

  /// No description provided for @aD.
  ///
  /// In en, this message translates to:
  /// **'A.D'**
  String get aD;

  /// No description provided for @dataAndSecurity.
  ///
  /// In en, this message translates to:
  /// **'Data & Security'**
  String get dataAndSecurity;

  /// No description provided for @autoBackup.
  ///
  /// In en, this message translates to:
  /// **'Auto Backup'**
  String get autoBackup;

  /// No description provided for @biometricLock.
  ///
  /// In en, this message translates to:
  /// **'Biometric Lock'**
  String get biometricLock;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportData;

  /// No description provided for @dangerZone.
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get dangerZone;

  /// No description provided for @resetAllData.
  ///
  /// In en, this message translates to:
  /// **'Reset All Data'**
  String get resetAllData;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ne'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ne':
      return AppLocalizationsNe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
