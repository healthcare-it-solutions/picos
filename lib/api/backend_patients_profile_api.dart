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

import 'package:picos/api/backend_objects_api.dart';
import 'package:picos/models/abstract_database_object.dart';
import 'package:picos/models/patient_profile.dart';

import '../util/backend.dart';

/// API for storing patients' profile data at the backend.
class BackendPatientsProfileApi extends BackendObjectsApi {
  @override
  Future<Stream<List<AbstractDatabaseObject>>> getObjects() async {
    try {
      List<dynamic> response =
          await Backend.getAll(PatientProfile.databaseTable);

      for (dynamic element in response) {
        objectList.add(
          PatientProfile(
            weightBMIEnabled: element['Weight_BMI'],
            heartFrequencyEnabled: element['HeartRate'],
            bloodPressureEnabled: element['BloodPressure'],
            bloodSugarLevelsEnabled: element['BloodSugar'],
            walkDistanceEnabled: element['WalkingDistance'],
            sleepDurationEnabled: element['SleepDuration'],
            sleepQualityEnabled: element['SISQS'],
            painEnabled: element['Pain'],
            phq4Enabled: element['PHQ4'],
            medicationEnabled: element['Medication'],
            therapyEnabled: element['Therapies'],
            doctorsVisitEnabled: element['Stays'],
            patientObjectId: element['Patient']['objectId'],
            doctorObjectId: element['Doctor']['objectId'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
          ),
        );
      }

      return getObjectsStream();
    } catch (e) {
      return Stream<List<PatientProfile>>.error(e);
    }
  }
}