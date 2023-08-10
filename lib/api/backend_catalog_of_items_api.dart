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
import 'package:picos/models/blood_gas_analysis_object.dart';
import 'package:picos/models/catalog_of_items_element.dart';
import 'package:picos/models/icu_diagnosis.dart';
import 'package:picos/models/labor_parameters.dart';
import 'package:picos/models/patient_data.dart';
import 'package:collection/collection.dart';
import 'package:picos/models/respiratory_parameters_object.dart';
import 'package:picos/models/vital_signs_object.dart';
import 'package:picos/screens/study_nurse_screen/menu_screen/edit_patient_screen.dart';
import 'package:picos/util/backend.dart';

import 'package:picos/models/blood_gas_analysis.dart';
import 'package:picos/models/respiratory_parameters.dart';
import 'package:picos/models/vital_signs.dart';

/// API for calling the corresponding tables for the Catalog of Items.
class BackendCatalogOfItemsApi extends BackendObjectsApi {
  @override
  Future<void> saveObject(AbstractDatabaseObject object) async {
    BackendACL coiACL = BackendACL();
    if (object.createdAt == null) {
      coiACL.setWriteAccess(userId: BackendRole.doctor.id);
      coiACL.setReadAccess(userId: BackendRole.doctor.id);
      coiACL.setReadAccess(userId: EditPatientScreen.patientObjectId!);
    }

    try {
      if ((object as CatalogOfItemsElement).icuDiagnosis != null) {
        /// ICUDiagnosis
        await Backend.saveObject(
          object.icuDiagnosis!,
          acl: coiACL,
        );
      }
      VitalSignsObject? vitalSignsObject1;
      VitalSignsObject? vitalSignsObject2;
      if (object.vitalSignsObject1 != null) {
        /// VitalSigns value 1
        dynamic responseVitalSignsObject1 = await Backend.saveObject(
          object.vitalSignsObject1!,
          acl: coiACL,
        );
        vitalSignsObject1 = object.vitalSignsObject1!.copyWith(
          objectId: responseVitalSignsObject1['objectId'],
          createdAt: DateTime.tryParse(
                responseVitalSignsObject1['createdAt'] ?? '',
              ) ??
              object.vitalSignsObject1!.createdAt,
          updatedAt: DateTime.tryParse(
                responseVitalSignsObject1['updatedAt'] ?? '',
              ) ??
              object.vitalSignsObject1!.updatedAt,
        );
      }

      if (object.vitalSignsObject2 != null) {
        /// VitalSigns value 2
        dynamic responseVitalSignsObject2 = await Backend.saveObject(
          object.vitalSignsObject2!,
          acl: coiACL,
        );

        vitalSignsObject2 = object.vitalSignsObject2!.copyWith(
          objectId: responseVitalSignsObject2['objectId'],
          createdAt: DateTime.tryParse(
                responseVitalSignsObject2['createdAt'] ?? '',
              ) ??
              object.vitalSignsObject2!.createdAt,
          updatedAt: DateTime.tryParse(
                responseVitalSignsObject2['updatedAt'] ?? '',
              ) ??
              object.vitalSignsObject2!.updatedAt,
        );
      }

      if (object.vitalSigns != null) {
        /// VitalSigns
        object.vitalSigns!.value1 = vitalSignsObject1;
        object.vitalSigns!.value2 = vitalSignsObject2;
        await Backend.saveObject(
          object.vitalSigns!,
          acl: coiACL,
        );
      }

      RespiratoryParametersObject? respiratoryParametersObject1;
      RespiratoryParametersObject? respiratoryParametersObject2;
      if (object.respiratoryParametersObject1 != null) {
        /// Respiratory parameters value 1
        dynamic responseRespiratoryParametersObject1 = await Backend.saveObject(
          object.respiratoryParametersObject1!,
          acl: coiACL,
        );

        respiratoryParametersObject1 =
            object.respiratoryParametersObject1!.copyWith(
          objectId: responseRespiratoryParametersObject1['objectId'],
          createdAt: DateTime.tryParse(
                responseRespiratoryParametersObject1['createdAt'] ?? '',
              ) ??
              object.respiratoryParametersObject1!.createdAt,
          updatedAt: DateTime.tryParse(
                responseRespiratoryParametersObject1['updatedAt'] ?? '',
              ) ??
              object.respiratoryParametersObject1!.updatedAt,
        );
      }

      if (object.respiratoryParametersObject2 != null) {
        /// Respiratory parameters value 2
        dynamic responseRespiratoryParametersObject2 = await Backend.saveObject(
          object.respiratoryParametersObject2!,
          acl: coiACL,
        );

        respiratoryParametersObject2 =
            object.respiratoryParametersObject2!.copyWith(
          objectId: responseRespiratoryParametersObject2['objectId'],
          createdAt: DateTime.tryParse(
                responseRespiratoryParametersObject2['createdAt'] ?? '',
              ) ??
              object.respiratoryParametersObject2!.createdAt,
          updatedAt: DateTime.tryParse(
                responseRespiratoryParametersObject2['updatedAt'] ?? '',
              ) ??
              object.respiratoryParametersObject2!.updatedAt,
        );
      }

      if (object.respiratoryParameters != null) {
        /// Respiratory parameters
        object.respiratoryParameters!.value1 = respiratoryParametersObject1;
        object.respiratoryParameters!.value2 = respiratoryParametersObject2;
        await Backend.saveObject(
          object.respiratoryParameters!,
          acl: coiACL,
        );
      }

      BloodGasAnalysisObject? bloodGasAnalysisObject1;
      BloodGasAnalysisObject? bloodGasAnalysisObject2;
      if (object.bloodGasAnalysisObject1 != null) {
        /// Blood gas analysis value 1
        dynamic responseBloodGasAnalysisObject1 = await Backend.saveObject(
          object.bloodGasAnalysisObject1!,
          acl: coiACL,
        );

        bloodGasAnalysisObject1 = object.bloodGasAnalysisObject1!.copyWith(
          objectId: responseBloodGasAnalysisObject1['objectId'],
          createdAt: DateTime.tryParse(
                responseBloodGasAnalysisObject1['createdAt'] ?? '',
              ) ??
              object.bloodGasAnalysisObject1!.createdAt,
          updatedAt: DateTime.tryParse(
                responseBloodGasAnalysisObject1['updatedAt'] ?? '',
              ) ??
              object.bloodGasAnalysisObject1!.updatedAt,
        );
      }

      if (object.bloodGasAnalysisObject2 != null) {
        /// Blood gas analysis value 2
        dynamic responseBloodGasAnalysisObject2 = await Backend.saveObject(
          object.bloodGasAnalysisObject2!,
          acl: coiACL,
        );

        bloodGasAnalysisObject2 = object.bloodGasAnalysisObject2!.copyWith(
          objectId: responseBloodGasAnalysisObject2['objectId'],
          createdAt: DateTime.tryParse(
                responseBloodGasAnalysisObject2['createdAt'] ?? '',
              ) ??
              object.bloodGasAnalysisObject2!.createdAt,
          updatedAt: DateTime.tryParse(
                responseBloodGasAnalysisObject2['updatedAt'] ?? '',
              ) ??
              object.bloodGasAnalysisObject2!.updatedAt,
        );
      }

      if (object.bloodGasAnalysis != null) {
        /// Blood gas analysis
        object.bloodGasAnalysis!.value1 = bloodGasAnalysisObject1;
        object.bloodGasAnalysis!.value2 = bloodGasAnalysisObject2;
        await Backend.saveObject(
          object.bloodGasAnalysis!,
          acl: coiACL,
        );
      }

      if (object.laborParameters != null) {
        /// Labor parameters
        await Backend.saveObject(
          object.laborParameters!,
          acl: coiACL,
        );
      }

      if (object.movementData != null) {
        /// Movement data
        await Backend.saveObject(
          object.movementData!,
          acl: coiACL,
        );
      }

      dispatch();
    } catch (e) {
      Stream<List<CatalogOfItemsElement>>.error(e);
    }
  }

