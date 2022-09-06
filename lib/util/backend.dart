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

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:picos/secrets.dart';

import '../models/abstract_database_object.dart';

/// Serves as a facade for all backend calls, so that the calls don't need
/// to be extracted with shotgun surgery, should the decision fall not to use
/// the parse_server_sdk lib.
class Backend {
  /// initializes the parse server
  Backend() {
    Parse().initialize(
      appId,
      serverUrl,
      clientKey: clientKey,
      appName: appName,
      debug: true,
    );
  }

  /// The user that is currently logged in.
  static late ParseUser user;

  /// Takes [login] and [password] to login a user
  /// and returns if it was successful as a [bool].
  static Future<bool> login(String login, String password) async {
    // in case the next line throws a null is not int compatible or
    // something like 'os broken pipe' remember to set the appid,
    // server url and the client key properly above.
    user = ParseUser.createUser(login, password);

    ParseResponse res = await user.login();

    return res.success;
  }

  /// Retrieves the current user role as a [String].
  static Future<String> getRole() async {
    // these are thr routes we are going to forward the user to
    Map<String, String> routes = <String, String>{
      'Patient': '/mainscreen',
      'Doctor': '/studynursescreen'
    };

    // TODO: maybe refactor for type safety
    String res = await user.get('Role');

    return routes[res] ?? '/mainscreen';
  }

  /// Retrieves all possible objects from a [table].
  static Future<BackendResponse> getAll(String table) async {
    return BackendResponse(await ParseObject(table).getAll());
  }

  /// Saves an [object] at the backend.
  static Future<BackendResponse> saveObject(
    AbstractDatabaseObject object,
  ) async {
    ParseObject parseObject = ParseObject(object.table);

    if (object.objectId != null) {
      parseObject.objectId = object.objectId;
    }

    object.databaseMapping.forEach((String key, dynamic value) {
      parseObject.set(key, value);
    });

    return BackendResponse(await parseObject.save());
  }
}

/// Handles the response from the backend.
class BackendResponse {
  /// Creates an BackendResponse object.
  BackendResponse(ParseResponse response) {
    statusCode = response.statusCode;
    success = response.success;

    if (response.error != null) {
      error = BackendError(response.error!);
    }

    if (response.results != null) {
      results = response.results;
    }
  }

  /// Status code.
  late final int statusCode;
  /// The error that could occur connection to the backend.
  late final BackendError? error;
  /// Whether the request succeeded or not.
  late final bool success;
  /// All results stored as a list - Even if only one result is returned.
  late final List<dynamic>? results;
}

/// Handles errors with the backend communication.
class BackendError {
  /// Creates an BackendError object.
  BackendError(ParseError error) {
    code = error.code;
    message = error.message;
    exception = error.exception;
  }

  /// Error code.
  late final int code;
  /// Error message.
  late final String message;
  /// Exception.
  late final Exception? exception;
}
