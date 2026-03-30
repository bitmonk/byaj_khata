import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:byaz_track/core/build_variants/environment_entry_points.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// import 'flavors.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print(
    'notification(${notificationResponse.id}) action tapped: '
    '${notificationResponse.actionId} with'
    ' payload: ${notificationResponse.payload}',
  );
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
      'notification action tapped with input: ${notificationResponse.input}',
    );
  }
}

void main() async {
  // F.appFlavor = Flavor.values.firstWhere(
  //   (element) => element.name == appFlavor,
  // );
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // Initialize local notifications
  // await LocalNotificationService().initialize();

  // // Set foreground notification options (for iOS)
  // await FirebaseNotificationService().setForegroundNotificationOptions();

  // // Initialize Firebase notification service (sets up listeners)
  // await FirebaseNotificationService().init();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  StagingEntryPoint();
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
// }

// flutter run --debug --flavor=api
// dart run build_runner watch --delete-conflicting-outputs
// flutter build apk --release --flavor production
// flutter build appbundle --release --flavor=api
