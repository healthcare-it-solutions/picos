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
    try {
      acl = await _prepareACL();

      /// ICUDiagnosis.
      await _saveObject((object as CatalogOfItemsElement).icuDiagnosis);

      VitalSignsObject? vitalSignsObject1;
      VitalSignsObject? vitalSignsObject2;

      /// VitalSigns value 1.
      dynamic responseVitalSignsObject1 =
          await _saveObject(object.vitalSignsObject1);
      vitalSignsObject1 = await _updateObjectProperties(
        object.vitalSignsObject1,
        responseVitalSignsObject1,
      );

      /// VitalSigns value 2.
      dynamic responseVitalSignsObject2 =
          await _saveObject(object.vitalSignsObject2);

      vitalSignsObject2 = await _updateObjectProperties(
        object.vitalSignsObject2,
        responseVitalSignsObject2,
      );

      /// VitalSigns.
      object.vitalSigns!.value1 = vitalSignsObject1;
      object.vitalSigns!.value2 = vitalSignsObject2;
      await _saveObject(object.vitalSigns);

      RespiratoryParametersObject? respiratoryParametersObject1;
      RespiratoryParametersObject? respiratoryParametersObject2;

      /// Respiratory parameters value 1.
      dynamic responseRespiratoryParametersObject1 =
          await _saveObject(object.respiratoryParametersObject1);

      respiratoryParametersObject1 = await _updateObjectProperties(
        object.respiratoryParametersObject1,
        responseRespiratoryParametersObject1,
      );

      /// Respiratory parameters value 2.
      dynamic responseRespiratoryParametersObject2 =
          await _saveObject(object.respiratoryParametersObject2);

      respiratoryParametersObject2 = await _updateObjectProperties(
        object.respiratoryParametersObject2,
        responseRespiratoryParametersObject2,
      );

      /// Respiratory parameters.
      object.respiratoryParameters!.value1 = respiratoryParametersObject1;
      object.respiratoryParameters!.value2 = respiratoryParametersObject2;
      await _saveObject(object.respiratoryParameters);

      BloodGasAnalysisObject? bloodGasAnalysisObject1;
      BloodGasAnalysisObject? bloodGasAnalysisObject2;

      /// Blood gas analysis value 1.
      dynamic responseBloodGasAnalysisObject1 =
          await _saveObject(object.bloodGasAnalysisObject1);

      bloodGasAnalysisObject1 = await _updateObjectProperties(
        object.bloodGasAnalysisObject1,
        responseBloodGasAnalysisObject1,
      );

      /// Blood gas analysis value 2.
      dynamic responseBloodGasAnalysisObject2 =
          await _saveObject(object.bloodGasAnalysisObject2);

      bloodGasAnalysisObject2 = await _updateObjectProperties(
        object.bloodGasAnalysisObject2,
        responseBloodGasAnalysisObject2,
      );

      /// Blood gas analysis.
      object.bloodGasAnalysis!.value1 = bloodGasAnalysisObject1;
      object.bloodGasAnalysis!.value2 = bloodGasAnalysisObject2;

      await _saveObject(object.bloodGasAnalysis);

      /// Labor parameters.
      await _saveObject(object.laborParameters);

      /// Movement data.
      await _saveObject(object.movementData);

      dispatch();
    } catch (e) {
      Stream<List<CatalogOfItemsElement>>.error(e);
    }
  }

  Future<BackendACL> _prepareACL() async {
    BackendACL acl = BackendACL();
    String roleId = await BackendRole.userRoleName.id;
    acl.setWriteAccess(userId: roleId);
    acl.setReadAccess(userId: roleId);
    acl.setReadAccess(userId: EditPatientScreen.patientObjectId!);

    return acl;
  }

  Future<dynamic> _saveObject(dynamic object) async {
    return object.objectId == null
        ? await Backend.saveObject(object, acl: acl)
        : await Backend.saveObject(object);
  }

  Future<dynamic> _updateObjectProperties(
    dynamic object,
    dynamic response,
  ) async {
    return object!.copyWith(
      objectId: response['objectId'],
      createdAt: DateTime.tryParse(
            response['createdAt'] ?? '',
          ) ??
          object!.createdAt,
      updatedAt: DateTime.tryParse(
            response['updatedAt'] ?? '',
          ) ??
          object!.updatedAt,
    );
  }

  @override
  Future<List<AbstractDatabaseObject>> getObjects() async {
    return objectList;
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
    CatalogOfItemsElement? result;
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
    } catch (e) {
      return Future<CatalogOfItemsElement?>.error(e);
    }
    return result;
  }
}
