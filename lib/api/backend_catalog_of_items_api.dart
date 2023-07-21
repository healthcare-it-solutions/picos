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
import 'package:picos/models/patient_data.dart';
import 'package:collection/collection.dart';
import 'package:picos/models/respiratory_parameters_object.dart';
import 'package:picos/models/vital_signs_object.dart';
import 'package:picos/util/backend.dart';

import 'package:picos/models/blood_gas_analysis.dart';
import 'package:picos/models/respiratory_parameters.dart';
import 'package:picos/models/vital_signs.dart';

import '../models/patient.dart';

/// API for calling the corresponding tables for the Catalog of Items.
class BackendCatalogOfItemsApi extends BackendObjectsApi {
  @override
  Future<void> saveObject(AbstractDatabaseObject object) async {
    VitalSignsObject? vitalSignsObject1;
    VitalSignsObject? vitalSignsObject2;
    try {
      /// ICUDiagnosis
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

      if (object.vitalSignsObject1.objectId == null) {
        /// VitalSigns value 1
        dynamic responseVitalSignsObject1 = await Backend.saveObject(
          object.vitalSignsObject1,
        );
        vitalSignsObject1 = object.vitalSignsObject1.copyWith(
          objectId: responseVitalSignsObject1['objectId'],
          createdAt: DateTime.tryParse(
                responseVitalSignsObject1['createdAt'] ?? '',
              ) ??
              object.vitalSignsObject1.createdAt,
          updatedAt: DateTime.tryParse(
                responseVitalSignsObject1['updatedAt'] ?? '',
              ) ??
              object.vitalSignsObject1.updatedAt,
        );
      }
      if (object.vitalSignsObject2.objectId == null) {
        /// VitalSigns value 2
        dynamic responseVitalSignsObject2 = await Backend.saveObject(
          object.vitalSignsObject2,
        );

        vitalSignsObject2 = object.vitalSignsObject2.copyWith(
          objectId: responseVitalSignsObject2['objectId'],
          createdAt: DateTime.tryParse(
                responseVitalSignsObject2['createdAt'] ?? '',
              ) ??
              object.vitalSignsObject2.createdAt,
          updatedAt: DateTime.tryParse(
                responseVitalSignsObject2['updatedAt'] ?? '',
              ) ??
              object.vitalSignsObject2.updatedAt,
        );
      }

      /// VitalSigns
      object.vitalSigns.value1 = vitalSignsObject1;
      object.vitalSigns.value2 = vitalSignsObject2;
      dynamic responseVitalSigns = await Backend.saveObject(
        object.vitalSigns,
      );
      VitalSigns vitalSigns = object.vitalSigns.copyWith(
        objectId: responseVitalSigns['objectId'],
        createdAt: DateTime.tryParse(responseVitalSigns['createdAt'] ?? '') ??
            object.vitalSigns.createdAt,
        updatedAt: DateTime.tryParse(responseVitalSigns['updatedAt'] ?? '') ??
            object.vitalSigns.updatedAt,
      );

      /// Respiratory parameters value 1
      dynamic responseRespiratoryParametersObject1 = await Backend.saveObject(
        object.respiratoryParametersObject1,
      );

      RespiratoryParametersObject respiratoryParametersObject1 =
          object.respiratoryParametersObject1.copyWith(
        objectId: responseRespiratoryParametersObject1['objectId'],
        createdAt: DateTime.tryParse(
              responseRespiratoryParametersObject1['createdAt'] ?? '',
            ) ??
            object.respiratoryParametersObject1.createdAt,
        updatedAt: DateTime.tryParse(
              responseRespiratoryParametersObject1['updatedAt'] ?? '',
            ) ??
            object.respiratoryParametersObject1.updatedAt,
      );

      /// Respiratory parameters value 2
      dynamic responseRespiratoryParametersObject2 = await Backend.saveObject(
        object.respiratoryParametersObject2,
      );

      RespiratoryParametersObject respiratoryParametersObject2 =
          object.respiratoryParametersObject2.copyWith(
        objectId: responseRespiratoryParametersObject2['objectId'],
        createdAt: DateTime.tryParse(
              responseRespiratoryParametersObject2['createdAt'] ?? '',
            ) ??
            object.respiratoryParametersObject2.createdAt,
        updatedAt: DateTime.tryParse(
              responseRespiratoryParametersObject2['updatedAt'] ?? '',
            ) ??
            object.respiratoryParametersObject2.updatedAt,
      );

      /// Respiratory parameters
      object.respiratoryParameters.value1 = respiratoryParametersObject1;
      object.respiratoryParameters.value2 = respiratoryParametersObject2;
      dynamic responseRespiratoryParameters = await Backend.saveObject(
        object.respiratoryParameters,
      );
      RespiratoryParameters respiratoryParameters =
          object.respiratoryParameters.copyWith(
        objectId: responseRespiratoryParameters['objectId'],
        createdAt: DateTime.tryParse(
              responseRespiratoryParameters['createdAt'] ?? '',
            ) ??
            object.respiratoryParameters.createdAt,
        updatedAt: DateTime.tryParse(
              responseRespiratoryParameters['updatedAt'] ?? '',
            ) ??
            object.respiratoryParameters.updatedAt,
      );

      /// Blood gas analysis value 1
      dynamic responseBloodGasAnalysisObject1 = await Backend.saveObject(
        object.bloodGasAnalysisObject1,
      );

      BloodGasAnalysisObject bloodGasAnalysisObject1 =
          object.bloodGasAnalysisObject1.copyWith(
        objectId: responseBloodGasAnalysisObject1['objectId'],
        createdAt: DateTime.tryParse(
              responseBloodGasAnalysisObject1['createdAt'] ?? '',
            ) ??
            object.bloodGasAnalysisObject1.createdAt,
        updatedAt: DateTime.tryParse(
              responseBloodGasAnalysisObject1['updatedAt'] ?? '',
            ) ??
            object.bloodGasAnalysisObject1.updatedAt,
      );

      /// Blood gas analysis value 2
      dynamic responseBloodGasAnalysisObject2 = await Backend.saveObject(
        object.bloodGasAnalysisObject2,
      );

      BloodGasAnalysisObject bloodGasAnalysisObject2 =
          object.bloodGasAnalysisObject2.copyWith(
        objectId: responseBloodGasAnalysisObject2['objectId'],
        createdAt: DateTime.tryParse(
              responseBloodGasAnalysisObject2['createdAt'] ?? '',
            ) ??
            object.bloodGasAnalysisObject2.createdAt,
        updatedAt: DateTime.tryParse(
              responseBloodGasAnalysisObject2['updatedAt'] ?? '',
            ) ??
            object.bloodGasAnalysisObject2.updatedAt,
      );

      /// Blood gas analysis
      object.bloodGasAnalysis.value1 = bloodGasAnalysisObject1;
      object.bloodGasAnalysis.value2 = bloodGasAnalysisObject2;
      dynamic responseBloodGasAnalysis = await Backend.saveObject(
        object.bloodGasAnalysis,
      );

      BloodGasAnalysis bloodGasAnalysis = object.bloodGasAnalysis.copyWith(
        objectId: responseBloodGasAnalysis['objectId'],
        createdAt: DateTime.tryParse(
              responseBloodGasAnalysis['createdAt'] ?? '',
            ) ??
            object.bloodGasAnalysis.createdAt,
        updatedAt: DateTime.tryParse(
              responseBloodGasAnalysis['updatedAt'] ?? '',
            ) ??
            object.bloodGasAnalysis.updatedAt,
      );

      /// Labor parameters
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

      /// Medicaments
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

      /// Movement data
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
        vitalSignsObject1: vitalSignsObject1,
        vitalSignsObject2: vitalSignsObject2,
        vitalSigns: vitalSigns,
        respiratoryParametersObject1: respiratoryParametersObject1,
        respiratoryParametersObject2: respiratoryParametersObject2,
        respiratoryParameters: respiratoryParameters,
        bloodGasAnalysisObject1: bloodGasAnalysisObject1,
        bloodGasAnalysisObject2: bloodGasAnalysisObject2,
        bloodGasAnalysis: bloodGasAnalysis,
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
      Stream<List<CatalogOfItemsElement>>.error(e);
    }
  }

