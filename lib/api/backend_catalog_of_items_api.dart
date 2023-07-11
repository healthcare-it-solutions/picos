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
import 'package:picos/models/blood_gas_analysis_object.dart';
import 'package:picos/models/catalog_of_items_element.dart';
import 'package:picos/models/icu_diagnosis.dart';
import 'package:picos/models/labor_parameters.dart';
import 'package:picos/models/medicaments.dart';
import 'package:picos/models/patient.dart';
import 'package:picos/models/patient_data.dart';
import 'package:picos/models/patients_list_element.dart';
import 'package:picos/models/patient_profile.dart';
import 'package:collection/collection.dart';
import 'package:picos/models/respiratory_parameters_object.dart';
import 'package:picos/models/vital_signs_object.dart';
import 'package:picos/util/backend.dart';

/// API for calling the corresponding tables for the Catalog of Items.
class BackendCatalogOfItemsApi extends BackendObjectsApi {
  @override
  Future<void> saveObject(AbstractDatabaseObject object) async {
    try {
      dynamic responseICUDiagnosis = await Backend.saveObject(
        (object as CatalogOfItemsElement).icuDiagnosis,
      );

      ICUDiagnosis icuDiagnosis = object.icuDiagnosis.copyWith(
        objectId: responseICUDiagnosis['objectId'],
        createdAt: DateTime.tryParse(responseICUDiagnosis['createdAt'] ?? '') ??
            object.icuDiagnosis.createdAt,
        updatedAt: DateTime.tryParse(responseICUDiagnosis['updatedAt'] ?? '') ??
            object.icuDiagnosis.updatedAt,
      );

      dynamic responseVitalSignsObject = await Backend.saveObject(
        object.vitalSigns,
      );

      VitalSignsObject vitalSignsObject = object.vitalSigns.copyWith(
        objectId: responseVitalSignsObject['objectId'],
        createdAt:
            DateTime.tryParse(responseVitalSignsObject['createdAt'] ?? '') ??
                object.vitalSigns.createdAt,
        updatedAt:
            DateTime.tryParse(responseVitalSignsObject['updatedAt'] ?? '') ??
                object.vitalSigns.updatedAt,
      );

      dynamic responseRespiratoryParametersObject = await Backend.saveObject(
        object.respiratoryParameters,
      );

      RespiratoryParametersObject respiratoryParametersObject =
          object.respiratoryParameters.copyWith(
        objectId: responseRespiratoryParametersObject['objectId'],
        createdAt: DateTime.tryParse(
                responseRespiratoryParametersObject['createdAt'] ?? '') ??
            object.respiratoryParameters.createdAt,
        updatedAt: DateTime.tryParse(
                responseRespiratoryParametersObject['updatedAt'] ?? '') ??
            object.respiratoryParameters.updatedAt,
      );

      dynamic responseBloodGasAnalysisObject = await Backend.saveObject(
        object.bloodGasAnalysis,
      );

      BloodGasAnalysisObject bloodGasAnalysisObject =
          object.bloodGasAnalysis.copyWith(
        objectId: responseBloodGasAnalysisObject['objectId'],
        createdAt: DateTime.tryParse(
                responseBloodGasAnalysisObject['createdAt'] ?? '') ??
            object.bloodGasAnalysis.createdAt,
        updatedAt: DateTime.tryParse(
                responseBloodGasAnalysisObject['updatedAt'] ?? '') ??
            object.bloodGasAnalysis.updatedAt,
      );

      dynamic responseLaborParameters = await Backend.saveObject(
        object.laborParameters,
      );

      LaborParameters laborParameters = object.laborParameters.copyWith(
        objectId: responseLaborParameters['objectId'],
        createdAt:
            DateTime.tryParse(responseLaborParameters['createdAt'] ?? '') ??
                object.laborParameters.createdAt,
        updatedAt:
            DateTime.tryParse(responseLaborParameters['updatedAt'] ?? '') ??
                object.laborParameters.updatedAt,
      );

      dynamic responseMedicaments = await Backend.saveObject(
        object.medicaments,
      );

      Medicaments medicaments = object.medicaments.copyWith(
        objectId: responseMedicaments['objectId'],
        createdAt: DateTime.tryParse(responseMedicaments['createdAt'] ?? '') ??
            object.medicaments.createdAt,
        updatedAt: DateTime.tryParse(responseMedicaments['updatedAt'] ?? '') ??
            object.medicaments.updatedAt,
      );

      dynamic responseMovementData = await Backend.saveObject(
        object.movementData,
      );

      PatientData movementData = object.movementData.copyWith(
        objectId: responseMovementData['objectId'],
        createdAt: DateTime.tryParse(responseMovementData['createdAt'] ?? '') ??
            object.movementData.createdAt,
        updatedAt: DateTime.tryParse(responseMovementData['updatedAt'] ?? '') ??
            object.movementData.updatedAt,
      );

      object = object.copyWith(
        icuDiagnosis: icuDiagnosis,
        vitalSigns: vitalSignsObject,
        respiratoryParameters: respiratoryParametersObject,
        bloodGasAnalysis: bloodGasAnalysisObject,
        laborParameters: laborParameters,
        medicaments: medicaments,
        movementData: movementData,
      );

      int index = getIndex(object);

      if (index >= 0) {
        objectList[index] = object;
        objectList = <AbstractDatabaseObject>[...objectList];
      } else {
        objectList = <AbstractDatabaseObject>[...objectList, object];
      }

      dispatch();
    } catch (e) {
      Stream<List<PatientsListElement>>.error(e);
    }
  }

