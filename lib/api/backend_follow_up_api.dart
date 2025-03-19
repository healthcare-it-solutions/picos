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
import 'package:picos/models/abstract_database_object.dart';
import 'package:picos/models/follow_up.dart';
import 'package:picos/util/backend.dart';

import '../screens/study_nurse_screen/menu_screen/edit_patient_screen.dart';
import 'backend_objects_api.dart';

/// API for storing values at the backend.
class BackendFollowUpApi extends BackendObjectsApi {
  @override
  Future<void> saveObject(AbstractDatabaseObject object) async {
    try {
      if ((object as FollowUp).objectId == null) {
        String roleId = await BackendRole.userRoleName.id;
        BackendACL followUpACL = BackendACL()
          ..setReadAccess(userId: EditPatientScreen.patientObjectId!)
          ..setReadAccess(userId: roleId)
          ..setWriteAccess(userId: roleId);
        dynamic responseSave =
            await Backend.saveObject(object, acl: followUpACL);
        object = object.copyWith(
          objectId: responseSave['objectId'],
          createdAt: DateTime.tryParse(responseSave['createdAt'] ?? ''),
        );
      } else {
        dynamic responseUpdate = await Backend.saveObject(object);
        object = object.copyWith(
          updatedAt: DateTime.tryParse(responseUpdate['updatedAt'] ?? ''),
        );
      }

      objectList[object.number!] = object;

      dispatch();
    } catch (e) {
      return Future<void>.error(e);
    }
  }

  @override
  Future<List<AbstractDatabaseObject>> getObjects() async {
    final String patientObjectId = EditPatientScreen.patientObjectId!;
    final String doctorObjectId = Backend.user.objectId!;

    objectList = List<FollowUp>.generate(
      4,
      (int i) => FollowUp(
        patientObjectId: patientObjectId,
        doctorObjectId: doctorObjectId,
        number: i,
      ),
    );

    try {
      ParseResponse? responseFollowUps = await Backend.getEntry(
        FollowUp.databaseTable,
        'Patient',
        patientObjectId,
      );
      if (responseFollowUps?.results != null) {
        for (dynamic element in responseFollowUps!.results!) {
          int index = element['number'];
          if (index >= 0 && index < objectList.length) {
            objectList[index] = _createFollowUpModel(element);
          }
        }
      }
      return objectList;
    } catch (e) {
      return Future<List<AbstractDatabaseObject>>.error(e);
    }
  }

  FollowUp _createFollowUpModel(dynamic element) {
    return FollowUp(
      distance: element['Strecke'],
      bloodDiastolic: element['BD_Diastolisch'],
      bloodSystolic: element['BD_Systolisch'],
      rhythm: element['Rythmus'],
      rhythmType: element['RythmusTyp'],
      testResult: element['Testergebnis'],
      healthState: element['HealthState'],
      electricalAxisDeviation: element['Lagetyp'],
      heartRate: element['Herzfrequenz'],
      healthScore: element['Gesundheitsscore'],
      number: element['number'],
      objectId: element['objectId'],
      patientObjectId: element['Patient']['objectId'],
      doctorObjectId: element['Doctor']['objectId'],
      createdAt: element['createdAt'],
      updatedAt: element['updatedAt'],
    );
  }
}
