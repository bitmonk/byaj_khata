// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:byaz_track/core/device_info/device_info.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/core/push_notification/local_notification_service.dart';
// import 'package:byaz_track/features/chat/presentation/controllers/chat_bindings.dart';
// import 'package:byaz_track/features/chat/presentation/controllers/chat_controller.dart';
// import 'package:byaz_track/features/chat/presentation/screens/chat_conversation_screen.dart';
// import 'package:byaz_track/features/connect_request/presentation/controllers/connect_request_bindings.dart';
// import 'package:byaz_track/features/connect_request/presentation/screens/connect_request_screen.dart';
// import 'package:byaz_track/features/favourite_events/presentation/controllers/favourite_events_bindings.dart';
// import 'package:byaz_track/features/helpful_resources/presentation/controllers/helpful_resources/helpful_resources_bindings.dart';
// import 'package:byaz_track/features/home/presentation/controllers/home_bindings.dart';
// import 'package:byaz_track/features/home/presentation/screens/widgets/event_details.dart';
// import 'package:byaz_track/features/map/presentation/controllers/map_bindings.dart';
// import 'package:byaz_track/features/onboarding/presentation/controllers/onboarding_bindings.dart';
// import 'package:byaz_track/features/places/presentation/controllers/places_bindings.dart';
// import 'package:byaz_track/features/popular_outdoor/presentation/controllers/popular_outdoor_bindings.dart';
// import 'package:byaz_track/features/profile/presentation/controllers/profile_bindings.dart';
// import 'package:byaz_track/features/search/presentation/controllers/search_bindings.dart';
// import 'package:byaz_track/features/trending_venues/presentation/controllers/trending_venues_bindings.dart';

