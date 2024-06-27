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

import 'package:flutter/material.dart';
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/pages/blood_gas_analysis_page.dart';
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/pages/icu_diagnosis_page.dart';
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/pages/laboratory_values_page.dart';
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/pages/movement_data_page.dart';
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/pages/respiration_parameters_page.dart';
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/pages/vital_data_page.dart';
import '../../../models/blood_gas_analysis_object.dart';
import '../../../models/catalog_of_items_element.dart';
import '../../../models/icu_diagnosis.dart';
import '../../../models/labor_parameters.dart';
import '../../../models/patient_data.dart';
import '../../../models/respiratory_parameters_object.dart';
import '../../../models/vital_signs_object.dart';
import '../../../widgets/picos_page_view_item.dart';

/// Manages the state of the Catalog of items pages.
class CatalogOfItemsPageStorage {
  /// Creates CatalogOfItemsPageStorage.
  CatalogOfItemsPageStorage({
    required BuildContext context,
    CatalogOfItemsElement? catalogOfItemsElement,
  }) {
    ICUDiagnosis? icuDiagnosis;
    VitalSignsObject? vitalSignsObject1;
    VitalSignsObject? vitalSignsObject2;
    RespiratoryParametersObject? respiratoryParametersObject1;
    RespiratoryParametersObject? respiratoryParametersObject2;
    BloodGasAnalysisObject? bloodGasAnalysisObject1;
    BloodGasAnalysisObject? bloodGasAnalysisObject2;
    LaborParameters? laborParameters;
    PatientData? movementData;
    if (catalogOfItemsElement != null) {
      icuDiagnosis = catalogOfItemsElement.icuDiagnosis;
      vitalSignsObject1 = catalogOfItemsElement.vitalSignsObject1;
      vitalSignsObject2 = catalogOfItemsElement.vitalSignsObject2;
      respiratoryParametersObject1 =
          catalogOfItemsElement.respiratoryParametersObject1;
      respiratoryParametersObject2 =
          catalogOfItemsElement.respiratoryParametersObject2;
      bloodGasAnalysisObject1 = catalogOfItemsElement.bloodGasAnalysisObject1;
      bloodGasAnalysisObject2 = catalogOfItemsElement.bloodGasAnalysisObject2;
      laborParameters = catalogOfItemsElement.laborParameters;
      movementData = catalogOfItemsElement.movementData;
    }

    pages = <PicosPageViewItem>[
      PicosPageViewItem(
        child: IcuDiagnosisPage(
          initialIcuaw: icuDiagnosis?.intensiveCareUnitAcquiredWeakness,
          initialMainDiagnosis: icuDiagnosis?.mainDiagnosis,
          initialAncillaryDiagnosis: icuDiagnosis?.ancillaryDiagnosis,
          initialPics: icuDiagnosis?.postIntensiveCareSyndrome,
          mainDiagnosisCallback: (String? value) {
            mainDiagnosis = value;
          },
          ancillaryDiagnosisCallback: (List<dynamic>? value) {
            ancillaryDiagnosis = value;
          },
          icuawCallback: (bool? value) {
            intensiveCareUnitAcquiredWeakness = value;
          },
          picsCallback: (bool? value) {
            postIntensiveCareSyndrome = value;
          },
        ),
      ),
      PicosPageViewItem(
        child: VitalDataPage(
          initialCentralVenousPressure1:
              vitalSignsObject1?.centralVenousPressure,
          initialCentralVenousPressure2:
              vitalSignsObject2?.centralVenousPressure,
          initialDap1: vitalSignsObject1?.diastolicArterialPressure,
          initialDap2: vitalSignsObject2?.diastolicArterialPressure,
          initialHeartRate1: vitalSignsObject1?.heartRate,
          initialHeartRate2: vitalSignsObject2?.heartRate,
          initialMap1: vitalSignsObject1?.meanArterialPressure,
          initialMap2: vitalSignsObject2?.meanArterialPressure,
          initialSap1: vitalSignsObject1?.systolicArterialPressure,
          initialSap2: vitalSignsObject2?.systolicArterialPressure,
          centralVenousPressureCallback1: (double? value) {
            centralVenousPressure1 = value;
          },
          dapCallback1: (double? value) {
            diastolicArterialPressure1 = value;
          },
          mapCallback1: (double? value) {
            meanArterialPressure1 = value;
          },
          sapCallback1: (double? value) {
            systolicArterialPressure1 = value;
          },
          heartRateCallback1: (double? value) {
            heartRate1 = value;
          },
          centralVenousPressureCallback2: (double? value) {
            centralVenousPressure2 = value;
          },
          dapCallback2: (double? value) {
            diastolicArterialPressure2 = value;
          },
          mapCallback2: (double? value) {
            meanArterialPressure2 = value;
          },
          sapCallback2: (double? value) {
            systolicArterialPressure2 = value;
          },
          heartRateCallback2: (double? value) {
            heartRate2 = value;
          },
        ),
      ),
      PicosPageViewItem(
        child: RespirationParametersPage(
          initialTidalVolume:
              tidalVolume ?? respiratoryParametersObject1?.tidalVolume,
          initialRespiratoryRate1:
              respiratoryRate1 ?? respiratoryParametersObject1?.respiratoryRate,
          initialRespiratoryRate2:
              respiratoryRate2 ?? respiratoryParametersObject2?.respiratoryRate,
          initialOxygenSaturation1: oxygenSaturation1 ??
              respiratoryParametersObject1?.oxygenSaturation,
          initialOxygenSaturation2: oxygenSaturation2 ??
              respiratoryParametersObject2?.oxygenSaturation,
          tidalVolumenCallback: (double? value) {
            tidalVolume = value;
          },
          respiratoryRate1Callback: (double? value) {
            respiratoryRate1 = value;
          },
          respiratoryRate2Callback: (double? value) {
            respiratoryRate2 = value;
          },
          oxygenSaturation1Callback: (double? value) {
            oxygenSaturation1 = value;
          },
          oxygenSaturation2Callback: (double? value) {
            oxygenSaturation2 = value;
          },
        ),
      ),
      PicosPageViewItem(
        child: BloodGasAnalysisPage(
          initialArterialOxygenSaturation1:
              bloodGasAnalysisObject1?.arterialOxygenSaturation,
          initialArterialOxygenSaturation2:
              bloodGasAnalysisObject2?.arterialOxygenSaturation,
          initialCentralVenousOxygenSaturation1:
              bloodGasAnalysisObject1?.centralVenousOxygenSaturation,
          initialCentralVenousOxygenSaturation2:
              bloodGasAnalysisObject2?.centralVenousOxygenSaturation,
          initialPartialPressureOfOxygen1:
              bloodGasAnalysisObject1?.partialPressureOfOxygen,
          initialPartialPressureOfOxygen2:
              bloodGasAnalysisObject2?.partialPressureOfOxygen,
          initialPartialPressureOfCarbonDioxide1:
              bloodGasAnalysisObject1?.partialPressureOfCarbonDioxide,
          initialPartialPressureOfCarbonDioxide2:
              bloodGasAnalysisObject2?.partialPressureOfCarbonDioxide,
          initialarterialBaseExcess1:
              bloodGasAnalysisObject1?.arterialBaseExcess,
          initialarterialBaseExcess2:
              bloodGasAnalysisObject2?.arterialBaseExcess,
          initialarterialPH1: bloodGasAnalysisObject1?.arterialPH,
          initialarterialPH2: bloodGasAnalysisObject2?.arterialPH,
          initialArterialSerumBicarbonateConcentration1:
              bloodGasAnalysisObject1?.arterialSerumBicarbonateConcentration,
          initialArterialSerumBicarbonateConcentration2:
              bloodGasAnalysisObject2?.arterialSerumBicarbonateConcentration,
          initialArterialLactate1: bloodGasAnalysisObject1?.arterialLactate,
          initialArterialLactate2: bloodGasAnalysisObject2?.arterialLactate,
          initialBloodGlucoseLevel1: bloodGasAnalysisObject1?.bloodGlucoseLevel,
          initialBloodGlucoseLevel2: bloodGasAnalysisObject2?.bloodGlucoseLevel,
          arterialOxygenSaturationCallback1: (double? value) {
            arterialOxygenSaturation1 = value;
          },
          arterialOxygenSaturationCallback2: (double? value) {
            arterialOxygenSaturation2 = value;
          },
          centralVenousOxygenSaturationCallback1: (double? value) {
            centralVenousOxygenSaturation1 = value;
          },
          centralVenousOxygenSaturationCallback2: (double? value) {
            centralVenousOxygenSaturation2 = value;
          },
          partialPressureOfOxygenCallback1: (double? value) {
            partialPressureOfOxygen1 = value;
          },
          partialPressureOfOxygenCallback2: (double? value) {
            partialPressureOfOxygen2 = value;
          },
          partialPressureOfCarbonDioxideCallback1: (double? value) {
            partialPressureOfCarbonDioxide1 = value;
          },
          partialPressureOfCarbonDioxideCallback2: (double? value) {
            partialPressureOfCarbonDioxide2 = value;
          },
          arterialBaseExcessCallback1: (double? value) {
            arterialBaseExcess1 = value;
          },
          arterialBaseExcessCallback2: (double? value) {
            arterialBaseExcess2 = value;
          },
          arterialPHCallback1: (double? value) {
            arterialPH1 = value;
          },
          arterialPHCallback2: (double? value) {
            arterialPH2 = value;
          },
          arterialSerumBicarbonateConcentrationCallback1: (double? value) {
            arterialSerumBicarbonateConcentration1 = value;
          },
          arterialSerumBicarbonateConcentrationCallback2: (double? value) {
            arterialSerumBicarbonateConcentration2 = value;
          },
          arterialLactateCallback1: (double? value) {
            arterialLactate1 = value;
          },
          arterialLactateCallback2: (double? value) {
            arterialLactate2 = value;
          },
          bloodGlucoseLevelCallback1: (double? value) {
            bloodGlucoseLevel1 = value;
          },
          bloodGlucoseLevelCallback2: (double? value) {
            bloodGlucoseLevel2 = value;
          },
        ),
      ),
      PicosPageViewItem(
        child: LaboratoryValuesPage(
          initialLeukocyteCount: laborParameters?.leukocyteCount,
          initialLymphocyteCount: laborParameters?.lymphocyteCount,
          initialLymphocytePercentage: laborParameters?.lymphocytePercentage,
          initialPlateletCount: laborParameters?.plateletCount,
          initialcReactiveProteinLevel: laborParameters?.cReactiveProteinLevel,
          initialProcalcitoninLevel: laborParameters?.procalcitoninLevel,
          initialInterleukin: laborParameters?.interleukin,
          initialBloodUreaNitrogen: laborParameters?.bloodUreaNitrogen,
          initialCreatinine: laborParameters?.creatinine,
          initialHeartFailureMarker: laborParameters?.heartFailureMarker,
          initialHeartFailureMarkerNTProBNP:
              laborParameters?.heartFailureMarkerNTProBNP,
          initialBilirubinTotal: laborParameters?.bilirubinTotal,
          initialHemoglobin: laborParameters?.hemoglobin,
          initialHematocrit: laborParameters?.hematocrit,
          initialAlbumin: laborParameters?.albumin,
          initialGOTASAT: laborParameters?.gotASAT,
          initialGPTALAT: laborParameters?.gptALAT,
          initialTroponin: laborParameters?.troponin,
          initialCreatineKinase: laborParameters?.creatineKinase,
          initialMyocardialInfarctionMarkerCKMB:
              laborParameters?.myocardialInfarctionMarkerCKMB,
          initialLactateDehydrogenaseLevel:
              laborParameters?.lactateDehydrogenaseLevel,
          initialAmylaseLevel: laborParameters?.amylaseLevel,
          initialLipaseLevel: laborParameters?.lipaseLevel,
          initialDDimer: laborParameters?.dDimer,
          initialInternationalNormalizedRatio:
              laborParameters?.internationalNormalizedRatio,
          initialPartialThromboplastinTime:
              laborParameters?.partialThromboplastinTime,
          leukocyteCountCallback: (double? value) {
            leukocyteCount = value;
          },
          lymphocyteCountCallback: (double? value) {
            lymphocyteCount = value;
          },
          lymphocytePercentageCallback: (double? value) {
            lymphocytePercentage = value;
          },
          plateletCountCallback: (double? value) {
            plateletCount = value;
          },
          cReactiveProteinLevelCallback: (double? value) {
            cReactiveProteinLevel = value;
          },
          procalcitoninLevelCallback: (double? value) {
            procalcitoninLevel = value;
          },
          interleukinCallback: (double? value) {
            interleukin = value;
          },
          bloodUreaNitrogenCallback: (double? value) {
            bloodUreaNitrogen = value;
          },
          creatinineCallback: (double? value) {
            creatinine = value;
          },
          heartFailureMarkerCallback: (double? value) {
            heartFailureMarker = value;
          },
          heartFailureMarkerNTProBNPCallback: (double? value) {
            heartFailureMarkerNTProBNP = value;
          },
          bilirubinTotalCallback: (double? value) {
            bilirubinTotal = value;
          },
          hemoglobinCallback: (double? value) {
            hemoglobin = value;
          },
          hematocritCallback: (double? value) {
            hematocrit = value;
          },
          albuminCallback: (double? value) {
            albumin = value;
          },
          gotASATCallback: (double? value) {
            gotASAT = value;
          },
          gptALATCallback: (double? value) {
            gptALAT = value;
          },
          troponinCallback: (double? value) {
            troponin = value;
          },
          creatineKinaseCallback: (double? value) {
            creatineKinase = value;
          },
          myocardialInfarctionMarkerCKMBCallback: (double? value) {
            myocardialInfarctionMarkerCKMB = value;
          },
          lactateDehydrogenaseLevelCallback: (double? value) {
            lactateDehydrogenaseLevel = value;
          },
          amylaseLevelCallback: (double? value) {
            amylaseLevel = value;
          },
          lipaseLevelCallback: (double? value) {
            lipaseLevel = value;
          },
          dDimerCallback: (double? value) {
            dDimer = value;
          },
          internationalNormalizedRatioCallback: (double? value) {
            internationalNormalizedRatio = value;
          },
          partialThromboplastinTimeCallback: (double? value) {
            partialThromboplastinTime = value;
          },
        ),
      ),
      PicosPageViewItem(
        child: MovementDataPage(
          initialBirthDate: movementData?.birthDate,
          initialGender: movementData?.gender,
          initialBodyWeight: movementData?.bodyWeight,
          initialBodyHeight: movementData?.bodyHeight,
          initialBodyMassIndex: movementData?.bmi,
          initialIdealBodyWeight: movementData?.idealBMI,
          initialPatientID: movementData?.patientID,
          initialCaseNumber: movementData?.caseNumber,
          initialAdmissionTime: movementData?.azpICU,
          initialDischargeTime: movementData?.ezpICU,
          initialVentilationDays: movementData?.ventilationDays,
          initialAdmissionTimeToTheHospital: movementData?.azpKH,
          initialDischargeTimeFromTheHospital:
              dischargeTimeFromTheHospital ?? movementData?.ezpKH,
          initialICD10Codes: movementData?.icd10Codes,
          initialPatientLocation: movementData?.station,
          initialHospitalLengthOfStay: movementData?.khLengthStay,
          initialICULengthOfStay: movementData?.icuLengthStay,
          initialReadmissionRateToTheICU: movementData?.wdaICU,
          initialLungProtectiveVentilation70p: movementData?.lbgt70,
          birthDateCallback: (DateTime? value) {
            birthDate = value;
          },
          genderCallback: (String? value) {
            gender = value;
          },
          bodyWeightCallback: (double? value) {
            bodyWeight = value;
          },
          bodyHeightCallback: (double? value) {
            bodyHeight = value;
          },
          bodyMassIndexCallback: (double? value) {
            bodyMassIndex = value;
          },
          idealBodyWeightCallback: (double? value) {
            idealBodyWeight = value;
          },
          patientIDCallback: (String? value) {
            patientID = value;
          },
          caseNumberCallback: (String? value) {
            caseNumber = value;
          },
          admissionTimeICUCallback: (DateTime? value) {
            admissionTime = value;
          },
          dischargeTimeICUCallback: (DateTime? value) {
            dischargeTime = value;
          },
          ventilationDaysICUCallback: (int? value) {
            ventilationDays = value;
          },
          admissionTimeHospitalCallback: (DateTime? value) {
            admissionTimeToTheHospital = value;
          },
          dischargeTimeHospitalCallback: (DateTime? value) {
            dischargeTimeFromTheHospital = value;
          },
          icd10COdesCallback: (List<dynamic>? value) {
            icd10Codes = value;
          },
          patientLocationCallback: (String? value) {
            patientLocation = value;
          },
          lungProtectiveVentilationGt70pCallback: (bool? value) {
            lungProtectiveVentilation70 = value;
          },
          hospitalLengthOfStayCallback: (int? value) {
            hospitalLengthOfStay = value;
          },
          icuLengthOfStayCallback: (int? value) {
            icuLengthOfStay = value;
          },
          readmissionRateICUCallback: (bool? value) {
            readmissionRateToTheICU = value;
          },
        ),
      ),
    ];
  }

