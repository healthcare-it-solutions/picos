import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../config.dart';

///
Future<void> handleBackgroundMessage(RemoteMessage message) async =>
    ParsePush.instance.onMessage(message);

/// Firebase Api class.
class FirebaseApi {

  ///
  void handleShowNotification(String payload) {
    print('Notification shown with payload: $payload');
  }

  /// Initialize notifications.
  Future<void> initNotifications() async {
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
    // Save the token in backend
    await ParseInstallation.currentInstallation()
    ;

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
