// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Nepali (`ne`).
class AppLocalizationsNe extends AppLocalizations {
  AppLocalizationsNe([String locale = 'ne']) : super(locale);

  @override
  String get language => 'भाषा';

  @override
  String get helloWorld => 'नमस्ते';

  @override
  String get multiLanguage => 'बहुभाषा';

  @override
  String get selectLanguage => 'भाषा छान्नुहोस्';

  @override
  String get currency => 'रु';

  @override
  String get choosePreferredLanguage => 'आफ्नो मनपर्ने भाषा चयन गर्नुहोस्';

  @override
  String get pickLanguageDescription =>
      'ByajTracker मा प्रयोग गर्न चाहनुभएको भाषा छान्नुहोस्';

  @override
  String get continueButton => 'जारी राख्नुहोस्';

  @override
  String get theme => 'दिखावट';

  @override
  String get defaultInterestType => 'पूर्वनिर्धारित ब्याज प्रकार';

  @override
  String get defaultMethodHeader => 'पूर्वनिर्धारित विधि';

  @override
  String get defaultMethodDescription =>
      'तपाईंको खातामा ब्याज गणना गर्ने तरिका छनोट गर्नुहोस्।';

  @override
  String get rupeeMethodTitle => 'रुपैयाँ (प्रति १०० / मासिक)';

  @override
  String get rupeeMethodDescription =>
      'अनौपचारिक ऋणमा प्रचलित। हरेक महिना प्रति १०० रुपैयाँको निश्चित रकम (जस्तै रु. २) का आधारमा ब्याज गणना गर्नुहोस्।';

  @override
  String get percentageMethodTitle => 'प्रतिशत (%)';

  @override
  String get percentageMethodDescription =>
      'बैंकिङ मानक विधि। साँवामा वार्षिक (APR) वा मासिक प्रतिशत दरको रूपमा ब्याज गणना गर्नुहोस्।';

  @override
  String get settingDisclaimer =>
      'यो सेटिङ सबै नयाँ ऋणहरूमा लागू हुनेछ। तपाईंले ऋण सिर्जना गर्दा व्यक्तिगत ऋणका लागि यो गणना प्रकारलाई बदल्न सक्नुहुन्छ।';

  @override
  String get savePreferenceButton => 'प्राथमिकता सेट गर्नुहोस्';
}