  /// If the patient had 24h mechanical ventilation.
  bool mechanicalVentilation24h = false;

  /// If the patient stayed 72h on ICU.
  bool icuStay72h = false;

  /// If the patient is older than 18 years.
  bool age18Years = false;

  /// The ICU main diagnosis.
  String? mainDiagnosis;

  /// The ancillary diagnosis.
  List<dynamic>? ancillaryDiagnosis;

  /// If the patient has ICUAW.
  bool? intensiveCareUnitAcquiredWeakness;

  /// If the patient has PICS.
  bool? postIntensiveCareSyndrome;

  /// Last heart rate.
  double? heartRate1;

  /// Pre last heart rate.
  double? heartRate2;

  /// Last systolic arterial pressure.
  double? systolicArterialPressure1;

  /// Pre last systolic arterial pressure.
  double? systolicArterialPressure2;

  /// Last mean arterial pressure.
  double? meanArterialPressure1;

  /// Pre last mean arterial pressure.
  double? meanArterialPressure2;

  /// Last diastolic arterial pressure.
  double? diastolicArterialPressure1;

  /// Pre last diastolic arterial pressure.
  double? diastolicArterialPressure2;

  /// Last central venous pressure.
  double? centralVenousPressure1;

  /// Pre last central venous pressure.
  double? centralVenousPressure2;

