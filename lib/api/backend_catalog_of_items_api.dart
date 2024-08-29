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
      return Future<void>.error(e);
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
      dynamic elementICU = responseICUDiagnosis.results?.first;
      if (elementICU != null) {
        icuDiagnosisResults.add(
          ICUDiagnosis(
            mainDiagnosis: elementICU['ICU_Hd'],
            ancillaryDiagnosis: elementICU['Nebendiagnose'],
            intensiveCareUnitAcquiredWeakness: elementICU['ICU_AW'],
            postIntensiveCareSyndrome: elementICU['PICS'],
            patientObjectId: elementICU['Patient']['objectId'],
            doctorObjectId: elementICU['Doctor']['objectId'],
            objectId: elementICU['objectId'],
            createdAt: elementICU['createdAt'],
            updatedAt: elementICU['updatedAt'],
          ),
        );
      }

      ParseResponse responseVitalSigns = await Backend.getEntry(
        VitalSigns.databaseTable,
        'Patient',
        EditPatientScreen.patientObjectId!,
      );

      dynamic elementVitalSigns = responseVitalSigns.results?.first;
      if (elementVitalSigns != null) {
        ParseResponse responseVitalSignsObject1 =
            await ParseObject(VitalSignsObject.databaseTable).getObject(
          elementVitalSigns['value1']['objectId'],
        );

        ParseResponse responseVitalSignsObject2 =
            await ParseObject(VitalSignsObject.databaseTable).getObject(
          elementVitalSigns['value2']['objectId'],
        );

        vitalSignsResults.add(
          VitalSigns(
            valueObjectId1: elementVitalSigns['value1']['objectId'],
            valueObjectId2: elementVitalSigns['value2']['objectId'],
            objectId: elementVitalSigns['objectId'],
            patientObjectId: elementVitalSigns['Patient']['objectId'],
            doctorObjectId: elementVitalSigns['Doctor']['objectId'],
            createdAt: elementVitalSigns['createdAt'],
            updatedAt: elementVitalSigns['updatedAt'],
          ),
        );

        dynamic elementVitalSignsObject1 =
            responseVitalSignsObject1.results?.first;
        vitalSignsObjectResults.add(
          _createVitalSignsObject(elementVitalSignsObject1),
        );

        dynamic elementVitalSignsObject2 =
            responseVitalSignsObject2.results?.first;
        vitalSignsObjectResults.add(
          _createVitalSignsObject(elementVitalSignsObject2),
        );
      }

      ParseResponse responseRespiratoryParameters = await Backend.getEntry(
        RespiratoryParameters.databaseTable,
        'Patient',
        EditPatientScreen.patientObjectId!,
      );

      dynamic elementRespParam = responseRespiratoryParameters.results?.first;
      if (elementRespParam != null) {
        ParseResponse responseRespiratoryParametersObject1 =
            await ParseObject(RespiratoryParametersObject.databaseTable)
                .getObject(
          elementRespParam['value1']['objectId'],
        );
        ParseResponse responseRespiratoryParametersObject2 =
            await ParseObject(RespiratoryParametersObject.databaseTable)
                .getObject(
          elementRespParam['value2']['objectId'],
        );

        respiratoryParametersResults.add(
          RespiratoryParameters(
            valueObjectId1: elementRespParam['value1']['objectId'],
            valueObjectId2: elementRespParam['value2']['objectId'],
            patientObjectId: elementRespParam['Patient']['objectId'],
            doctorObjectId: elementRespParam['Doctor']['objectId'],
            objectId: elementRespParam['objectId'],
            createdAt: elementRespParam['createdAt'],
            updatedAt: elementRespParam['updatedAt'],
          ),
        );

        dynamic elementRespParamObject1 =
            responseRespiratoryParametersObject1.results?.first;
        respiratoryParametersObjectResults.add(
          _createRespiratoryParametersObject(elementRespParamObject1),
        );

        dynamic elementRespParamObject2 =
            responseRespiratoryParametersObject2.results?.first;
        respiratoryParametersObjectResults.add(
          _createRespiratoryParametersObject(elementRespParamObject2),
        );
      }

      ParseResponse responseBloodGasAnalysis = await Backend.getEntry(
        BloodGasAnalysis.databaseTable,
        'Patient',
        EditPatientScreen.patientObjectId!,
      );

      dynamic elementBloodGasAnalysis = responseBloodGasAnalysis.results?.first;
      if (elementBloodGasAnalysis != null) {
        ParseResponse responseBloodGasAnalysisObject1 =
            await ParseObject(BloodGasAnalysisObject.databaseTable).getObject(
          elementBloodGasAnalysis['value1']['objectId'],
        );

        ParseResponse responseBloodGasAnalysisObject2 =
            await ParseObject(BloodGasAnalysisObject.databaseTable).getObject(
          elementBloodGasAnalysis['value2']['objectId'],
        );

        bloodGasAnalysisResults.add(
          BloodGasAnalysis(
            valueObjectId1: elementBloodGasAnalysis['value1']['objectId'],
            valueObjectId2: elementBloodGasAnalysis['value2']['objectId'],
            patientObjectId: elementBloodGasAnalysis['Patient']['objectId'],
            doctorObjectId: elementBloodGasAnalysis['Doctor']['objectId'],
            objectId: elementBloodGasAnalysis['objectId'],
            createdAt: elementBloodGasAnalysis['createdAt'],
            updatedAt: elementBloodGasAnalysis['updatedAt'],
          ),
        );

        dynamic elementBloodGasAnalysisObject1 =
            responseBloodGasAnalysisObject1.results?.first;
        bloodGasAnalysisObjectResults.add(
          _createBloodGasAnalysisObject(elementBloodGasAnalysisObject1),
        );

        dynamic elementBloodGasAnalysisObject2 =
            responseBloodGasAnalysisObject2.results?.first;
        bloodGasAnalysisObjectResults.add(
          _createBloodGasAnalysisObject(elementBloodGasAnalysisObject2),
        );
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

      dynamic elementLaborParam = responseLaborParameters.results?.first;
      if (elementLaborParam != null) {
        laborParametersResults.add(
          LaborParameters(
            leukocyteCount: elementLaborParam['Leukozyten']?.toDouble(),
            lymphocyteCount: elementLaborParam['Lymphozyten_abs']?.toDouble(),
            lymphocytePercentage:
                elementLaborParam['Lymphozyten_proz']?.toDouble(),
            plateletCount: elementLaborParam['Thrombozyten']?.toDouble(),
            cReactiveProteinLevel: elementLaborParam['CRP']?.toDouble(),
            procalcitoninLevel: elementLaborParam['PCT']?.toDouble(),
            interleukin: elementLaborParam['IL_6']?.toDouble(),
            bloodUreaNitrogen: elementLaborParam['Urea']?.toDouble(),
            creatinine: elementLaborParam['Kreatinin']?.toDouble(),
            heartFailureMarker: elementLaborParam['BNP']?.toDouble(),
            heartFailureMarkerNTProBNP:
                elementLaborParam['NT_Pro_BNP']?.toDouble(),
            bilirubinTotal: elementLaborParam['Bilirubin']?.toDouble(),
            hemoglobin: elementLaborParam['Haemoglobin']?.toDouble(),
            hematocrit: elementLaborParam['Haematokrit']?.toDouble(),
            albumin: elementLaborParam['Albumin']?.toDouble(),
            gotASAT: elementLaborParam['GOT']?.toDouble(),
            gptALAT: elementLaborParam['GPT']?.toDouble(),
            troponin: elementLaborParam['Troponin']?.toDouble(),
            creatineKinase: elementLaborParam['CK']?.toDouble(),
            myocardialInfarctionMarkerCKMB:
                elementLaborParam['CK_MB']?.toDouble(),
            lactateDehydrogenaseLevel: elementLaborParam['LDH']?.toDouble(),
            amylaseLevel: elementLaborParam['Amylase']?.toDouble(),
            lipaseLevel: elementLaborParam['Lipase']?.toDouble(),
            dDimer: elementLaborParam['D_Dimere']?.toDouble(),
            internationalNormalizedRatio: elementLaborParam['INR']?.toDouble(),
            partialThromboplastinTime: elementLaborParam['pTT']?.toDouble(),
            patientObjectId: elementLaborParam['Patient']['objectId'],
            doctorObjectId: elementLaborParam['Doctor']['objectId'],
            objectId: elementLaborParam['objectId'],
            createdAt: elementLaborParam['createdAt'],
            updatedAt: elementLaborParam['updatedAt'],
          ),
        );
      }

      dynamic elementMovementData = responseMovementData.results?.first;
      if (elementMovementData != null) {
        movementDataResults.add(
          PatientData(
            bodyHeight: elementMovementData['BodyHeight']?.toDouble(),
            patientID: elementMovementData['ID'],
            caseNumber: elementMovementData['CaseNumber'],
            instKey: elementMovementData['inst_key'],
            bodyWeight: elementMovementData['BodyWeight']?.toDouble(),
            ezpICU: elementMovementData['EZP_ICU'],
            birthDate: elementMovementData['Birthdate'],
            gender: elementMovementData['Gender'],
            bmi: elementMovementData['BMI']?.toDouble(),
            idealBMI: elementMovementData['IdealBodyWeight']?.toDouble(),
            azpICU: (elementMovementData['AZP_ICU']),
            ventilationDays: elementMovementData['VentilationDays'],
            azpKH: elementMovementData['AZP_KH'],
            ezpKH: elementMovementData['EZP_KH'],
            icd10Codes: elementMovementData['ICD_10_Codes'],
            station: elementMovementData['Station'],
            lbgt70: elementMovementData['LBgt70'],
            icuLengthStay: elementMovementData['ICU_LengthStay'],
            khLengthStay: elementMovementData['KH_LengthStay'],
            wdaICU: elementMovementData['WdaICU2'],
            objectId: elementMovementData['objectId'],
            patientObjectId: elementMovementData['Patient']['objectId'],
            doctorObjectId: elementMovementData['Doctor']['objectId'],
            createdAt: elementMovementData['createdAt'],
            updatedAt: elementMovementData['updatedAt'],
          ),
        );
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

  static VitalSignsObject _createVitalSignsObject(dynamic element) {
    return VitalSignsObject(
      heartRate: element['HeartRate']?.toDouble(),
      systolicArterialPressure: element['SAP']?.toDouble(),
      meanArterialPressure: element['MAP']?.toDouble(),
      diastolicArterialPressure: element['DAP']?.toDouble(),
      centralVenousPressure: element['ZVD']?.toDouble(),
      objectId: element['objectId'],
      createdAt: element['createdAt'],
      updatedAt: element['updatedAt'],
    );
  }

  static RespiratoryParametersObject _createRespiratoryParametersObject(
    dynamic element,
  ) {
    return RespiratoryParametersObject(
      tidalVolume: element['VT']?.toDouble(),
      respiratoryRate: element['AF']?.toDouble(),
      oxygenSaturation: element['SpO2']?.toDouble(),
      objectId: element['objectId'],
      createdAt: element['createdAt'],
      updatedAt: element['updatedAt'],
    );
  }

  static BloodGasAnalysisObject _createBloodGasAnalysisObject(dynamic element) {
    return BloodGasAnalysisObject(
      arterialOxygenSaturation: element['SaO2']?.toDouble(),
      centralVenousOxygenSaturation: element['SzVO2']?.toDouble(),
      partialPressureOfOxygen: element['PaO2_woTemp']?.toDouble(),
      partialPressureOfCarbonDioxide: element['PaCO2_woTemp']?.toDouble(),
      arterialBaseExcess: element['BE']?.toDouble(),
      arterialPH: element['pH']?.toDouble(),
      arterialSerumBicarbonateConcentration: element['Bicarbonat']?.toDouble(),
      arterialLactate: element['Laktat']?.toDouble(),
      bloodGlucoseLevel: element['BloodSugar']?.toDouble(),
      objectId: element['objectId'],
      createdAt: element['createdAt'],
      updatedAt: element['updatedAt'],
    );
  }
}
