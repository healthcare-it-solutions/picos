import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../config.dart';

///
Future<void> handleBackgroundMessage(RemoteMessage message) async =>
    ParsePush.instance.onMessage(message);

/// Firebase Api class.
class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  ///
  void handleShowNotification(String payload) {
    print('Notification shown with payload: $payload');
  }

  /// Initialize notifications.
  Future<void> initNotifications() async {
    final String? fCMToken = await _firebaseMessaging.getToken();
    print('Mein Token: $fCMToken');
    // Initialize Parse
    await Parse().initialize(
      appId,
      serverUrl,
      clientKey: clientKey,
      debug: true,
    );

    // Initialize Parse push notifications
    ParsePush.instance.initialize(
      FirebaseMessaging.instance,
      parseNotification:
          ParseNotification(onShowNotification: handleShowNotification),
    );
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) => ParsePush.instance.onMessage(message),
    );

    final ParseInstallation installation =
        await ParseInstallation.currentInstallation();

    installation.deviceToken = fCMToken;

    final ParseResponse response = await installation.save();
    if (response.success) {
      print(response.result);
    } else {
      print(response.error?.message);
    }
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
