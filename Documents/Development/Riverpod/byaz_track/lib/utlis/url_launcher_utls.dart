import 'package:byaz_track/utlis/app_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UrlLauncherUtils {
  static Future<void> openUrl(String? url) async {
    if (url == null) {
      AppUtils.showErrorSnackbar(message: 'No url');
      return;
    }
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      AppUtils.showErrorSnackbar();
    }
  }

  static Future<void> openWebIfPossible(String? url) async {
    if (url == null) {
      return;
    }
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  static Future<void> launchMail(String mail) async {
    final uri = Uri(scheme: 'mailto', path: mail);
    await launchUrl(uri);
  }

  static Future<void> launchContact(String contact) async {
    final numbers = contact.split(',');
    if (numbers.isNotEmpty) {
      final number = numbers[0];
      final uri = Uri(scheme: 'tel', path: number);
      await launchUrl(uri);
    }
  }

  static Future<void> launchSMS(String contact) async {
    final numbers = contact.split(',');
    if (numbers.isNotEmpty) {
      final number = numbers[0];
      final uri = Uri(scheme: 'sms', path: number);
      await launchUrl(uri);
    }
  }
}
