/*   This file is part of Picos, a health tracking mobile app
*    Copyright (C) 2022 Healthcare IT Solutions GmbH
*
*    This program is free software: you can redistribute it and/or modify
*    it under the terms of the GNU General Public License as published by
*    the Free Software Foundation, either version 3 of the License, or
*    (at your option) any later version.
*
*    This program is distributed in the hope that it will be useful,
*    but WITHOUT ANY WARRANTY; without even the implied warranty of
*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*    GNU General Public License for more details.
*
*    You should have received a copy of the GNU General Public License
*    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../config.dart';

/// Firebase API class.
class FirebaseApi {
  /// Handle showing the notification.
  void handleShowNotification(String payload) {}

  /// Initializes notifications.
  Future<void> initNotifications() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Initialize Parse
    await Parse().initialize(
      appId,
      kReleaseMode ? serverUrlProd : serverUrl,
      clientKey: clientKey,
      debug: true,
    );

    ParseInstallation parseInstallation =
        await ParseInstallation.currentInstallation();

    parseInstallation.set('installationId', parseInstallation.installationId);

    await parseInstallation.save();

    // Initialize Parse push notifications
    ParsePush.instance.initialize(
      FirebaseMessaging.instance,
      parseNotification:
          ParseNotification(onShowNotification: handleShowNotification),
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) => ParsePush.instance.onMessage(message),
    );
  }
}
