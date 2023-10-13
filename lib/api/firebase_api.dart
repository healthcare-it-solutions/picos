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

/// Background message handler.
Future<void> backgroundMessageHandler(RemoteMessage message) async {
  ParsePush.instance.onMessage(message);
}

/// [FirebaseApi] class is responsible for initializing and handling
/// Firebase Cloud Messaging and Parse Server notifications.
class FirebaseApi {
  /// Handle showing a notification.
  /// This function can be customized to define behavior when a
  /// notification is displayed.
  void handleShowNotification(String payload) {}

  /// Initializes notifications from Firebase Cloud Messaging and Parse Server.
  ///
  /// This function performs several operations:
  /// 1. Retrieves the FCM Token for the current device.
  /// 2. Initializes the Parse Server.
  /// 3. Configures listening for incoming notifications.
  /// 4. Registers or updates the device on the Parse Server.
  Future<void> initNotifications() async {
    try {
      final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      final String? fCMToken = await firebaseMessaging.getToken();

      // Initialize Parse
      await Parse().initialize(
        appId,
        kReleaseMode ? serverUrlProd : serverUrl,
        clientKey: clientKey,
      );

      // Initialize Parse push notifications.
      ParsePush.instance.initialize(
        FirebaseMessaging.instance,
        parseNotification:
            ParseNotification(onShowNotification: handleShowNotification),
      );
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) => ParsePush.instance.onMessage(message),
      );

      final ParseInstallation currentInstallation =
          await ParseInstallation.currentInstallation();

      // Discard any unsaved changes to start with a clean state.
      currentInstallation.clearUnsavedChanges();

      // Create a new installation on the Parse Server.
      await currentInstallation.create(allowCustomObjectId: true);

      // Update the installation with the latest FCM token and installationId.
      currentInstallation
        ..set('deviceToken', currentInstallation.deviceToken ?? fCMToken)
        ..set('installationId', currentInstallation.installationId);

      // Update or save the installation.
      if (currentInstallation.objectId != null) {
        await currentInstallation.update();
      } else {
        await currentInstallation.save();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing notifications: $e');
      }
    }
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }
}