  @override
  Future<Stream<List<AbstractDatabaseObject>>> getObjects() async {
    try {
      List<dynamic> responsePatient =
          await Backend.getAll(Patient.databaseTable);
      List<dynamic> responsePatientData =
          await Backend.getAll(PatientData.databaseTable);
      List<dynamic> responsePatientProfile =
          await Backend.getAll(PatientProfile.databaseTable);

      List<Patient> patientResults = <Patient>[];
      List<PatientData> patientDataResults = <PatientData>[];
      List<PatientProfile> patientProfileResults = <PatientProfile>[];

      for (dynamic element in responsePatient) {
        patientResults.add(
          Patient(
            firstName: element['Firstname'] ?? '',
            familyName: element['Lastname'] ?? '',
            email: element['username'] ?? '',
            number: element['PhoneNo'] ?? '',
            address: element['Address'] ?? '',
            formOfAddress: element['Form'] ?? '',
            objectId: element['objectId'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
          ),
        );
      }

      for (dynamic element in responsePatientData) {
        patientDataResults.add(
          PatientData(
            bodyHeight: element['BodyHeight']['estimateNumber'].toDouble(),
            patientID: element['ID'],
            caseNumber: element['CaseNumber'],
            instKey: element['inst_key'],
            objectId: element['objectId'],
            patientObjectId: element['Patient']['objectId'],
            doctorObjectId: element['Doctor']['objectId'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
          ),
        );
      }

      for (dynamic element in responsePatientProfile) {
        patientProfileResults.add(
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
            objectId: element['objectId'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
          ),
        );
      }

      for (Patient patientObject in patientResults) {
        String? patientObjectId = patientObject.objectId;

        PatientData? matchingPatientData = patientDataResults.firstWhereOrNull(
          (PatientData patientDataObject) =>
              patientDataObject.patientObjectId == patientObjectId,
        );

        PatientProfile? matchingPatientProfile =
            patientProfileResults.firstWhereOrNull(
          (PatientProfile patientProfileObject) =>
              patientProfileObject.patientObjectId == patientObjectId,
        );

        if (matchingPatientData != null && matchingPatientProfile != null) {
          objectList.add(
            PatientsListElement(
              patient: patientObject,
              patientData: matchingPatientData,
              patientProfile: matchingPatientProfile,
              objectId: patientObject.objectId,
            ),
          );
        }
      }
      return getObjectsStream();
    } catch (e) {
      return Stream<List<PatientsListElement>>.error(e);
    }
  }
}