  @override
  Future<Stream<List<AbstractDatabaseObject>>> getObjects() async {
    return getObjectsStream();
  }

  ///Help method
  static List<VitalSignsObject>? _findMatchingObjectsVitalSigns(
    VitalSigns? matchingVitalSigns,
    List<VitalSignsObject> vitalSignsObjectResults,
  ) {
    if (matchingVitalSigns == null) {
      return null;
    }
    List<VitalSignsObject> matchingObjects = <VitalSignsObject>[];

    if (vitalSignsObjectResults.any(
          (VitalSignsObject obj) =>
              obj.objectId == matchingVitalSigns.valueObjectId1,
        ) &&
        vitalSignsObjectResults.any(
          (VitalSignsObject obj) =>
              obj.objectId == matchingVitalSigns.valueObjectId2,
        )) {
      matchingObjects.add(
        vitalSignsObjectResults.firstWhere(
          (VitalSignsObject obj) =>
              obj.objectId == matchingVitalSigns.valueObjectId1,
        ),
      );
      matchingObjects.add(
        vitalSignsObjectResults.firstWhere(
          (VitalSignsObject obj) =>
              obj.objectId == matchingVitalSigns.valueObjectId2,
        ),
      );
    }

    return matchingObjects;
  }

  static List<BloodGasAnalysisObject>? _findMatchingObjectsBloodGasAnalysis(
    BloodGasAnalysis? matchingBloodGasAnalysis,
    List<BloodGasAnalysisObject> bloodGasAnalysisObjectResults,
  ) {
    if (matchingBloodGasAnalysis == null) {
      return null;
    }

    List<BloodGasAnalysisObject> matchingObjects = <BloodGasAnalysisObject>[];
    if (bloodGasAnalysisObjectResults.any(
          (BloodGasAnalysisObject obj) =>
              obj.objectId == matchingBloodGasAnalysis.valueObjectId1,
        ) &&
        bloodGasAnalysisObjectResults.any(
          (BloodGasAnalysisObject obj) =>
              obj.objectId == matchingBloodGasAnalysis.valueObjectId2,
        )) {
      matchingObjects.add(
        bloodGasAnalysisObjectResults.firstWhere(
          (BloodGasAnalysisObject obj) =>
              obj.objectId == matchingBloodGasAnalysis.valueObjectId1,
        ),
      );
      matchingObjects.add(
        bloodGasAnalysisObjectResults.firstWhere(
          (BloodGasAnalysisObject obj) =>
              obj.objectId == matchingBloodGasAnalysis.valueObjectId2,
        ),
      );
    }

    return matchingObjects;
  }

