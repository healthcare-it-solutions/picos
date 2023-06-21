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
import 'package:picos/util/backend.dart';

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

/// API for calling the corresponding tables for the patient list.
class BackendPatientsListApi extends BackendObjectsApi {
  @override
  Future<void> saveObject(AbstractDatabaseObject object) async {
    PatientData patientData;
    PatientProfile patientProfile;

    /*dynamic responsePatient =
        await Backend.saveObject((object as PatientsListElement).patient);

    patient = object.patient.copyWith(
      objectId: responsePatient['objectId'],
      createdAt: DateTime.tryParse(responsePatient['createdAt'] ?? '') ??
          object.patient.createdAt,
      updatedAt: DateTime.tryParse(responsePatient['updatedAt'] ?? '') ??
          object.patient.updatedAt,
    );*/

    try {
      dynamic responsePatientData =
          await Backend.saveObject((object as PatientsListElement).patientData);

      patientData = object.patientData.copyWith(
        objectId: responsePatientData['objectId'],
        createdAt: DateTime.tryParse(responsePatientData['createdAt'] ?? '') ??
            object.patientData.createdAt,
        updatedAt: DateTime.tryParse(responsePatientData['updatedAt'] ?? '') ??
            object.patientData.updatedAt,
      );

      dynamic responsePatientProfile =
          await Backend.saveObject((object).patientProfile);

      patientProfile = object.patientProfile.copyWith(
        objectId: responsePatientProfile['objectId'],
        createdAt:
            DateTime.tryParse(responsePatientProfile['createdAt'] ?? '') ??
                object.patientProfile.createdAt,
        updatedAt:
            DateTime.tryParse(responsePatientProfile['updatedAt'] ?? '') ??
                object.patientProfile.updatedAt,
      );

      object = object.copyWith(
        patientData: patientData,
        patientProfile: patientProfile,
      );

      int index = getIndex(object);

      if (index >= 0) {
        objectList[index] = object;
        objectList = <AbstractDatabaseObject>[...objectList];
      }

      if (index < 0) {
        objectList = <AbstractDatabaseObject>[...objectList, object];
      }

      dispatch();
    } catch (e) {}
  }

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

      try {
        for (PatientJoinResult element in joinQueryResults) {
          Patient patient = Patient(
            firstName: element._patient!.get('Firstname').toString(),
            familyName: element._patient!.get('Lastname').toString(),
            email: element._patient!.get('username').toString(),
            number: element._patient!.get('PhoneNo').toString(),
            address: element._patient!.get('Address').toString(),
            formOfAddress: element._patient!.get('Form').toString(),
            objectId: element._patient!.get('objectId').toString(),
            createdAt: element._patient!.get('createdAt'),
            updatedAt: element._patient!.get('updatedAt'),
          );

          PatientData patientData = PatientData(
            bodyHeight: element._patientData!.get('BodyHeight').toDouble(),
            patientID: element._patientData!.get('ID').toString(),
            caseNumber: element._patientData!.get('CaseNumber').toString(),
            instKey: element._patientData!.get('inst_key').toString(),
            objectId: element._patientData!.get('objectId').toString(),
            patientObjectId:
                element._patientData!.get('Patient')?.objectId.toString(),
            doctorObjectId:
                element._patientData!.get('Doctor')?.objectId.toString(),
            createdAt: element._patientData!.get('createdAt'),
            updatedAt: element._patientData!.get('updatedAt'),
          );

          PatientProfile patientProfile = PatientProfile(
            weightBMIEnabled: element._patientProfile!.get('Weight_BMI'),
            heartFrequencyEnabled: element._patientProfile!.get('HeartRate'),
            bloodPressureEnabled: element._patientProfile!.get('BloodPressure'),
            bloodSugarLevelsEnabled: element._patientProfile!.get('BloodSugar'),
            walkDistanceEnabled:
                element._patientProfile!.get('WalkingDistance'),
            sleepDurationEnabled: element._patientProfile!.get('SleepDuration'),
            sleepQualityEnabled: element._patientProfile!.get('SISQS'),
            painEnabled: element._patientProfile!.get('Pain'),
            phq4Enabled: element._patientProfile!.get('PHQ4'),
            medicationEnabled: element._patientProfile!.get('Medication'),
            therapyEnabled: element._patientProfile!.get('Therapies'),
            doctorsVisitEnabled: element._patientProfile!.get('Stays'),
            patientObjectId: element._patientProfile!.get('Patient')?.objectId,
            doctorObjectId: element._patientProfile!.get('Doctor')?.objectId,
            objectId: element._patientProfile!.get('objectId').toString(),
            createdAt: element._patientProfile!.get('createdAt'),
            updatedAt: element._patientProfile!.get('updatedAt'),
          );

          objectList.add(
            PatientsListElement(
              patient: patient,
              patientData: patientData,
              patientProfile: patientProfile,
            ),
          );
        }
      } catch (e) {
        return Stream<List<PatientsListElement>>.error(e);
      }

      return getObjectsStream();
    } catch (e) {
      return Stream<List<PatientsListElement>>.error(e);
    }
  }
}
