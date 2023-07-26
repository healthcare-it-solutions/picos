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
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/pages/medicaments_page.dart';
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/pages/movement_data_page.dart';
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/pages/respiration_parameters_page.dart';
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/pages/vital_data_page.dart';

import '../../../models/blood_gas_analysis.dart';
import '../../../models/blood_gas_analysis_object.dart';
import '../../../models/catalog_of_items_element.dart';
import '../../../models/icu_diagnosis.dart';
import '../../../models/labor_parameters.dart';
import '../../../models/patient_data.dart';
import '../../../models/respiratory_parameters.dart';
import '../../../models/respiratory_parameters_object.dart';
import '../../../models/vital_signs.dart';
import '../../../models/vital_signs_object.dart';
import '../../../models/medicaments.dart';
import '../../../widgets/picos_form_of_address.dart';
import '../../../widgets/picos_page_view_item.dart';

/// Manages the state of the Catalog of items pages.
class CatalogOfItemsPageStorage {
  /// Creates CatalogOfItemsPageStorage.
  CatalogOfItemsPageStorage(
    BuildContext context,
    CatalogOfItemsElement catalogOfItemsElement,
  ) {
    ICUDiagnosis icuDiagnosis = catalogOfItemsElement.icuDiagnosis;
    VitalSignsObject vitalSignsObject1 =
        catalogOfItemsElement.vitalSignsObject1;
    VitalSignsObject vitalSignsObject2 =
        catalogOfItemsElement.vitalSignsObject2;
    VitalSigns vitalSigns = catalogOfItemsElement.vitalSigns;
    RespiratoryParametersObject respiratoryParametersObject1 =
        catalogOfItemsElement.respiratoryParametersObject1;
    RespiratoryParametersObject respiratoryParametersObject2 =
        catalogOfItemsElement.respiratoryParametersObject2;
    RespiratoryParameters respiratoryParameters =
        catalogOfItemsElement.respiratoryParameters;
    BloodGasAnalysisObject bloodGasAnalysisObject1 =
        catalogOfItemsElement.bloodGasAnalysisObject1;
    BloodGasAnalysisObject bloodGasAnalysisObject2 =
        catalogOfItemsElement.bloodGasAnalysisObject2;
    BloodGasAnalysis bloodGasAnalysis = catalogOfItemsElement.bloodGasAnalysis;
    LaborParameters laborParameters = catalogOfItemsElement.laborParameters;
    Medicaments medicaments = catalogOfItemsElement.medicaments;
    PatientData movementData = catalogOfItemsElement.movementData;

    pages = <PicosPageViewItem>[
      PicosPageViewItem(
        child: IcuDiagnosisPage(
          initialCoMorbidity: icuDiagnosis.coMorbidity,
          initialIcuaw: icuDiagnosis.intensiveCareUnitAcquiredWeakness,
          initialMainDiagnosis: icuDiagnosis.mainDiagnosis,
          initialPics: icuDiagnosis.postIntensiveCareSyndrome,
          initialProgressDiagnosis: icuDiagnosis.progressDiagnosis,
          mainDiagnosisCallback: (String? value) {
            mainDiagnosis = value;
          },
          progressDiagnosisCallback: (String? value) {
            progressDiagnosis = value;
          },
          coMorbidityCallback: (String? value) {
            coMorbidity = value;
          },
          icuawCallback: (bool value) {
            intensiveCareUnitAcquiredWeakness = value;
          },
          picsCallback: (bool value) {
            postIntensiveCareSyndrome = value;
          },
        ),
      ),
      PicosPageViewItem(
        child: VitalDataPage(
          initialCentralVenousPressure1:
              vitalSignsObject1.centralVenousPressure,
          initialCentralVenousPressure2:
              vitalSignsObject2.centralVenousPressure,
          initialDap1: vitalSignsObject1.diastolicArterialPressure,
          initialDap2: vitalSignsObject2.diastolicArterialPressure,
          initialHeartRate1: vitalSignsObject1.heartRate,
          initialHeartRate2: vitalSignsObject2.heartRate,
          initialMap1: vitalSignsObject1.meanArterialPressure,
          initialMap2: vitalSignsObject2.meanArterialPressure,
          initialSap1: vitalSignsObject1.systolicArterialPressure,
          initialSap2: vitalSignsObject2.systolicArterialPressure,
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
          initialTidalVolume: respiratoryParametersObject1.tidalVolume,
          initialRespiratoryRate1: respiratoryParametersObject1.respiratoryRate,
          initialRespiratoryRate2: respiratoryParametersObject2.respiratoryRate,
          initialOxygenSaturation1:
              respiratoryParametersObject1.oxygenSaturation,
          initialOxygenSaturation2:
              respiratoryParametersObject2.oxygenSaturation,
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
              bloodGasAnalysisObject1.arterialOxygenSaturation,
          initialArterialOxygenSaturation2:
              bloodGasAnalysisObject2.arterialOxygenSaturation,
          initialCentralVenousOxygenSaturation1:
              bloodGasAnalysisObject1.centralVenousOxygenSaturation,
          initialCentralVenousOxygenSaturation2:
              bloodGasAnalysisObject2.centralVenousOxygenSaturation,
          initialPartialPressureOfOxygen1:
              bloodGasAnalysisObject1.partialPressureOfOxygen,
          initialPartialPressureOfOxygen2:
              bloodGasAnalysisObject2.partialPressureOfOxygen,
          initialPartialPressureOfCarbonDioxide1:
              bloodGasAnalysisObject1.partialPressureOfCarbonDioxide,
          initialPartialPressureOfCarbonDioxide2:
              bloodGasAnalysisObject2.partialPressureOfCarbonDioxide,
          initialarterialBaseExcess1:
              bloodGasAnalysisObject1.arterialBaseExcess,
          initialarterialBaseExcess2:
              bloodGasAnalysisObject2.arterialBaseExcess,
          initialarterialPH1: bloodGasAnalysisObject1.arterialPH,
          initialarterialPH2: bloodGasAnalysisObject2.arterialPH,
          initialArterialSerumBicarbonateConcentration1:
              bloodGasAnalysisObject1.arterialSerumBicarbonateConcentration,
          initialArterialSerumBicarbonateConcentration2:
              bloodGasAnalysisObject2.arterialSerumBicarbonateConcentration,
          initialArterialLactate1: bloodGasAnalysisObject1.arterialLactate,
          initialArterialLacatate2: bloodGasAnalysisObject2.arterialLactate,
          initialBloodGlucoseLevel1: bloodGasAnalysisObject1.bloodGlucoseLevel,
          initialBloodGlucoseLevel2: bloodGasAnalysisObject2.bloodGlucoseLevel,
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
          bloodGlucoseLevelCallback1: (String? value) {
            bloodGlucoseLevel1 = value;
          },
          bloodGlucoseLevelCallback2: (String? value) {
            bloodGlucoseLevel2 = value;
          },
        ),
      ),
      PicosPageViewItem(
        child: LaboratoryValuesPage(
          initialLeukocyteCount: laborParameters.leukocyteCount,
          initialLymphocyteCount: laborParameters.lymphocyteCount,
          initialLymphocytePercentage: laborParameters.lymphocytePercentage,
          initialPlateletCount: laborParameters.plateletCount,
          initialcReactiveProteinLevel: laborParameters.cReactiveProteinLevel,
          initialProcalcitoninLevel: laborParameters.procalcitoninLevel,
          initialInterleukin: laborParameters.interleukin,
          initialBloodUreaNitrogen: laborParameters.bloodUreaNitrogen,
          initialCreatinine: laborParameters.creatinine,
          initialHeartFailureMarker: laborParameters.heartFailureMarker,
          initialHeartFailureMarkerNTProBNP:
              laborParameters.heartFailureMarkerNTProBNP,
          initialBilirubinTotal: laborParameters.bilirubinTotal,
          initialHemoglobin: laborParameters.hemoglobin,
          initialHematocrit: laborParameters.hematocrit,
          initialAlbumin: laborParameters.albumin,
          initialGOTASAT: laborParameters.gotASAT,
          initialGPTALAT: laborParameters.gptALAT,
          initialTroponin: laborParameters.troponin,
          initialCreatineKinase: laborParameters.creatineKinase,
          initialMyocardialInfarctionMarkerCKMB:
              laborParameters.myocardialInfarctionMarkerCKMB,
          initialLactateDehydrogenaseLevel:
              laborParameters.lactateDehydrogenaseLevel,
          initialAmylaseLevel: laborParameters.amylaseLevel,
          initialLipaseLevel: laborParameters.lipaseLevel,
          initialDDimer: laborParameters.dDimer,
          initialInternationalNormalizedRatio:
              laborParameters.internationalNormalizedRatio,
          initialPartialThromboplastinTime:
              laborParameters.partialThromboplastinTime,
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
        child: MedicamentsPage(
          initialMorning: medicaments.morning,
          initialNoon: medicaments.noon,
          initialEvening: medicaments.evening,
          initialAtNight: medicaments.atNight,
          initialUnit: medicaments.unit,
          initialMedicalProduct: medicaments.medicalProduct,
          morningCallback: (double? value) {
            morning = value;
          },
          noonCallback: (double? value) {
            noon = value;
          },
          eveningCallback: (double? value) {
            evening = value;
          },
          atNightCallback: (double? value) {
            atNight = value;
          },
          unitCallback: (String? value) {
            unit = value;
          },
          medicalProductCallback: (String? value) {
            medicalProduct = value;
          },
        ),
      ),
      PicosPageViewItem(
        child: MovementDataPage(
          ageCallback: (int? value) {
            age = value;
          },
          genderCallback: (FormOfAddress? value) {
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
          reasonForDischargeCallback: (String? value) {
            reasonForDischarge = value;
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
          icd10COdesCallback: (List<String>? value) {
            icd10Codes = value;
          },
          patientLocationCallback: (String? value) {
            patientLocation = value;
          },
          lungProtectiveVentilationGt70pCallback: (bool? value) {
            lungProtectiveVentilation70 = value!;
          },
          icuMortalityCallback: (double? value) {
            icuMortality = value;
          },
          hospitalMortalityCallback: (double? value) {
            hospitalMortality = value;
          },
          hospitalLengthOfStayCallback: (int? value) {
            hospitalLengthOfStay = value;
          },
          icuLengthOfStayCallback: (int? value) {
            icuLengthOfStay = value;
          },
          readmissionRateICUCallback: (double? value) {
            readmissionRateToTheICU = value;
          },
          hospitalReadmissionCallback: (double? value) {
            hospitalReadmission = value;
          },
          daysUntilWorkReuptakeCallback: (double? value) {
            daysUntilWorkReuptake = value;
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

  /// The ICU progress diagnosis.
  String? progressDiagnosis;

  /// The co-morbidity.
  String? coMorbidity;

  /// If the patient has ICUAW.
  bool intensiveCareUnitAcquiredWeakness = false;

  /// If the patient has PICS.
  bool postIntensiveCareSyndrome = false;

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
  double? respiratoryRate1;
  double? respiratoryRate2;
  double? oxygenSaturation1;
  double? oxygenSaturation2;

  double? arterialOxygenSaturation1;
  double? arterialOxygenSaturation2;
  double? centralVenousOxygenSaturation1;
  double? centralVenousOxygenSaturation2;
  double? partialPressureOfOxygen1;
  double? partialPressureOfOxygen2;
  double? partialPressureOfCarbonDioxide1;
  double? partialPressureOfCarbonDioxide2;
  double? arterialBaseExcess1;
  double? arterialBaseExcess2;
  double? arterialPH1;
  double? arterialPH2;
  double? arterialSerumBicarbonateConcentration1;
  double? arterialSerumBicarbonateConcentration2;
  double? arterialLactate1;
  double? arterialLactate2;
  String? bloodGlucoseLevel1;
  String? bloodGlucoseLevel2;

  double? leukocyteCount;
  double? lymphocyteCount;
  double? lymphocytePercentage;
  double? plateletCount;
  double? cReactiveProteinLevel;
  double? procalcitoninLevel;
  double? interleukin;
  double? bloodUreaNitrogen;
  double? creatinine;
  double? heartFailureMarker;
  double? heartFailureMarkerNTProBNP;
  double? bilirubinTotal;
  double? hemoglobin;
  double? hematocrit;
  double? albumin;
  double? gotASAT;
  double? gptALAT;
  double? troponin;
  double? creatineKinase;
  double? myocardialInfarctionMarkerCKMB;
  double? lactateDehydrogenaseLevel;
  double? amylaseLevel;
  double? lipaseLevel;
  double? dDimer;
  double? internationalNormalizedRatio;
  double? partialThromboplastinTime;

  double? morning;
  double? noon;
  double? evening;
  double? atNight;
  String? unit;
  String? medicalProduct;

  int? age;
  FormOfAddress? gender;
  double? bodyWeight;
  double? bodyHeight;
  double? bodyMassIndex;
  double? idealBodyWeight;
  String? patientID;
  String? caseNumber;
  String? reasonForDischarge;
  DateTime? admissionTime;
  DateTime? dischargeTime;
  int? ventilationDays;
  DateTime? admissionTimeToTheHospital;
  DateTime? dischargeTimeFromTheHospital;
  List<String>? icd10Codes;
  String? patientLocation;
  bool lungProtectiveVentilation70 = false;
  double? icuMortality;
  double? hospitalMortality;
  int? hospitalLengthOfStay;
  int? icuLengthOfStay;
  double? readmissionRateToTheICU;
  double? hospitalReadmission;
  double? daysUntilWorkReuptake;
  String? instKey;

  /// The loaded pages.
  late List<PicosPageViewItem> pages;
}