  /// Tidal Volume
  double? tidalVolume;

  /// Last Respitory Rate.
  double? respiratoryRate1;

  /// Pre last Respitory Rate.
  double? respiratoryRate2;

  /// Last Oxygen Saturation.
  double? oxygenSaturation1;

  /// Pre last Oxygen Saturation.
  double? oxygenSaturation2;

  /// Last Arterial Oxygen Saturation.
  double? arterialOxygenSaturation1;

  /// Pre last Arterial Oxygen Saturation.
  double? arterialOxygenSaturation2;

  /// Last Central Venous Oxygen Saturation.
  double? centralVenousOxygenSaturation1;

  /// Pre last Central Venous Oxygen Saturation.
  double? centralVenousOxygenSaturation2;

  /// Last Partial Pressure of Oxygen.
  double? partialPressureOfOxygen1;

  /// Pre last Partial Pressure of Oxygen.
  double? partialPressureOfOxygen2;

  /// Last Partial Pressure of Carbon Dioxide.
  double? partialPressureOfCarbonDioxide1;

  /// Pre last Partial Pressure of Carbon Dioxide.
  double? partialPressureOfCarbonDioxide2;

  /// Last Arterial Base Excess.
  double? arterialBaseExcess1;

  /// Pre last Arterial Base Excess.
  double? arterialBaseExcess2;

