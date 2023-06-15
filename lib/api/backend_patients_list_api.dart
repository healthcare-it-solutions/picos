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
import 'package:picos/models/abstract_database_object.dart';
import 'package:picos/models/patient.dart';
import 'package:picos/models/patient_data.dart';
import 'package:picos/models/patients_list_element.dart';
import 'package:picos/models/patient_profile.dart';
import 'package:collection/collection.dart';

/// Helper class for Join tables
class PatientJoinResult {
  /// Constructur
  PatientJoinResult(this._patient, this._patientData, this._patientProfile);

  ParseObject? _patient;

  ParseObject? _patientData;

  ParseObject? _patientProfile;

  /// set patient
  ParseObject? getPatient() {
    return _patient;
  }

  /// Set patient data
  ParseObject? getPatientData() {
    return _patientData;
  }

  /// Set patient profile
  ParseObject? getPatientProfile() {
    return _patientProfile;
  }

  /// set patient
  void setPatient(ParseObject newPatient) {
    _patient = newPatient;
  }

  /// Set patient data
  void setPatientData(ParseObject newPatientData) {
    _patientData = newPatientData;
  }

  /// Set patient profile
  void setPatientProfile(ParseObject newPatientProfile) {
    _patientProfile = newPatientProfile;
  }
}

/// API for calling teh corresponding tables for the patient list.
class BackendPatientsListApi extends BackendObjectsApi {
  @override
  Future<Stream<List<AbstractDatabaseObject>>> getObjects() async {
    try {
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

      for (PatientJoinResult element in joinQueryResults) {
        Patient patient = Patient(
          firstName: element._patient!.get('Firstname'),
          familyName: element._patient!.get('Lastname'),
          email: element._patient!.get('username'),
          number: element._patient!.get('PhoneNo'),
          address: element._patient!.get('Address'),
          formOfAddress: element._patient!.get('Form'),
        );

        PatientData patientData = PatientData(
          bodyHeight: element._patientData!.get('BodyHeight').toDouble(),
          patientID: element._patientData!.get('Patient').toString(),
          caseNumber: element._patientData!.get('CaseNumber'),
          instKey: element._patientData!.get('inst_key'),
        );

        PatientProfile patientProfile = PatientProfile(
          weightBMIEnabled:
              element._patientProfile!.get('Weight_BMI'),
          heartFrequencyEnabled:
              element._patientProfile!.get('HeartRate'),
          bloodPressureEnabled:
              element._patientProfile!.get('BloodPressure'),
          bloodSugarLevelsEnabled: element._patientProfile!.get('BloodSugar'),
          walkDistanceEnabled:
              element._patientProfile!.get('WalkingDistance'),
          sleepDurationEnabled:
              element._patientProfile!.get('SleepDuration'),
          sleepQualityEnabled:
              element._patientProfile!.get('SISQS'),
          painEnabled: element._patientProfile!.get('Pain'),
          phq4Enabled: element._patientProfile!.get('PHQ4'),
          medicationEnabled:
              element._patientProfile!.get('Medication'),
          therapyEnabled:
              element._patientProfile!.get('Therapies'),
          doctorsVisitEnabled:
              element._patientProfile!.get('Stays'),
          patientObjectId:
              element._patientProfile!.get('Patient').toString(),
          doctorObjectId:
              element._patientProfile!.get('Doctor').toString(),
        );

        objectList.add(
          PatientsListElement(
            patient: patient,
            patientData: patientData,
            patientProfile: patientProfile,
          ),
        );
      }

      return getObjectsStream();
    } catch (e) {
      return Stream<List<PatientsListElement>>.error(e);
    }
  }
}
