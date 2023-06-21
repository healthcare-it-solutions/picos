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

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:path_provider/path_provider.dart';
import 'package:picos/config.dart';

import '../models/abstract_database_object.dart';

/// Serves as a facade for all backend calls, so that the calls don't need
/// to be extracted with shotgun surgery, should the decision fall not to use
/// the parse_server_sdk lib.
class Backend {
  /// initializes the parse server
  Backend() {
    if (_blockInit) {
      return;
    }

    _initialized = _initParse();
  }

  static late final Future<bool> _initialized;
  static bool _blockInit = false;

  /// The user that is currently logged in.
  static late ParseUser user;

  static Future<bool> _initParse() async {
    _blockInit = true;
    String url = '';

    if (kReleaseMode) {
      url = serverUrlProd;
    }

    if (kDebugMode) {
      url = serverUrl;
    }

    await Parse().initialize(
      appId,
      url,
      clientKey: clientKey,
      appName: appName,
      debug: true,
      fileDirectory: await _getDownloadPath(),
    );

    return true;
  }

  /// Takes [login] and [password] to login a user
  /// and returns if it was successful as a [bool].
  static Future<bool> login(String login, String password) async {
    if (!Parse().hasParseBeenInitialized()) {
      await _initialized;
    }

    // in case the next line throws a null is not int compatible or
    // something like 'os broken pipe' remember to set the appid,
    // server url and the client key properly above.
    user = ParseUser.createUser(login, password);

    ParseResponse res = await user.login();

    return res.success;
  }

  /// Logs the user out and return if it was successful.
  static Future<bool> logout() async {
    return (await user.logout()).success;
  }

  /// Retrieves the current user role as a [String].
  static Future<String> getRole() async {
    // these are thr routes we are going to forward the user to
    Map<String, String> routes = <String, String>{
      'Patient': '/home-screen/home-screen',
      'Doctor': '/study-nurse-screen/menu-screen/menu-main-screen'
    };

    // TODO: maybe refactor for type safety
    String res = await user.get('Role');

    return routes[res] ?? '/main-screen/mainscreen';
  }

  /// Retrieves all possible objects from a [table].
  static Future<List<dynamic>> getAll(String table) async {
    ParseResponse parses = await ParseObject(table).getAll();
    return _createListResponse(parses);
  }

  /// Calls the [endpoint].
  static Future<List<dynamic>> callEndpoint(
    String endpoint, [
    Map<String, dynamic>? parameters,
  ]) async {
    ParseCloudFunction parseCloudFunction = ParseCloudFunction(endpoint);

    parameters?.forEach((String key, dynamic value) {
      parseCloudFunction.set(key, value);
    });

    ParseResponse parses = await parseCloudFunction
        .executeObjectFunction<ParseObject>();

    return _createListResponse(parses);
  }

  static List<dynamic> _createListResponse(ParseResponse response) {
    List<dynamic> res = response.results ?? <dynamic>[];
    return res.map((dynamic e) => jsonDecode(e.toString())).toList();
  }

  /// Saves an [object] at the backend.
  /// You can provide an [acl] for custom read/write permissions.
  /// Otherwise default read/write permissions are set.
  ///
  /// Info:
  /// Depending if it's an update or a create the response may miss 'updatedAt'
  /// or 'createdAt' values.
  static Future<dynamic> saveObject(
    AbstractDatabaseObject object, {
    BackendACL? acl,
  }) async {
    ParseObject parseObject = ParseObject(object.table);

    if (object.objectId == null) {
      acl = BackendACL();
      acl.setDefault();
      parseObject.setACL(acl.acl);
    }

    if (object.objectId != null) {
      parseObject.objectId = object.objectId;
    }
    
    object.databaseMapping.forEach((String key, dynamic value) {
      parseObject.set(key, value);
    });

    return jsonDecode((await parseObject.save()).results!.first.toString());
  }

  /// Deletes the [object].
  static Future<void> removeObject(
    AbstractDatabaseObject object,
  ) async {
    ParseObject parseObject = ParseObject(object.table);
    await parseObject.delete(id: object.objectId);
  }

  static Future<String?> _getDownloadPath() async {
    if (Platform.isIOS) {
      return (await getApplicationDocumentsDirectory()).path;
    }

    if (!await Directory('/storage/emulated/0/Download').exists()) {
      return (await getExternalStorageDirectory())?.path;
    }

    return Directory('/storage/emulated/0/Download').path;
  }
}

/// Allows to prepare read and write permissions for an object to be saved.
/// Can be expanded upon for further functionality.
class BackendACL {
  final ParseACL _parseACL = ParseACL();

  /// Returns the ACL.
  ParseACL get acl {
    return _parseACL;
  }

  /// Sets some default ACL.
  void setDefault() {
    setReadAccess(userId: Backend.user.objectId!);
    setWriteAccess(userId: Backend.user.objectId!);
  }

  /// Set whether the user is allowed to read this object.
  void setReadAccess({required String userId, bool allowed = true}) {
    _parseACL.setReadAccess(userId: userId, allowed: allowed);
  }

  /// Set whether the user is allowed to write this object.
  void setWriteAccess({required String userId, bool allowed = true}) {
    _parseACL.setWriteAccess(userId: userId, allowed: allowed);
  }
}

/// Allows to interact with the file storage in the cloud.
class BackendFile {
  /// Creates a new [BackendFile].
  BackendFile(File file) {
    _parseFile = ParseFile(file);
  }

  /// Creates a new [BackendFile] by [url] and a [name].
  /// This is usually relevant if you try to recreate a local BackendFile you
  /// already uploaded to the backend.
  BackendFile.byUrl(String name, String url) {
    _parseFile = ParseFile(null, name: name, url: url);
  }

  late final ParseFile _parseFile;

  /// Returns the file.
  ParseFile get file {
    return _parseFile;
  }

  /// Downloads a file from Parse Server.
  Future<File> download() async {
    return (await _parseFile.download()).file!;
  }
}

/// Enumeration for role.
enum BackendRole {
  /// Denotation for doctor's role.
  doctor,

  /// Denotation for patient's role.
  patient,
}

/// Extension for Role-enumeration.
extension BackendRoleExtension on BackendRole {
  /// ID of the Role.
  String get id {
    switch (this) {
      case BackendRole.doctor:
        return 'role:Doctor';
      case BackendRole.patient:
        return 'role:Patient';
    }
  }
}