  /// Last Arterial PH.
  double? arterialPH1;

  /// Pre last Arterial PH.
  double? arterialPH2;

  /// Last Arterial Seum Bicarbonate Concentration.
  double? arterialSerumBicarbonateConcentration1;

  /// Pre last Arterial Serum Bicarbonate Concentration.
  double? arterialSerumBicarbonateConcentration2;

  /// Last Arterial Lactate.
  double? arterialLactate1;

  /// Pre last Arterial Lactate.
  double? arterialLactate2;

  /// Last Blood GLucose Level.
  double? bloodGlucoseLevel1;

  /// Pre last Blood Glucose Level.
  double? bloodGlucoseLevel2;

  /// Leukocyte Count.
  double? leukocyteCount;

  /// Lymphycyte Count.
  double? lymphocyteCount;

  /// Lymphocyte Percentage.
  double? lymphocytePercentage;

  /// Platelet Count.
  double? plateletCount;

  /// cReactive Protein Level.
  double? cReactiveProteinLevel;

  /// Procalcitonin Level.
  double? procalcitoninLevel;

  /// Interleukin.
  double? interleukin;

  /// Blood Urea Nitrogen.
  double? bloodUreaNitrogen;

  /// Creatinine.
  double? creatinine;

  /// Heart Failure Marker.
  double? heartFailureMarker;

