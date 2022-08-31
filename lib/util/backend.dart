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

// ignore: depend_on_referenced_packages
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:picos/secrets.dart';

/// Serves as a facade for all backend calls, so that the calls don't need
/// to be extracted with shotgun surgery, should the decision fall not to use
/// the parse_server_sdk lib.
class Backend {
  /// Initializes the parse object
  Backend() {
    if (!_initialized) {
      Parse().initialize(
        appId,
        serverUrl,
        clientKey: clientKey,
        appName: appName,
        debug: true,
      );

      _initialized = true;
    }
  }

  static bool _initialized = false;
  static bool _loggedIn = false;

  static Future<bool> login(String login, String password) async {
    if (!_loggedIn) {
      // in case the next line throws a null is not int compatible or
      // something like 'os broken pipe' remember to set the appid,
      // server url and the client key properly above.
      //final Parse parse = await _init();

      ParseUser user = ParseUser.createUser(login, password);

      ParseResponse res = await user.login();

      print(user.getAll());
      //print(await user.getAll());

      _loggedIn = res.success;

      return res.success;
    }

    return true;
  }

  ///Retrieves an object from the database by id.
  static Future<ParseResponse> getObject(
    String className,
    String objectId,
  ) async {
    return ParseObject(className).getObject(objectId);
  }
}