class FirebaseNotificationService extends GetxService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<FirebaseNotificationService> init() async {
    print('initializeddddd....');
    await requestPermission();
    await setForegroundNotificationOptions();
    configureFirebaseListeners();
    // await getToken();
    return this;
  }

  Future<void> requestPermission() async {
    var settings = await _firebaseMessaging.requestPermission(
      provisional: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> setForegroundNotificationOptions() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// Polls for APNS token on iOS before calling getToken. Retries a few times with delay.
  Future<String?> getTokenWithRetry({
    int retries = 5,
    Duration delay = const Duration(seconds: 2),
  }) async {
    for (int i = 0; i < retries; i++) {
      if (Platform.isIOS) {
        String? apnsToken = await _firebaseMessaging.getAPNSToken();
        print('APNS Token: $apnsToken');
        if (apnsToken != null) {
          var token = await _firebaseMessaging.getToken();
          print('FCM Token: $token');
          return token;
        }
      } else {
        var token = await _firebaseMessaging.getToken();
        print('FCM Token: $token');
        return token;
      }
      await Future.delayed(delay);
    }
    print('Failed to retrieve APNS token after $retries attempts');
    return null;
  }

  // Future<String?> getToken() async {
  //   try {
  //     String? token;
  //     token = await _firebaseMessaging.getToken();

  //     if (token != null) {
  //       print('FCM Token: $token');
  //     } else {
  //       print('Failed to retrieve FCM token');
  //     }
  //     // Listen for token refresh
  //     _firebaseMessaging.onTokenRefresh.listen((newToken) async {
  //       print('FCM Token refreshed: $newToken');
  //       // Update token in Firestore
  //       final chatController = Get.find<ChatController>();
  //       final userId = chatController.currentUserId;
  //       if (userId != null) {
  //         final deviceId = await getUniqueDeviceId();
  //         final sanitizedDeviceId = deviceId.replaceAll('.', '_');
  //         if (sanitizedDeviceId.isNotEmpty) {
  //           await FirebaseFirestore.instance
  //               .collection('users')
  //               .doc(userId)
  //               .set({
  //                 'fcmTokens.$sanitizedDeviceId': newToken,
  //               }, SetOptions(merge: true));
  //           print('✅ FCM token updated in Firestore: $newToken');
  //         }
  //       }
  //     });
  //     return token;
  //   } catch (e) {
  //     print('Error getting FCM token: $e');
  //     return null;
  //   }
  // }

  void configureFirebaseListeners() {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message received: ${message.notification?.title}');
      LocalNotificationService().showNotification(message);
    });

    // Handle notification clicks when app is in background or foreground
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification opened (background/foreground): ${message.data}');
      handleNotificationClick(message);
    });

    // Handle notification clicks when app is terminated
    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null) {
        print('Notification opened (terminated): ${message.data}');
        handleNotificationClick(message);
      }
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessageHandler);
  }

  void handleNotificationClick(RemoteMessage message) async {
    // AppUtils.showSnackbar(message: 'Notification clicked');
    print('📱 Notification clicked with data: ${message.data}');

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   HelpfulResourcesInitializer.initialize();
    //   HomeInitializer.initialize();
    //   SearchInitializer.initialize();
    //   ConnectRequestInitializer.initialize();
    //   PopularOutdoorInitializer.initialize();
    //   TrendingVenuesInitializer.initialize();
    //   FavouriteEventsInitializer.initialize();
    //   OnboardingInitializer.initialize();
    //   PlacesInitializer.initialize();
    //   ChatInitializer.initialize();
    //   ProfileInitializer.initialize();
    //   MapInitializer.initialize();
    // });
    // final data = message.data;
    // final conversationId = data['conversationId']?.toString();
    // final senderId = data['senderId']?.toString();
    // final clickAction = data['click_action']?.toString();

    // if (clickAction == 'connection_request_received' ||
    //     clickAction == 'connection_request_accepted') {
    //   Get.to(ConnectRequestScreen());
    // }
    // if (clickAction == 'broadcast_notification') {
    //   Get.offAll(() => const ConnectRequestScreen(fromNotification: true));
    // }
    // if ([
    //   'event_starting_soon_24_hours',
    //   'event_ended',
    //   'event_about_to_start',
    // ].contains(clickAction)) {
    //   final eventId = data['reference_id']?.toString();
    //   Get.offAll(
    //     () => const EventDetails(),
    //     arguments: {'id': int.tryParse(eventId ?? "")},
    //   );
    // }

    // if (kDebugMode) {
    //   print(
    //     '🎯 Handling notification with conversationId: $conversationId, senderId: $senderId, click_action: $clickAction',
    //   );
    // }

    // Handle chat notification
    // if (conversationId != null && clickAction == 'FLUTTER_NOTIFICATION_CLICK') {
    //   if (kDebugMode) {
    //     print('💭 Navigating to chat with ID: $conversationId');
    //   }

    //   final chatController = Get.find<ChatController>();

    //   // Close any open dialogs or bottom sheets
    //   if (Get.isDialogOpen == true) Get.back();
    //   if (Get.isBottomSheetOpen == true) Get.back();
    //   if (Get.isSnackbarOpen) Get.back();

    //   // Delay to ensure any previous navigation is complete
    //   await Future.delayed(const Duration(milliseconds: 300));

    //   try {
    //     // Ensure chat users are loaded
    //     await chatController.fetchChatUsers();

    //     // Find the chat in chatItems
    //     ChatItem? chatItem = chatController.chatItems.firstWhereOrNull(
    //       (item) => item.firestoreChatId == conversationId,
    //     );

    //     // If chat not found in local list, try to fetch it
    //     if (chatItem == null) {
    //       final doc =
    //           await FirebaseFirestore.instance
    //               .collection('chatRooms')
    //               .doc(conversationId)
    //               .get();

    //       if (doc.exists) {
    //         final chatData = doc.data() as Map<String, dynamic>;
    //         final participants = List<String>.from(
    //           chatData['participants'] ?? [],
    //         );
    //         final currentUserId = chatController.currentUserId;
    //         final otherUserId = participants.firstWhere(
    //           (id) => id != currentUserId,
    //           orElse: () => '',
    //         );

    //         if (otherUserId.isNotEmpty) {
    //           final userDoc =
    //               await FirebaseFirestore.instance
    //                   .collection('users')
    //                   .doc(otherUserId)
    //                   .get();

    //           if (userDoc.exists) {
    //             final userData = userDoc.data() as Map<String, dynamic>;
    //             chatItem = ChatItem(
    //               chatId: otherUserId.hashCode,
    //               firestoreChatId: conversationId,
    //               userId: otherUserId,
    //               name: userData['name']?.toString() ?? 'Unknown User',
    //               messagePreview:
    //                   chatData['lastMessage']?.toString() ?? 'No messages yet',
    //               time:
    //                   chatData['lastMessageTime'] != null
    //                       ? chatController.formatTime(
    //                         (chatData['lastMessageTime'] as Timestamp).toDate(),
    //                       )
    //                       : '',
    //               unreadCount:
    //                   (chatData['unreadCounts']
    //                       as Map<String, dynamic>?)?[currentUserId] ??
    //                   0,
    //               imagePath: userData['profileImage']?.toString() ?? '',
    //               isOnline: userData['isOnline'] ?? false,
    //             );
    //             chatController.chatItems.add(chatItem);
    //           }
    //         }
    //       }
    //     }

    //     if (chatItem != null) {
    //       // Load messages for the conversation
    //       await chatController.fetchMessages(conversationId);

    //       // Close any existing chat screens
    //       Get.until((route) => route.isFirst);

    //       // Navigate to ChatConversationScreen
    //       Get.off(
    //         () => ChatConversationScreen(
    //           chatId: conversationId,
    //           userId: chatItem?.userId ?? '',
    //           profileImage: chatItem?.imagePath ?? '',
    //           name: chatItem?.name ?? '',
    //         ),
    //         arguments: {
    //           'conversationId': conversationId,
    //           'userId': chatItem.userId,
    //           'userName': chatItem.name,
    //           'profileImage': chatItem.imagePath,
    //         },
    //         preventDuplicates: false,
    //       );
    //     } else {
    //       print('❌ Chat not found for ID: $conversationId');
    //       AppUtils.showErrorSnackbar(message: 'Chat not found');
    //     }
    //   } catch (e, stackTrace) {
    //     print('❌ Error navigating to conversation: $e\n$stackTrace');
    //     AppUtils.showErrorSnackbar(message: 'Failed to load conversation');
    //   }
    // } else {
    //   print('⚠️ No valid conversationId or click_action in notification data');
    //   // AppUtils.showErrorSnackbar(message: 'Invalid notification data');
    // }
  }

  static Future<void> _firebaseBackgroundMessageHandler(
    RemoteMessage message,
  ) async {
    print('Background message received: ${message.notification?.title}');
    LocalNotificationService().showNotification(message);
  }
}

class NotificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(FirebaseNotificationService()..init());
  }
}

class NotificationInitializer {
  static void initialize() {
    Get.put(FirebaseNotificationService()..init());
  }

  static void destroy() {
    Get.delete<FirebaseNotificationService>();
  }
}
