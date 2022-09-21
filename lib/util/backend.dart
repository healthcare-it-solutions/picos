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

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:picos/secrets.dart';
import 'package:picos/util/backend_data.dart';

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
  static Future<List<dynamic>> getAll(String table) async {
    ParseResponse parses = await ParseObject(table).getAll();
    List<dynamic> res = parses.results ?? <dynamic>[];

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

    if (acl == null) {
      acl = BackendACL();
      acl.setDefault();
    }

    if (object.objectId != null) {
      parseObject.objectId = object.objectId;
    }

    parseObject.setACL(acl.acl);

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

  /// method to create a patient entry in the database.
  static Future<bool> createPatient() async {
    ParseResponse resPatientLogin;
    ParseResponse resProfileValues;

    ParseObject patient = ParseObject('_User')
      ..set('username', 'Test5')
      ..set('password', 'TestPassword123')
      ..set('email', PersonalData.email)
      ..set('Form', PersonalData.gender.toString())
      ..set('Firstname', PersonalData.firstName)
      ..set('Lastname', PersonalData.familyName)
      ..set('PhoneNo', PersonalData.number)
      ..set('Address', PersonalData.address)
      ..set('Role', 'Patient');

    BackendACL aclValue = BackendACL();
    aclValue.setReadAccess(
      userId: 'role:Doctor',
      allowed: true,
    );
    patient.setACL(aclValue.acl);

    resPatientLogin = await patient.save();

    if (resPatientLogin.success) {
      ParseObject profileValues = ParseObject('PICOS_Q_profile')
        ..set('Weight_BMI', Parameters.weightBMIEnabled)
        ..set('HeartRate', Parameters.heartFrequencyEnabled)
        ..set('BloodPressure', Parameters.bloodPressureEnabled)
        ..set('BloodSugar', Parameters.bloodSugarLevelsEnabled)
        ..set('WalkingDistance', Parameters.walkDistanceEnabled)
        ..set('SleepDuration', Parameters.sleepDurationEnabled)
        ..set('SISQS', Parameters.sleepQualityEnabled)
        ..set('Pain', Parameters.painEnabled)
        ..set('PHQ4', Parameters.phq4Enabled)
        ..set('Medication', Parameters.medicationEnabled)
        ..set('Therapies', Parameters.therapyEnabled)
        ..set('Stays', Parameters.doctorsVisitEnabled)
        ..set(
          'Patient',
          <String, String> {
            'objectId': patient.objectId!,
            '__type': 'Pointer',
            'className': '_User'
          },
        )
        ..set(
          'Doctor',
          <String, String> {
            'objectId': user.objectId!,
            '__type': 'Pointer',
            'className': '_User'
          },
        );

      BackendACL aclValue = BackendACL();

      aclValue.setReadAccess(
        userId: patient.objectId!,
        allowed: true,
      );

      aclValue.setReadAccess(
        userId: 'role:Doctor',
        allowed: true,
      );

      aclValue.setWriteAccess(
        userId: 'role:Doctor',
        allowed: true,
      );

      profileValues.setACL(aclValue.acl);

      resProfileValues = await profileValues.save();

      return resProfileValues.success;
    } else {
      return false;
    }
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
