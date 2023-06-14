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

import 'dart:async';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:picos/api/backend_objects_api.dart';
import 'package:picos/api/patient_join_result.dart';
import 'package:picos/models/abstract_database_object.dart';
import 'package:picos/models/patient.dart';
import 'package:picos/models/patient_data.dart';
import 'package:picos/models/patient_profile.dart';
import 'package:collection/collection.dart';

/// API for calling teh corresponding tables for the patient list.
class BackendPatientListApi extends BackendObjectsApi {
  @override
  Future<Stream<List<AbstractDatabaseObject>>> getObjects() async {
    ParseObject patient = ParseObject(Patient.databaseTable);

    ParseObject patientData = ParseObject(PatientData.databaseTable);

    ParseObject patientProfile = ParseObject(PatientProfile.databaseTable);

    final QueryBuilder<ParseObject> parseQueryPatient =
        QueryBuilder<ParseObject>(patient);

    final QueryBuilder<ParseObject> parseQueryPatientData =
        QueryBuilder<ParseObject>(patientData);

    final QueryBuilder<ParseObject> parseQueryPatientProfile =
        QueryBuilder<ParseObject>(patientProfile);

    List<PatientJoinResult> joinQueryResults = <PatientJoinResult>[];

    List<ParseObject> patientResults = await parseQueryPatient.find();
    List<ParseObject> patientDataResults = await parseQueryPatientData.find();
    List<ParseObject> patientProfileResults =
        await parseQueryPatientProfile.find();

    for (ParseObject patientObject in patientResults) {
      String? patientObjectId = patientObject.objectId;

      ParseObject? matchingPatientData = patientDataResults.firstWhereOrNull(
        (ParseObject patientDataObject) =>
            patientDataObject.get('Patient')?.objectId == patientObjectId,
      );

      ParseObject? matchingPatientProfile =
          patientProfileResults.firstWhereOrNull(
        (ParseObject patientProfileObject) =>
            patientProfileObject.get('Patient')?.objectId == patientObjectId,
      );

      if (matchingPatientData != null && matchingPatientProfile != null) {
        PatientJoinResult patientJoinResult = PatientJoinResult(
          patientObject,
          matchingPatientData,
          matchingPatientProfile,
        );
        joinQueryResults.add(patientJoinResult);
      }
    }

    return getObjectsStream();
  }
/*catch (e) {
      return Stream<List<DailyInput>>.error(e);
    }*/
}
