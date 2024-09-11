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
      FollowUp followUp = (object as FollowUp);

      if (followUp.objectId == null) {
        String roleId = await BackendRole.userRoleName.id;
        BackendACL followUpACL = BackendACL()
          ..setReadAccess(userId: EditPatientScreen.patientObjectId!)
          ..setReadAccess(userId: roleId)
          ..setWriteAccess(userId: roleId);
        await Backend.saveObject(followUp, acl: followUpACL);
      } else {
        await Backend.saveObject(followUp);
      }

      super.updateObjectList(followUp);
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
      return Future<List<FollowUp>>.error(e);
    }
  }

  /// Creates a FollowUp object from a Parse object element.
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
