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

import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:picos/models/follow_up.dart';
import 'package:picos/util/backend.dart';

import '../screens/study_nurse_screen/menu_screen/edit_patient_screen.dart';

/// API for storing values at the backend.
class BackendFollowUpApi {
  /// API interface providing methods to fetch values from the backend.
  static Future<List<FollowUp>> getFollowUps() async {
    final String patientObjectId = EditPatientScreen.patientObjectId!;
    final String doctorObjectId = Backend.user.objectId!;

    List<FollowUp> followUpResults = <FollowUp>[];
    for (int i = 0; i <= 3; i++) {
      followUpResults.add(
        FollowUp(
          patientObjectId: patientObjectId,
          doctorObjectId: doctorObjectId,
          number: i,
        ),
      );
    }

    try {
      ParseResponse? responseFollowUps = await Backend.getEntry(
        FollowUp.databaseTable,
        'Patient',
        patientObjectId,
      );
      if (responseFollowUps?.results != null) {
        for (dynamic element in responseFollowUps!.results!) {
          followUpResults.add(
            FollowUp(
              distance: element['Strecke']['estimateNumber'].toDouble(),
              bloodDiastolic: element['BD_Diastolisch'],
              bloodSystolic: element['BD_Systolisch'],
              rythmus: element['Rythmus'],
              testResult: element['TestResult'],
              healthState: element['HealthState'],
              locationType: element['Lagetype'],
              heartRate: element['Herzfrequenz']['estimateNumber'].toDouble(),
              healthScore: element['Gesundheitsscore'],
              number: element['number'],
              objectId: element['objectId'],
              patientObjectId: element['Patient']['objectId'],
              doctorObjectId: element['Doctor']['objectId'],
              createdAt: element['createdAt'],
              updatedAt: element['updatedAt'],
            ),
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return followUpResults;
  }

  /// API interface providing methods to save values in the backend.
  static Future<void> saveFollowUp(FollowUp followUp) async {
    await Backend.saveObject(followUp);
  }
}
