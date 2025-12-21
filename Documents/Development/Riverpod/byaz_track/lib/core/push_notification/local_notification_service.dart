import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:byaz_track/core/constants/app_colors.dart';
import 'package:byaz_track/core/push_notification/firebase_notification_service.dart';
// import 'package:byaz_track/features/connect_request/presentation/screens/connect_request_screen.dart';

class LocalNotificationService {
  factory LocalNotificationService() => _instance;

  LocalNotificationService._internal() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  static final LocalNotificationService _instance =
      LocalNotificationService._internal();
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  Future<void> initialize({
    void Function(NotificationResponse)? onDidReceiveNotificationResponse,
    void Function(NotificationResponse)?
    onDidReceiveBackgroundNotificationResponse,
  }) async {
    const androidInitializationSettings = AndroidInitializationSettings(
      '@mipmap/launcher_icon',
    );

    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    const iosInitializationSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          try {
            final data = jsonDecode(response.payload!);
            final message = RemoteMessage(data: data);
            // Use the same handler as direct notification clicks
            FirebaseNotificationService().handleNotificationClick(message);
          } catch (e) {
            print('❌ Error handling notification payload: $e');
            // Fallback navigation for connection-related notifications
            _handleFallbackNavigation(response.payload);
          }
        }
        onDidReceiveNotificationResponse?.call(response);
      },
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse ??
          notificationTapBackground,
    );
  }

  /// Handle fallback navigation when payload parsing fails
  void _handleFallbackNavigation(String? payload) {
    if (payload != null &&
        (payload.contains('connect') ||
            payload.contains('friend') ||
            payload.contains('request'))) {
      _navigateToConnectRequestScreen();
    }
  }

  /// Navigate to ConnectRequestScreen with error handling
  void _navigateToConnectRequestScreen() {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Get.context != null) {
          // Get.to(() => const ConnectRequestScreen());
        } else {
          Future.delayed(const Duration(milliseconds: 1000), () {
            if (Get.context != null) {
              // Get.to(() => const ConnectRequestScreen());
            }
          });
        }
      });
    } catch (e) {
      print('❌ Error navigating from local notification: $e');
    }
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(
    NotificationResponse notificationResponse,
  ) {
    print('🔔 Background notification tapped: ${notificationResponse.payload}');

    if (notificationResponse.payload != null) {
      try {
        final data = jsonDecode(notificationResponse.payload!);
        final message = RemoteMessage(data: data);

        // Delay to ensure app is ready
        Future.delayed(const Duration(milliseconds: 500), () {
          FirebaseNotificationService().handleNotificationClick(message);
        });
      } catch (e) {
        print('❌ Error handling background notification: $e');
        // Fallback handling for connection notifications
        final payload = notificationResponse.payload;
        if (payload != null &&
            (payload.contains('connect') ||
                payload.contains('friend') ||
                payload.contains('request'))) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            try {
              // Get.to(() => const ConnectRequestScreen());
            } catch (navError) {
              print('❌ Background navigation failed: $navError');
            }
          });
        }
      }
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'Notifications',
      channelDescription: 'Your channel description',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/launcher_icon',
      color: AppColors.primary100,
      autoCancel: true,
      enableVibration: true,
      playSound: true,
    );

    const iosNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    final notification = message.notification;
    final data = message.data;

    // Create comprehensive payload with all notification data
    String payload = jsonEncode({
      ...data,
      if (notification != null) ...{
        'title': notification.title,
        'body': notification.body,
      },
    });

    print('📱 Showing notification with payload: $payload');

    if (notification != null) {
      await _flutterLocalNotificationsPlugin.show(
        message.hashCode,
        notification.title ?? 'No title',
        notification.body ?? 'No body',
        notificationDetails,
        payload: payload,
      );
    } else if (data.isNotEmpty) {
      // Handle data-only messages
      await _flutterLocalNotificationsPlugin.show(
        message.hashCode,
        data['title'] ?? 'New Notification',
        data['body'] ?? 'You have a new notification',
        notificationDetails,
        payload: payload,
      );
    } else {
      print('❌ Notification data is missing.');
    }
  }
}
