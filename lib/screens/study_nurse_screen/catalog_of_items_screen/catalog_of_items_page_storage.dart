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
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/pages/blood_gas_analysis.dart';
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/pages/icu_diagnosis.dart';
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/pages/inclusion_criteria.dart';
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/pages/laboratory_values.dart';
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/pages/medicaments.dart';
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/pages/movement_data.dart';
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/pages/respiration_parameters.dart';
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/pages/vital_data.dart';

import '../../../widgets/picos_form_of_address.dart';
import '../../../widgets/picos_page_view_item.dart';

/// Manages the state of the Catalog of items pages.
class CatalogOfItemsPageStorage {
  /// Creates CatalogOfItemsPageStorage.
  CatalogOfItemsPageStorage(BuildContext context) {
    pages = <PicosPageViewItem>[
      PicosPageViewItem(
        child: InclusionCriteria(
          initialAge18Years: age18Years,
          initialIcuStay72h: icuStay72h,
          initialMechanicalVentilation24h: mechanicalVentilation24h,
          mechanicalVentilation24hCallback: (bool value) {
            mechanicalVentilation24h = value;
          },
          icuStay72hCallback: (bool value) {
            icuStay72h = value;
          },
          age18YearsCallback: (bool value) {
            age18Years = value;
          },
        ),
      ),
      PicosPageViewItem(
        child: IcuDiagnosis(
          initialCoMorbidity: coMorbidity,
          initialIcuaw: intensiveCareUnitAcquiredWeakness,
          initialMainDiagnosis: mainDiagnosis,
          initialPics: postIntensiveCareSyndrome,
          initialProgressDiagnosis: progressDiagnosis,
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
        child: VitalData(
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
          initialCentralVenousPressure1: centralVenousOxygenSaturation1,
          initialCentralVenousPressure2: centralVenousPressure2,
          initialDap1: diastolicArterialPressure1,
          initialDap2: diastolicArterialPressure2,
          initialHeartRate1: heartRate1,
          initialHeartRate2: heartRate2,
          initialMap1: meanArterialPressure1,
          initialMap2: meanArterialPressure2,
          initialSap1: systolicArterialPressure1,
          initialSap2: systolicArterialPressure2,
        ),
      ),
      PicosPageViewItem(
        child: RespirationParameters(
          initialTidalVolume: tidalVolume,
          initialRespiratoryRate1: respiratoryRate1,
          initialRespiratoryRate2: respiratoryRate2,
          initialOxygenSaturation1: oxygenSaturation1,
          initialOxygenSaturation2: oxygenSaturation2,
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
        child: BloodGasAnalysis(
          initialArterialOxygenSaturation1: arterialOxygenSaturation1,
          initialArterialOxygenSaturation2: arterialOxygenSaturation2,
          initialCentralVenousOxygenSaturation1: centralVenousOxygenSaturation1,
          initialCentralVenousOxygenSaturation2: centralVenousOxygenSaturation2,
          initialPartialPressureOfOxygen1: partialPressureOfOxygen1,
          initialPartialPressureOfOxygen2: partialPressureOfOxygen2,
          initialPartialPressureOfCarbonDioxide1:
              partialPressureOfCarbonDioxide1,
          initialPartialPressureOfCarbonDioxide2:
              partialPressureOfCarbonDioxide2,
          initialarterialBaseExcess1: arterialBaseExcess1,
          initialarterialBaseExcess2: arterialBaseExcess2,
          initialarterialPH1: arterialPH1,
          initialarterialPH2: arterialPH2,
          initialArterialSerumBicarbonateConcentration1:
              arterialSerumBicarbonateConcentration1,
          initialArterialSerumBicarbonateConcentration2:
              arterialSerumBicarbonateConcentration2,
          initialArterialLactate1: arterialLactate1,
          initialArterialLacatate2: arterialLactate2,
          initialBloodGlucoseLevel1: bloodGlucoseLevel1,
          initialBloodGlucoseLevel2: bloodGlucoseLevel2,
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
        child: LaboratoryValues(
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
        child: Medicaments(
          plateletAggregationCallback: (String? value) {
            plateletAggregation = value;
          },
          noakCallback: (String? value) {
            noak = value;
          },
          thrombosisprophylaxisCallback: (String? value) {
            thrombosisProphylaxis = value;
          },
          antihypertensivesCallback: (String? value) {
            antihypertensives = value;
          },
          antiarrythmicsCallback: (String? value) {
            antiarrhythmics = value;
          },
          antidiabeticsCallback: (String? value) {
            antidiabetics = value;
          },
          antiinfectivesCallback: (String? value) {
            antiInfectives = value;
          },
          steroidsCallback: (String? value) {
            steroids = value;
          },
          inhalativesCallback: (String? value) {
            inhalatives = value;
          },
          analgesicsCallback: (String? value) {
            analgesics = value;
          },
          initialPlateletAggregation: plateletAggregation,
          initialNoak: noak,
          initialThrombosisProphylaxis: thrombosisProphylaxis,
          initialAntihypertensives: antihypertensives,
          initialAntiarrhythmics: antiarrhythmics,
          initialAntidiabetics: antidiabetics,
          initialAntiInfectives: antiInfectives,
          initialSteroids: steroids,
          initialInhalatives: inhalatives,
          initialAnalgesics: analgesics,
        ),
      ),
      PicosPageViewItem(
        child: MovementData(
          ageCallback: (int? value) {
            age = value;
          },
          genderCallback: (FormOfAddress? value) {
            gender = value;
          },
          bodyWeightCallback: (double? value) {
            bodyWeight = value;
          },
          heightCallback: (double? value) {
            height = value;
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
          icd10COdesCallback: (String? value) {
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
          daysUntilWorkReuptakeCallback: (int? value) {
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
  double? bloodGlucoseLevel1;
  double? bloodGlucoseLevel2;

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

  String? plateletAggregation;
  String? noak;
  String? thrombosisProphylaxis;
  String? antihypertensives;
  String? antiarrhythmics;
  String? antidiabetics;
  String? antiInfectives;
  String? steroids;
  String? inhalatives;
  String? analgesics;

  int? age;
  FormOfAddress? gender;
  double? bodyWeight;
  double? height;
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
  String? icd10Codes;
  String? patientLocation;
  bool lungProtectiveVentilation70 = false;
  double? icuMortality;
  double? hospitalMortality;
  int? hospitalLengthOfStay;
  int? icuLengthOfStay;
  double? readmissionRateToTheICU;
  double? hospitalReadmission;
  int? daysUntilWorkReuptake;

  /// The loaded pages.
  late List<PicosPageViewItem> pages;
}