  @override
  Future<Stream<List<AbstractDatabaseObject>>> getObjects() async {
    try {
      List<dynamic> responsePatient =
          await Backend.getAll(Patient.databaseTable);
      List<dynamic> responseICUDiagnosis =
          await Backend.getAll(ICUDiagnosis.databaseTable);
      List<dynamic> responseVitalSigns =
          await Backend.getAll(VitalSigns.databaseTable);
      List<dynamic> responseVitalSignsObject =
          await Backend.getAll(VitalSignsObject.databaseTable);
      List<dynamic> responseRespiratoryParameters =
          await Backend.getAll(RespiratoryParameters.databaseTable);
      List<dynamic> responseRespiratoryParametersObject =
          await Backend.getAll(RespiratoryParametersObject.databaseTable);
      List<dynamic> responseBloodGasAnalysis =
          await Backend.getAll(BloodGasAnalysis.databaseTable);
      List<dynamic> responseBloodGasAnalysisObject =
          await Backend.getAll(BloodGasAnalysisObject.databaseTable);
      List<dynamic> responseLaborParameters =
          await Backend.getAll(LaborParameters.databaseTable);
      List<dynamic> responseMedicaments =
          await Backend.getAll(Medicaments.databaseTable);
      List<dynamic> responseMovementData =
          await Backend.getAll(PatientData.databaseTable);

      List<Patient> patientResults = <Patient>[];
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
      List<Medicaments> medicamentsResults = <Medicaments>[];
      List<PatientData> movementDataResults = <PatientData>[];

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

      for (dynamic element in responseICUDiagnosis) {
        icuDiagnosisResults.add(
          ICUDiagnosis(
            mainDiagnosis: element['ICU_Hd'] ?? '',
            progressDiagnosis: element['ICU_Vd'] ?? '',
            coMorbidity: element['CO_Morb'] ?? '',
            intensiveCareUnitAcquiredWeakness: element['ICU_AW'] ?? '',
            postIntensiveCareSyndrome: element['PICS'] ?? '',
            patientObjectId: element['Patient']['objectId'],
            doctorObjectId: element['Doctor']['objectId'],
            objectId: element['objectId'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
          ),
        );
      }

      for (dynamic element in responseVitalSigns) {
        vitalSignsResults.add(
          VitalSigns(
            valueObjectId1: element['value1']['objectId'],
            valueObjectId2: element['value2']['objectId'],
            objectId: element['objectId'],
            patientObjectId: element['Patient']['objectId'],
            doctorObjectId: element['Doctor']['objectId'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
          ),
        );
      }

      for (dynamic element in responseVitalSignsObject) {
        vitalSignsObjectResults.add(
          VitalSignsObject(
            objectId: element['objectId'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
          ),
        );
      }

      for (dynamic element in responseRespiratoryParameters) {
        respiratoryParametersResults.add(
          RespiratoryParameters(
            value1: element['RespiratoryParametersObject'] != null
                ? element['RespiratoryParametersObject']['objectId']
                : null,
            value2: element['RespiratoryParametersObject'] != null
                ? element['RespiratoryParametersObject']['objectId']
                : null,
            patientObjectId: element['Patient']['objectId'],
            doctorObjectId: element['Doctor']['objectId'],
            objectId: element['objectId'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
          ),
        );
      }

      for (dynamic element in responseRespiratoryParametersObject) {
        respiratoryParametersObjectResults.add(
          RespiratoryParametersObject(
            objectId: element['objectId'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
          ),
        );
      }

      for (dynamic element in responseBloodGasAnalysis) {
        bloodGasAnalysisResults.add(
          BloodGasAnalysis(
            value1: element['BloodGasAnalysisObject'] != null
                ? element['BloodGasAnalysisObject']['objectId']
                : null,
            value2: element['BloodGasAnalysisObject'] != null
                ? element['BloodGasAnalysisObject']['objectId']
                : null,
            patientObjectId: element['Patient']['objectId'],
            doctorObjectId: element['Doctor']['objectId'],
            objectId: element['objectId'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
          ),
        );
      }

      for (dynamic element in responseBloodGasAnalysisObject) {
        bloodGasAnalysisObjectResults.add(
          BloodGasAnalysisObject(
            objectId: element['objectId'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
          ),
        );
      }

      for (dynamic element in responseLaborParameters) {
        laborParametersResults.add(
          LaborParameters(
            leukocyteCount: element['Leukozyten'] != null
                ? element['Leukozyten']['estimateNumber'].toDouble()
                : null,
            lymphocyteCount: element['lymphozyten_abs'] != null
                ? element['lymphozyten_abs']['estimateNumber'].toDouble()
                : null,
            lymphocytePercentage: element['lymphozyten_proz'] != null
                ? element['lymphozyten_proz']['estimateNumber'].toDouble()
                : null,
            plateletCount: element['Thrombozyten'] != null
                ? element['Thrombozyten']['estimateNumber'].toDouble()
                : null,
            cReactiveProteinLevel: element['CRP'] != null
                ? element['CRP']['estimateNumber'].toDouble()
                : null,
            procalcitoninLevel: element['PCT'] != null
                ? element['PCT']['estimateNumber'].toDouble()
                : null,
            interleukin: element['IL_6'] != null
                ? element['IL_6']['estimateNumber'].toDouble()
                : null,
            bloodUreaNitrogen: element['Urea'] != null
                ? element['Urea']['estimateNumber'].toDouble()
                : null,
            creatinine: element['Kreatinin'] != null
                ? element['Kreatinin']['estimateNumber'].toDouble()
                : null,
            heartFailureMarker: element['BNP'] != null
                ? element['BNP']['estimateNumber'].toDouble()
                : null,
            heartFailureMarkerNTProBNP: element['NT_Pro_BNP'] != null
                ? element['NT_Pro_BNP']['estimateNumber'].toDouble()
                : null,
            bilirubinTotal: element['Bilirubin'] != null
                ? element['Bilirubin']['estimateNumber'].toDouble()
                : null,
            hemoglobin: element['Haemoglobin'] != null
                ? element['Haemoglobin']['estimateNumber'].toDouble()
                : null,
            hematocrit: element['Haematokrit'] != null
                ? element['Haematokrit']['estimateNumber'].toDouble()
                : null,
            albumin: element['Albumin'] != null
                ? element['Albumin']['estimateNumber'].toDouble()
                : null,
            gotASAT: element['GOT'] != null
                ? element['GOT']['estimateNumber'].toDouble()
                : null,
            gptALAT: element['GPT'] != null
                ? element['GPT']['estimateNumber'].toDouble()
                : null,
            troponin: element['Troponin'] != null
                ? element['Troponin']['estimateNumber'].toDouble()
                : null,
            creatineKinase: element['CK'] != null
                ? element['CK']['estimateNumber'].toDouble()
                : null,
            myocardialInfarctionMarkerCKMB: element['CK_MB'] != null
                ? element['CK_MB']['estimateNumber'].toDouble()
                : null,
            lactateDehydrogenaseLevel: element['LDH'] != null
                ? element['LDH']['estimateNumber'].toDouble()
                : null,
            amylaseLevel: element['Amylase'] != null
                ? element['Amylase']['estimateNumber'].toDouble()
                : null,
            lipaseLevel: element['Lipase'] != null
                ? element['Lipase']['estimateNumber'].toDouble()
                : null,
            dDimer: element['D_Dimere'] != null
                ? element['D_Dimere']['estimateNumber'].toDouble()
                : null,
            internationalNormalizedRatio: element['INR'] != null
                ? element['INR']['estimateNumber'].toDouble()
                : null,
            partialThromboplastinTime: element['pTT'] != null
                ? element['pTT']['estimateNumber'].toDouble()
                : null,
            patientObjectId: element['Patient']['objectId'],
            doctorObjectId: element['Doctor']['objectId'],
            objectId: element['objectId'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
          ),
        );
      }

      for (dynamic element in responseMedicaments) {
        medicamentsResults.add(
          Medicaments(
            plateletAggregation: element['Thrombozytenaggregation'] ?? '',
            noak: element['NOAK'] ?? '',
            thrombosisProphylaxis: element['Thromboseprophylaxe'],
            antihypertensives: element['Antihypertensiva'] ?? '',
            antiarrhythmics: element['Antiarrythmika'] ?? '',
            antidiabetics: element['Antidiabetika'] ?? '',
            antiInfectives: element['Antiinfektiva'],
            steroids: element['Steroide'] ?? '',
            inhalatives: element['Inhalativa'] ?? '',
            analgesics: element['Analgetika'] ?? '',
            objectId: element['objectId'] ?? '',
            patientObjectId: element['Patient']['objectId'],
            doctorObjectId: element['Doctor']['objectId'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
          ),
        );
      }

      for (dynamic element in responseMovementData) {
        movementDataResults.add(
          PatientData(
            bodyHeight: element['BodyHeight']['estimateNumber'].toDouble(),
            patientID: element['ID'],
            caseNumber: element['CaseNumber'],
            instKey: element['inst_key'],
            bodyWeight: element['BodyWeight'] != null
                ? element['BodyWeight']['estimateNumber'].toDouble()
                : null,
            ezpICU: element['EZP_ICU'] != null
                ? DateTime.parse(element['EZP_ICU'])
                : null,
            age: element['Age'],
            gender: element['Gender'] ?? '',
            bmi: element['BMI'] != null
                ? element['BMI']['estimateNumber'].toDouble()
                : null,
            idealBMI: element['IdealBMI'] != null
                ? element['IdealBMI']['estimateNumber'].toDouble()
                : null,
            dischargeReason: element['DischargeReason'] ?? '',
            azpICU: element['AZP_ICU'] != null
                ? DateTime.parse(element['AZP_ICU'])
                : null,
            ventilationDays: element['VentilationDays'],
            azpKH: element['AZP_KH'] != null
                ? DateTime.parse(element['AZP_KH'])
                : null,
            ezpKH: element['EZP_ICU'] != null
                ? DateTime.parse(element['EZP_ICU'])
                : null,
            icd10Codes: element['ICD_10_Codes'] != null
                ? <String>[element['ICD_10_Codes']]
                : <String>[],
            station: element['Station'] ?? '',
            lbgt70: element['LBgt70'],
            icuMortality: element['ICU_Mortality'] != null
                ? element['ICU_Mortality']['estimateNumber'].toDouble()
                : null,
            khMortality: element['KH_Mortality'] != null
                ? element['KH_Mortality']['estimateNumber'].toDouble()
                : null,
            icuLengthStay: element['ICU_LengthStay'],
            khLengthStay: element['KH_LengthStay'],
            wdaKH: element['WdaKH'] != null
                ? element['WdaKH']['estimateNumber'].toDouble()
                : null,
            weznDisease: element['WEznDisease'] != null
                ? element['WEznDisease']['estimateNumber'].toDouble()
                : null,
            objectId: element['objectId'],
            patientObjectId: element['Patient']['objectId'],
            doctorObjectId: element['Doctor']['objectId'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
          ),
        );
      }

      for (Patient patientObject in patientResults) {
        String? patientObjectId = patientObject.objectId;

        ICUDiagnosis? matchingICUDiagnosis =
            icuDiagnosisResults.firstWhereOrNull(
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
        Medicaments? matchingMedicaments = medicamentsResults.firstWhereOrNull(
          (Medicaments medicamentsObject) =>
              medicamentsObject.patientObjectId == patientObjectId,
        );

        PatientData? matchingMovementData =
            movementDataResults.firstWhereOrNull(
          (PatientData movementDataObject) =>
              movementDataObject.patientObjectId == patientObjectId,
        );

        if (matchingICUDiagnosis != null &&
            matchingVitalSigns != null &&
            matchingRespiratoryParameters != null &&
            matchingBloodGasAnalysis != null &&
            matchingLaborParameters != null &&
            matchingMedicaments != null &&
            matchingMovementData != null) {
          objectList.add(
            CatalogOfItemsElement(
              icuDiagnosis: matchingICUDiagnosis,
              vitalSigns: matchingVitalSigns,
              vitalSignsObject1: matchingVitalSigns.value1!,
              vitalSignsObject2: matchingVitalSigns.value2!,
              respiratoryParameters: matchingRespiratoryParameters,
              respiratoryParametersObject1:
                  matchingRespiratoryParameters.value1!,
              respiratoryParametersObject2:
                  matchingRespiratoryParameters.value2!,
              bloodGasAnalysis: matchingBloodGasAnalysis,
              bloodGasAnalysisObject1: matchingBloodGasAnalysis.value1!,
              bloodGasAnalysisObject2: matchingBloodGasAnalysis.value2!,
              laborParameters: matchingLaborParameters,
              medicaments: matchingMedicaments,
              movementData: matchingMovementData,
              objectId: patientObject.objectId,
            ),
          );
        }
      }

      return getObjectsStream();
    } catch (e) {
      return Stream<List<CatalogOfItemsElement>>.error(e);
    }
  }
}
