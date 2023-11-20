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
import 'package:file_picker/file_picker.dart';
import 'package:universal_io/io.dart';
import 'package:file_saver/file_saver.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:path_provider/path_provider.dart';
import 'package:picos/config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  /// Takes [login] and [password] to login a user.
  /// Returns [BackendError] when something went wrong.
  static Future<BackendError?> login(String login, String password) async {
    if (!Parse().hasParseBeenInitialized()) {
      await _initialized;
    }

    if (login.isEmpty || password.isEmpty) {
      return BackendError.credentials;
    }

    user = ParseUser.createUser(login, password);

    ParseResponse response = await user.login();

    if (response.error == null) {
      return null;
    }

    if (response.error!.message.startsWith('Your account is locked')) {
      return BackendError.bruteforceLock;
    }

    if (response.statusCode == 101) {
      return BackendError.credentials;
    }

    return null;
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
      'Doctor': '/study-nurse-screen/menu-screen/menu-main-screen',
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

  /// Retrieves one possible object from a [table].
  static Future<dynamic> getEntry(
    String table,
    String column,
    String row,
  ) async {
    QueryBuilder<ParseObject> queryBuilder =
        QueryBuilder<ParseObject>(ParseObject(table))
          ..whereEqualTo(column, row);

    return await queryBuilder.query();
  }

  /// Retrieves one possible object directly from a [table].
  static Future<dynamic> getEntryDirect(
    String table,
    String objectId,
  ) async {
    return await ParseObject(table).getObject(objectId);
  }

  /// Updates one possible object from a [table].
  static Future<ParseResponse> updateEntry(
    String tableName,
    String objectId,
    Map<String, dynamic> changes,
  ) async {
    final ParseObject object = ParseObject(tableName)..objectId = objectId;

    changes.forEach((String key, dynamic value) {
      object.set(key, value);
    });

    return await object.save();
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

    ParseResponse parses =
        await parseCloudFunction.executeObjectFunction<ParseObject>();

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

    if (object.objectId == null && acl == null) {
      acl = BackendACL();
      acl.setDefault();
    }

    if (acl != null) {
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

    if (Platform.isAndroid) {
      if (!await Directory('/storage/emulated/0/Download').exists()) {
        return (await getExternalStorageDirectory())?.path;
      }

      return Directory('/storage/emulated/0/Download').path;
    }
    return null;
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
  BackendFile(PlatformFile file) {
    if (kIsWeb) {
      _parseFile = ParseWebFile(
        file.bytes!,
        name: file.name,
      );
    } else {
      _parseFile = ParseFile(File(file.path!));
    }
  }

  /// Creates a new [BackendFile] by [url] and a [name].
  /// This is usually relevant if you try to recreate a local BackendFile you
  /// already uploaded to the backend.
  BackendFile.byUrl(String name, String url) {
    if (kIsWeb) {
      _parseFile = ParseWebFile(null, name: name, url: url);
    } else {
      _parseFile = ParseFile(null, name: name, url: url);
    }
  }

  late final ParseFileBase _parseFile;

  /// Returns the file.
  ParseFileBase get file {
    return _parseFile;
  }

  /// Downloads a file from Parse Server.
  Future<PlatformFile> download() async {
    if (kIsWeb) {
      ParseWebFile parseFile = _parseFile as ParseWebFile;

      await parseFile.download();
      PlatformFile platformFile = PlatformFile(
        name: parseFile.name,
        bytes: parseFile.file,
        size: parseFile.file?.lengthInBytes as int,
      );
      // TODO: maybe save file with location picker in
      /// "add_document_screen.dart ->
      /// _AddDocumentScreenState ->
      /// _createDocumentButtons"
      // saves file in users download folder
      FileSaver.instance.saveFile(
        name: parseFile.name,
        bytes: parseFile.file!,
      );
      return platformFile;
    } else {
      ParseFile parseFile = _parseFile as ParseFile;
      // creates/saves file in _getDownloadPath
      await parseFile.download();
      PlatformFile platformFile = PlatformFile(
        path: parseFile.file?.path,
        name: parseFile.name,
        size: parseFile.file?.lengthSync() as int,
      );
      return platformFile;
    }
  }
}

/// Enumeration for role.
enum BackendRole {
  /// Denotation for doctor's role.
  doctor,

}

/// Extension for Role-enumeration.
extension BackendRoleExtension on BackendRole {
  /// Holds the name of Role.
  Future<String> getRoleName() async {
    QueryBuilder<ParseObject> roleQuery =
        QueryBuilder<ParseObject>(ParseObject('_Role'));

    roleQuery.whereMatchesQuery(
      'users',
      QueryBuilder<ParseObject>(ParseUser.forQuery())
        ..whereEqualTo('objectId', Backend.user.objectId),
    );

    ParseResponse resultRole = await roleQuery.query();
    String roleName = 'role:${resultRole.results?.first.get<String>('name')}';

    return roleName;
  }

  /// ID of the Role.
  Future<String> get id {
    switch (this) {
      case BackendRole.doctor:
        return getRoleName();
    }
  }
}

/// An enum with different errors.
enum BackendError {
  /// Wrong credentials.
  credentials,

  /// Account temporarily locke for brute force protection.
  bruteforceLock,

  /// An undefined [BackendError].
  error,
}

/// Extends [BackendError].
extension BackendErrorExtension on BackendError {
  /// Shows the current error message.
  String getMessage(BuildContext context) {
    switch (this) {
      case BackendError.credentials:
        return AppLocalizations.of(context)!.wrongCredentials;
      case BackendError.bruteforceLock:
        return AppLocalizations.of(context)!.bruteforceLock;
      default:
        return AppLocalizations.of(context)!.connectionError;
    }
  }
}