  /// Heart Failure Marker NT Pro BNP.
  double? heartFailureMarkerNTProBNP;

  /// Bilirubin Total.
  double? bilirubinTotal;

  /// Hemoglobin.
  double? hemoglobin;

  /// Hematocrit.
  double? hematocrit;

  /// Albumin.
  double? albumin;

  /// gotASAT.
  double? gotASAT;

  /// gptALAT.
  double? gptALAT;

  /// Troponin.
  double? troponin;

  /// Creatine Kinase.
  double? creatineKinase;

  /// Myocardial Infarction Marker CKMB.
  double? myocardialInfarctionMarkerCKMB;

  /// Lactatet Dehydrogenase Level.
  double? lactateDehydrogenaseLevel;

  /// Amylase Level.
  double? amylaseLevel;

  /// Lipase Level.
  double? lipaseLevel;

  /// dDimer.
  double? dDimer;

  /// International Normalized Ratio.
  double? internationalNormalizedRatio;

  /// Partial Thromboplastin Time.
  double? partialThromboplastinTime;

  /// Patient's Birthdate.
  DateTime? birthDate;

  /// Gender.
  String? gender;

  /// Patient's body weight.
  double? bodyWeight;

  /// Patient's body height.
  double? bodyHeight;

  /// Patient's body mass index.
  double? bodyMassIndex;

  /// Patient's idead body weight.
  double? idealBodyWeight;

  /// Patient'S ID.
  String? patientID;

  /// Patient's case number.
  String? caseNumber;

  /// Admission Time to the ICU.
  DateTime? admissionTime;

  /// Discharge Time from the ICU
  DateTime? dischargeTime;

  /// Ventilation Days.
  int? ventilationDays;

  /// Admission Time to the Hospital.
  DateTime? admissionTimeToTheHospital;

  /// Discharge Time from the Hospital.
  DateTime? dischargeTimeFromTheHospital;

  /// ICD 10 Codes.
  List<dynamic>? icd10Codes;

  /// Patient Location.
  String? patientLocation;

  /// Lung Protective Ventilation greater than 70%.
  bool? lungProtectiveVentilation70;

  /// Length of Stay in Hospital.
  int? hospitalLengthOfStay;

  /// Length of Stay in ICU.
  int? icuLengthOfStay;

  /// Readmission Rate to the ICU.
  bool? readmissionRateToTheICU;

  /// Readmission to the Hospital.
  int? hospitalReadmission;

  /// Institute Key.
  String? instKey;

  /// The loaded pages.
  late List<PicosPageViewItem> pages;
}
