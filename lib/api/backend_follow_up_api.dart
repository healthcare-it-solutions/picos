import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:picos/models/follow_up.dart';
import 'package:picos/util/backend.dart';

import '../screens/study_nurse_screen/menu_screen/edit_patient_screen.dart';

/// API for storing values at the backend.
class BackendFollowUpApi {
  /// Fetches follow-ups from the backend for a given patient and doctor.
  static Future<List<FollowUp>> getFollowUps() async {
    final String patientObjectId = EditPatientScreen.patientObjectId!;
    final String doctorObjectId = Backend.user.objectId!;

    List<FollowUp> followUpResults = List<FollowUp>.generate(
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
          if (index >= 0 && index < followUpResults.length) {
            followUpResults[index] = createFollowUpFromElement(element);
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching follow-ups: $e');
      }
    }
    return followUpResults;
  }

  /// Creates a FollowUp object from a Parse object element.
  static FollowUp createFollowUpFromElement(dynamic element) {
    return FollowUp(
      distance: element['Strecke'],
      bloodDiastolic: element['BD_Diastolisch'],
      bloodSystolic: element['BD_Systolisch'],
      rhythm: element['Rythmus'],
      rhythmTyp: element['RythmusTyp'],
      testResult: element['Testergebnis'],
      healthState: element['HealthState'],
      locationType: element['Lagetyp'],
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

  /// Saves a follow-up into the backend with the appropriate ACL settings.
  static Future<void> saveFollowUp(FollowUp followUp) async {
    BackendACL followUpACL = BackendACL()
      ..setReadAccess(userId: EditPatientScreen.patientObjectId!)
      ..setReadAccess(userId: BackendRole.doctor.id)
      ..setWriteAccess(userId: BackendRole.doctor.id);

    await Backend.saveObject(followUp, acl: followUpACL);
  }
}