  static List<RespiratoryParametersObject>?
      _findMatchingObjectsRespiratoryParameters(
    RespiratoryParameters? matchingRespiratoryParameters,
    List<RespiratoryParametersObject> respiratoryParametersObjectResults,
  ) {
    if (matchingRespiratoryParameters == null) {
      return null;
    }
    List<RespiratoryParametersObject> matchingObjects =
        <RespiratoryParametersObject>[];

    if (respiratoryParametersObjectResults.any(
          (RespiratoryParametersObject obj) =>
              obj.objectId == matchingRespiratoryParameters.valueObjectId1,
        ) &&
        respiratoryParametersObjectResults.any(
          (RespiratoryParametersObject obj) =>
              obj.objectId == matchingRespiratoryParameters.valueObjectId2,
        )) {
      matchingObjects.add(
        respiratoryParametersObjectResults.firstWhere(
          (RespiratoryParametersObject obj) =>
              obj.objectId == matchingRespiratoryParameters.valueObjectId1,
        ),
      );
      matchingObjects.add(
        respiratoryParametersObjectResults.firstWhere(
          (RespiratoryParametersObject obj) =>
              obj.objectId == matchingRespiratoryParameters.valueObjectId2,
        ),
      );
    }

    return matchingObjects;
  }

  /// Gets an object entry.
  static Future<CatalogOfItemsElement?> getObject() async {
    try {
      String? patientObjectId = EditPatientScreen.patientObjectId;

      List<ICUDiagnosis> icuDiagnosisResults = <ICUDiagnosis>[];
      List<VitalSigns> vitalSignsResults = <VitalSigns>[];
      List<VitalSignsObject> vitalSignsObjectResults = <VitalSignsObject>[];
      List<RespiratoryParameters> respiratoryParametersResults =
          <RespiratoryParameters>[];
      List<RespiratoryParametersObject> respiratoryParametersObjectResults =
          <RespiratoryParametersObject>[];
      List<BloodGasAnalysis> bloodGasAnalysisResults = <BloodGasAnalysis>[];
      List<BloodGasAnalysisObject> bloodGasAnalysisObjectResults =
          <BloodGasAnalysisObject>[];
      List<LaborParameters> laborParametersResults = <LaborParameters>[];
      List<PatientData> movementDataResults = <PatientData>[];

      ParseResponse responseICUDiagnosis = await Backend.getEntry(
        ICUDiagnosis.databaseTable,
        'Patient',
        EditPatientScreen.patientObjectId!,
      );
      if (responseICUDiagnosis.results != null) {
        for (dynamic element in responseICUDiagnosis.results!) {
          icuDiagnosisResults.add(
            ICUDiagnosis(
              mainDiagnosis: element['ICU_Hd'],
              ancillaryDiagnosis: element['Nebendiagnose'],
              intensiveCareUnitAcquiredWeakness: element['ICU_AW'],
              postIntensiveCareSyndrome: element['PICS'],
              patientObjectId: element['Patient']['objectId'],
              doctorObjectId: element['Doctor']['objectId'],
              objectId: element['objectId'],
              createdAt: element['createdAt'],
              updatedAt: element['updatedAt'],
            ),
          );
        }
      }

      ParseResponse responseVitalSigns = await Backend.getEntry(
        VitalSigns.databaseTable,
        'Patient',
        EditPatientScreen.patientObjectId!,
      );

      if (responseVitalSigns.results != null) {
        ParseResponse responseVitalSignsObject1 = await Backend.getEntry(
          VitalSignsObject.databaseTable,
          'objectId',
          responseVitalSigns.results![0]['value1']['objectId'],
        );

        ParseResponse responseVitalSignsObject2 = await Backend.getEntry(
          VitalSignsObject.databaseTable,
          'objectId',
          responseVitalSigns.results![0]['value2']['objectId'],
        );
        for (dynamic element in responseVitalSigns.results!) {
          vitalSignsResults.add(
            VitalSigns(
              valueObjectId1: element['value1']['objectId'],
              valueObjectId2: element['value2']['objectId'],
              objectId: element['objectId'],
              patientObjectId: element['Patient']['objectId'],
              doctorObjectId: element['Doctor']['objectId'],
              createdAt: element['createdAt'],
              updatedAt: element['updatedAt'],
            ),
          );
        }
        for (dynamic element in responseVitalSignsObject1.results!) {
          vitalSignsObjectResults.add(
            VitalSignsObject(
              heartRate: element['HeartRate']?.toDouble(),
              systolicArterialPressure: element['SAP']?.toDouble(),
              meanArterialPressure: element['MAP']?.toDouble(),
              diastolicArterialPressure: element['DAP']?.toDouble(),
              centralVenousPressure: element['ZVD']?.toDouble(),
              objectId: element['objectId'],
              createdAt: element['createdAt'],
              updatedAt: element['updatedAt'],
            ),
          );
        }

        for (dynamic element in responseVitalSignsObject2.results!) {
          vitalSignsObjectResults.add(
            VitalSignsObject(
              heartRate: element['HeartRate']?.toDouble(),
              systolicArterialPressure: element['SAP']?.toDouble(),
              meanArterialPressure: element['MAP']?.toDouble(),
              diastolicArterialPressure: element['DAP']?.toDouble(),
              centralVenousPressure: element['ZVD']?.toDouble(),
              objectId: element['objectId'],
              createdAt: element['createdAt'],
              updatedAt: element['updatedAt'],
            ),
          );
        }
      }

      ParseResponse responseRespiratoryParameters = await Backend.getEntry(
        RespiratoryParameters.databaseTable,
        'Patient',
        EditPatientScreen.patientObjectId!,
      );

      if (responseRespiratoryParameters.results != null) {
        ParseResponse responseRespiratoryParametersObject1 =
            await Backend.getEntry(
          RespiratoryParametersObject.databaseTable,
          'objectId',
          responseRespiratoryParameters.results![0]['value1']['objectId'],
        );
        ParseResponse responseRespiratoryParametersObject2 =
            await Backend.getEntry(
          RespiratoryParametersObject.databaseTable,
          'objectId',
          responseRespiratoryParameters.results![0]['value2']['objectId'],
        );

        for (dynamic element in responseRespiratoryParameters.results!) {
          respiratoryParametersResults.add(
            RespiratoryParameters(
              valueObjectId1: element['value1']['objectId'],
              valueObjectId2: element['value2']['objectId'],
              patientObjectId: element['Patient']['objectId'],
              doctorObjectId: element['Doctor']['objectId'],
              objectId: element['objectId'],
              createdAt: element['createdAt'],
              updatedAt: element['updatedAt'],
            ),
          );
        }

        for (dynamic element in responseRespiratoryParametersObject1.results!) {
          respiratoryParametersObjectResults.add(
            RespiratoryParametersObject(
              tidalVolume: element['VT']?.toDouble(),
              respiratoryRate: element['AF']?.toDouble(),
              oxygenSaturation: element['SpO2']?.toDouble(),
              objectId: element['objectId'],
              createdAt: element['createdAt'],
              updatedAt: element['updatedAt'],
            ),
          );
        }

        for (dynamic element in responseRespiratoryParametersObject2.results!) {
          respiratoryParametersObjectResults.add(
            RespiratoryParametersObject(
              tidalVolume: element['VT']?.toDouble(),
              respiratoryRate: element['AF']?.toDouble(),
              oxygenSaturation: element['SpO2']?.toDouble(),
              objectId: element['objectId'],
              createdAt: element['createdAt'],
              updatedAt: element['updatedAt'],
            ),
          );
        }
      }

      ParseResponse responseBloodGasAnalysis = await Backend.getEntry(
        BloodGasAnalysis.databaseTable,
        'Patient',
        EditPatientScreen.patientObjectId!,
      );

      if (responseBloodGasAnalysis.results != null) {
        ParseResponse responseBloodGasAnalysisObject1 = await Backend.getEntry(
          BloodGasAnalysisObject.databaseTable,
          'objectId',
          responseBloodGasAnalysis.results![0]['value1']['objectId'],
        );

        ParseResponse responseBloodGasAnalysisObject2 = await Backend.getEntry(
          BloodGasAnalysisObject.databaseTable,
          'objectId',
          responseBloodGasAnalysis.results![0]['value2']['objectId'],
        );

        for (dynamic element in responseBloodGasAnalysis.results!) {
          bloodGasAnalysisResults.add(
            BloodGasAnalysis(
              valueObjectId1: element['value1']['objectId'],
              valueObjectId2: element['value2']['objectId'],
              patientObjectId: element['Patient']['objectId'],
              doctorObjectId: element['Doctor']['objectId'],
              objectId: element['objectId'],
              createdAt: element['createdAt'],
              updatedAt: element['updatedAt'],
            ),
          );
        }

        for (dynamic element in responseBloodGasAnalysisObject1.results!) {
          bloodGasAnalysisObjectResults.add(
            BloodGasAnalysisObject(
              arterialOxygenSaturation: element['SaO2']?.toDouble(),
              centralVenousOxygenSaturation: element['SzVO2']?.toDouble(),
              partialPressureOfOxygen: element['PaO2_woTemp']?.toDouble(),
              partialPressureOfCarbonDioxide:
                  element['PaCO2_woTemp']?.toDouble(),
              arterialBaseExcess: element['BE']?.toDouble(),
              arterialPH: element['pH']?.toDouble(),
              arterialSerumBicarbonateConcentration:
                  element['Bicarbonat']?.toDouble(),
              arterialLactate: element['Laktat']?.toDouble(),
              bloodGlucoseLevel: element['BloodSugar']?.toDouble(),
              objectId: element['objectId'],
              createdAt: element['createdAt'],
              updatedAt: element['updatedAt'],
            ),
          );
        }

        for (dynamic element in responseBloodGasAnalysisObject2.results!) {
          bloodGasAnalysisObjectResults.add(
            BloodGasAnalysisObject(
              arterialOxygenSaturation: element['SaO2']?.toDouble(),
              centralVenousOxygenSaturation: element['SzVO2']?.toDouble(),
              partialPressureOfOxygen: element['PaO2_woTemp']?.toDouble(),
              partialPressureOfCarbonDioxide:
                  element['PaCO2_woTemp']?.toDouble(),
              arterialBaseExcess: element['BE']?.toDouble(),
              arterialPH: element['pH']?.toDouble(),
              arterialSerumBicarbonateConcentration:
                  element['Bicarbonat']?.toDouble(),
              arterialLactate: element['Laktat']?.toDouble(),
              bloodGlucoseLevel: element['BloodSugar']?.toDouble(),
              objectId: element['objectId'],
              createdAt: element['createdAt'],
              updatedAt: element['updatedAt'],
            ),
          );
        }
      }

      ParseResponse responseLaborParameters = await Backend.getEntry(
        LaborParameters.databaseTable,
        'Patient',
        EditPatientScreen.patientObjectId!,
      );

      ParseResponse responseMovementData = await Backend.getEntry(
        PatientData.databaseTable,
        'Patient',
        EditPatientScreen.patientObjectId!,
      );

      if (responseLaborParameters.results != null) {
        for (dynamic element in responseLaborParameters.results!) {
          laborParametersResults.add(
            LaborParameters(
              leukocyteCount: element['Leukozyten']?.toDouble(),
              lymphocyteCount: element['Lymphozyten_abs']?.toDouble(),
              lymphocytePercentage: element['Lymphozyten_proz']?.toDouble(),
              plateletCount: element['Thrombozyten']?.toDouble(),
              cReactiveProteinLevel: element['CRP']?.toDouble(),
              procalcitoninLevel: element['PCT']?.toDouble(),
              interleukin: element['IL_6']?.toDouble(),
              bloodUreaNitrogen: element['Urea']?.toDouble(),
              creatinine: element['Kreatinin']?.toDouble(),
              heartFailureMarker: element['BNP']?.toDouble(),
              heartFailureMarkerNTProBNP: element['NT_Pro_BNP']?.toDouble(),
              bilirubinTotal: element['Bilirubin']?.toDouble(),
              hemoglobin: element['Haemoglobin']?.toDouble(),
              hematocrit: element['Haematokrit']?.toDouble(),
              albumin: element['Albumin']?.toDouble(),
              gotASAT: element['GOT']?.toDouble(),
              gptALAT: element['GPT']?.toDouble(),
              troponin: element['Troponin']?.toDouble(),
              creatineKinase: element['CK']?.toDouble(),
              myocardialInfarctionMarkerCKMB: element['CK_MB']?.toDouble(),
              lactateDehydrogenaseLevel: element['LDH']?.toDouble(),
              amylaseLevel: element['Amylase']?.toDouble(),
              lipaseLevel: element['Lipase']?.toDouble(),
              dDimer: element['D_Dimere']?.toDouble(),
              internationalNormalizedRatio: element['INR']?.toDouble(),
              partialThromboplastinTime: element['pTT']?.toDouble(),
              patientObjectId: element['Patient']['objectId'],
              doctorObjectId: element['Doctor']['objectId'],
              objectId: element['objectId'],
              createdAt: element['createdAt'],
              updatedAt: element['updatedAt'],
            ),
          );
        }
      }

      if (responseMovementData.results != null) {
        for (dynamic element in responseMovementData.results!) {
          movementDataResults.add(
            PatientData(
              bodyHeight: element['BodyHeight']?.toDouble(),
              patientID: element['ID'],
              caseNumber: element['CaseNumber'],
              instKey: element['inst_key'],
              bodyWeight: element['BodyWeight']?.toDouble(),
              ezpICU: element['EZP_ICU'],
              birthDate: element['Birthdate'],
              gender: element['Gender'],
              bmi: element['BMI']?.toDouble(),
              idealBMI: element['IdealBodyWeight']?.toDouble(),
              azpICU: (element['AZP_ICU']),
              ventilationDays: element['VentilationDays'],
              azpKH: element['AZP_KH'],
              ezpKH: element['EZP_KH'],
              icd10Codes: element['ICD_10_Codes'],
              station: element['Station'],
              lbgt70: element['LBgt70'],
              icuLengthStay: element['ICU_LengthStay'],
              khLengthStay: element['KH_LengthStay'],
              wdaICU: element['WdaICU2'],
              objectId: element['objectId'],
              patientObjectId: element['Patient']['objectId'],
              doctorObjectId: element['Doctor']['objectId'],
              createdAt: element['createdAt'],
              updatedAt: element['updatedAt'],
            ),
          );
        }
      }

      ICUDiagnosis? matchingICUDiagnosis = icuDiagnosisResults.firstWhereOrNull(
        (ICUDiagnosis icuDiagnosisObject) =>
            icuDiagnosisObject.patientObjectId == patientObjectId,
      );

      VitalSigns? matchingVitalSigns = vitalSignsResults.firstWhereOrNull(
        (VitalSigns vitalSignsObject) =>
            vitalSignsObject.patientObjectId == patientObjectId,
      );

      RespiratoryParameters? matchingRespiratoryParameters =
          respiratoryParametersResults.firstWhereOrNull(
        (RespiratoryParameters respiratoryParametersObject) =>
            respiratoryParametersObject.patientObjectId == patientObjectId,
      );

      BloodGasAnalysis? matchingBloodGasAnalysis =
          bloodGasAnalysisResults.firstWhereOrNull(
        (BloodGasAnalysis bloodGasAnalysisObject) =>
            bloodGasAnalysisObject.patientObjectId == patientObjectId,
      );

      LaborParameters? matchingLaborParameters =
          laborParametersResults.firstWhereOrNull(
        (LaborParameters laborParametersObject) =>
            laborParametersObject.patientObjectId == patientObjectId,
      );

      PatientData? matchingMovementData = movementDataResults.firstWhereOrNull(
        (PatientData movementDataObject) =>
            movementDataObject.patientObjectId == patientObjectId,
      );

      CatalogOfItemsElement? result;
      if (matchingICUDiagnosis != null ||
          matchingVitalSigns != null ||
          matchingRespiratoryParameters != null ||
          matchingBloodGasAnalysis != null ||
          matchingLaborParameters != null ||
          matchingMovementData != null) {
        List<VitalSignsObject>? foundObjectsVitalSigns =
            _findMatchingObjectsVitalSigns(
          matchingVitalSigns,
          vitalSignsObjectResults,
        );

        List<BloodGasAnalysisObject>? foundObjectsBloodGasAnalysis =
            _findMatchingObjectsBloodGasAnalysis(
          matchingBloodGasAnalysis,
          bloodGasAnalysisObjectResults,
        );

        List<RespiratoryParametersObject>? foundObjectsRespiratoryParameters =
            _findMatchingObjectsRespiratoryParameters(
          matchingRespiratoryParameters,
          respiratoryParametersObjectResults,
        );

        result = CatalogOfItemsElement(
          icuDiagnosis: matchingICUDiagnosis,
          vitalSigns: matchingVitalSigns,
          vitalSignsObject1: foundObjectsVitalSigns?[0],
          vitalSignsObject2: foundObjectsVitalSigns?[1],
          respiratoryParameters: matchingRespiratoryParameters,
          respiratoryParametersObject1: foundObjectsRespiratoryParameters?[0],
          respiratoryParametersObject2: foundObjectsRespiratoryParameters?[1],
          bloodGasAnalysis: matchingBloodGasAnalysis,
          bloodGasAnalysisObject1: foundObjectsBloodGasAnalysis?[0],
          bloodGasAnalysisObject2: foundObjectsBloodGasAnalysis?[1],
          laborParameters: matchingLaborParameters,
          movementData: matchingMovementData,
          objectId: patientObjectId,
        );
      }

      return result;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> removeObject(AbstractDatabaseObject object) async {
    try {
      CatalogOfItemsElement? coi = object as CatalogOfItemsElement?;

      if (coi?.icuDiagnosis != null) {
        await Backend.removeObject(coi!.icuDiagnosis!);
      }
      if (coi?.vitalSignsObject1 != null) {
        await Backend.removeObject(coi!.vitalSignsObject1!);
      }
      if (coi?.vitalSignsObject2 != null) {
        await Backend.removeObject(coi!.vitalSignsObject2!);
      }
      if (coi?.vitalSigns != null) {
        await Backend.removeObject(coi!.vitalSigns!);
      }
      if (coi?.bloodGasAnalysisObject1 != null) {
        await Backend.removeObject(coi!.bloodGasAnalysisObject1!);
      }
      if (coi?.bloodGasAnalysisObject2 != null) {
        await Backend.removeObject(coi!.bloodGasAnalysisObject2!);
      }
      if (coi?.bloodGasAnalysis != null) {
        await Backend.removeObject(coi!.bloodGasAnalysis!);
      }
      if (coi?.respiratoryParametersObject1 != null) {
        await Backend.removeObject(coi!.respiratoryParametersObject1!);
      }
      if (coi?.respiratoryParametersObject2 != null) {
        await Backend.removeObject(coi!.respiratoryParametersObject2!);
      }
      if (coi?.respiratoryParameters != null) {
        await Backend.removeObject(coi!.respiratoryParameters!);
      }
      if (coi?.laborParameters != null) {
        await Backend.removeObject(coi!.laborParameters!);
      }

      dispatch();
    } catch (e) {
      return;
    }
  }
}
