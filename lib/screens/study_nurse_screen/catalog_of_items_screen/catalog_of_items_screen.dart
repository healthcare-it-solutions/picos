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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picos/api/backend_catalog_of_items_api.dart';
import 'package:picos/models/blood_gas_analysis.dart';
import 'package:picos/models/blood_gas_analysis_object.dart';
import 'package:picos/models/catalog_of_items_element.dart';
import 'package:picos/models/icu_diagnosis.dart';
import 'package:picos/models/medicaments.dart';
import 'package:picos/models/patient_data.dart';
import 'package:picos/models/respiratory_parameters.dart';
import 'package:picos/models/respiratory_parameters_object.dart';
import 'package:picos/models/vital_signs.dart';
import 'package:picos/models/vital_signs_object.dart';
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/catalog_of_items_page_storage.dart';
import 'package:picos/state/objects_list_bloc.dart';
import 'package:picos/util/backend.dart';
import 'package:picos/util/page_view_navigation.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/labor_parameters.dart';
import '../../../themes/global_theme.dart';
import '../../../widgets/picos_add_button_bar.dart';
import '../../../widgets/picos_ink_well_button.dart';
import '../menu_screen/edit_patient_screen.dart';

/// A catalog of items containing patient data as a form.

class CatalogOfItemsScreen extends StatefulWidget {
  /// Creates CatalogOfItemsScreen.

  const CatalogOfItemsScreen({Key? key}) : super(key: key);

  @override
  State<CatalogOfItemsScreen> createState() => _CatalogOfItemsScreenState();
}

class _CatalogOfItemsScreenState extends State<CatalogOfItemsScreen>
    with PageViewNavigation {
  static String? _back;
  static String? _next;

  static GlobalTheme? _theme;

  // All values can be accessed here.
  CatalogOfItemsPageStorage? pageStorage;

  //TODO: Create next page callback for saving the values inside pages.

  void _nextPageCallback() {
    int currentPage = page.toInt() + 1;

    if (currentPage == pages.length) {
      VitalSignsObject vitalSignsObject1 = VitalSignsObject(
        heartRate: pageStorage?.heartRate1,
        systolicArterialPressure: pageStorage?.systolicArterialPressure1,
        meanArterialPressure: pageStorage?.meanArterialPressure1,
        diastolicArterialPressure: pageStorage?.diastolicArterialPressure1,
        centralVenousPressure: pageStorage?.centralVenousPressure1,
      );

      VitalSignsObject vitalSignsObject2 = VitalSignsObject(
        heartRate: pageStorage?.heartRate2,
        systolicArterialPressure: pageStorage?.systolicArterialPressure2,
        meanArterialPressure: pageStorage?.meanArterialPressure2,
        diastolicArterialPressure: pageStorage?.diastolicArterialPressure2,
        centralVenousPressure: pageStorage?.centralVenousPressure2,
      );

      RespiratoryParametersObject respiratoryParametersObject1 =
          RespiratoryParametersObject(
        tidalVolume: pageStorage?.tidalVolume,
        respiratoryRate: pageStorage?.respiratoryRate1,
        oxygenSaturation: pageStorage?.oxygenSaturation1,
      );

      RespiratoryParametersObject respiratoryParametersObject2 =
          RespiratoryParametersObject(
        tidalVolume: pageStorage?.tidalVolume,
        respiratoryRate: pageStorage?.respiratoryRate2,
        oxygenSaturation: pageStorage?.oxygenSaturation2,
      );

      BloodGasAnalysisObject bloodGasAnalysisObject1 = BloodGasAnalysisObject(
        arterialOxygenSaturation: pageStorage?.arterialOxygenSaturation1,
        centralVenousOxygenSaturation:
            pageStorage?.centralVenousOxygenSaturation1,
        partialPressureOfOxygen: pageStorage?.partialPressureOfOxygen1,
        partialPressureOfCarbonDioxide:
            pageStorage?.partialPressureOfCarbonDioxide1,
        arterialBaseExcess: pageStorage?.arterialBaseExcess1,
        arterialPH: pageStorage?.arterialPH1,
        arterialSerumBicarbonateConcentration:
            pageStorage?.arterialSerumBicarbonateConcentration1,
        arterialLactate: pageStorage?.arterialLactate1,
        bloodGlucoseLevel: pageStorage?.bloodGlucoseLevel1,
      );

      BloodGasAnalysisObject bloodGasAnalysisObject2 = BloodGasAnalysisObject(
        arterialOxygenSaturation: pageStorage?.arterialOxygenSaturation1,
        centralVenousOxygenSaturation:
            pageStorage?.centralVenousOxygenSaturation1,
        partialPressureOfOxygen: pageStorage?.partialPressureOfOxygen1,
        partialPressureOfCarbonDioxide:
            pageStorage?.partialPressureOfCarbonDioxide1,
        arterialBaseExcess: pageStorage?.arterialBaseExcess1,
        arterialPH: pageStorage?.arterialPH1,
        arterialSerumBicarbonateConcentration:
            pageStorage?.arterialSerumBicarbonateConcentration1,
        arterialLactate: pageStorage?.arterialLactate1,
        bloodGlucoseLevel: pageStorage?.bloodGlucoseLevel1,
      );

      CatalogOfItemsElement catalogOfItemsElement = CatalogOfItemsElement(
        icuDiagnosis: ICUDiagnosis(
          mainDiagnosis: pageStorage?.mainDiagnosis,
          progressDiagnosis: pageStorage?.progressDiagnosis,
          coMorbidity: pageStorage?.coMorbidity,
          intensiveCareUnitAcquiredWeakness:
              pageStorage?.intensiveCareUnitAcquiredWeakness,
          postIntensiveCareSyndrome: pageStorage?.postIntensiveCareSyndrome,
          doctorObjectId: Backend.user.objectId!,
          patientObjectId: EditPatientScreen.patientObjectId!,
        ),
        vitalSignsObject1: vitalSignsObject1,
        vitalSignsObject2: vitalSignsObject2,
        vitalSigns: VitalSigns(
          doctorObjectId: Backend.user.objectId!,
          value1: vitalSignsObject1,
          value2: vitalSignsObject2,
          patientObjectId: EditPatientScreen.patientObjectId!,
        ),
        respiratoryParametersObject1: respiratoryParametersObject1,
        respiratoryParametersObject2: respiratoryParametersObject2,
        respiratoryParameters: RespiratoryParameters(
          doctorObjectId: Backend.user.objectId!,
          value1: respiratoryParametersObject1,
          value2: respiratoryParametersObject2,
          patientObjectId: EditPatientScreen.patientObjectId!,
        ),
        bloodGasAnalysisObject1: bloodGasAnalysisObject1,
        bloodGasAnalysisObject2: bloodGasAnalysisObject2,
        bloodGasAnalysis: BloodGasAnalysis(
          doctorObjectId: Backend.user.objectId!,
          value1: bloodGasAnalysisObject1,
          value2: bloodGasAnalysisObject2,
          patientObjectId: EditPatientScreen.patientObjectId!,
        ),
        laborParameters: LaborParameters(
          patientObjectId: EditPatientScreen.patientObjectId!,
          doctorObjectId: Backend.user.objectId!,
          leukocyteCount: pageStorage?.leukocyteCount,
          lymphocyteCount: pageStorage?.lymphocyteCount,
          lymphocytePercentage: pageStorage?.lymphocytePercentage,
          plateletCount: pageStorage?.plateletCount,
          cReactiveProteinLevel: pageStorage?.cReactiveProteinLevel,
          procalcitoninLevel: pageStorage?.procalcitoninLevel,
          interleukin: pageStorage?.interleukin,
          bloodUreaNitrogen: pageStorage?.bloodUreaNitrogen,
          creatinine: pageStorage?.creatinine,
          heartFailureMarker: pageStorage?.heartFailureMarker,
          heartFailureMarkerNTProBNP: pageStorage?.heartFailureMarkerNTProBNP,
          bilirubinTotal: pageStorage?.bilirubinTotal,
          hemoglobin: pageStorage?.hemoglobin,
          hematocrit: pageStorage?.hematocrit,
          albumin: pageStorage?.albumin,
          gotASAT: pageStorage?.gotASAT,
          gptALAT: pageStorage?.gptALAT,
          troponin: pageStorage?.troponin,
          creatineKinase: pageStorage?.creatineKinase,
          myocardialInfarctionMarkerCKMB:
              pageStorage?.myocardialInfarctionMarkerCKMB,
          lactateDehydrogenaseLevel: pageStorage?.lactateDehydrogenaseLevel,
          amylaseLevel: pageStorage?.amylaseLevel,
          lipaseLevel: pageStorage?.lipaseLevel,
          dDimer: pageStorage?.dDimer,
          internationalNormalizedRatio:
              pageStorage?.internationalNormalizedRatio,
          partialThromboplastinTime: pageStorage?.partialThromboplastinTime,
        ),
        medicaments: Medicaments(
          patientObjectId: EditPatientScreen.patientObjectId!,
          doctorObjectId: Backend.user.objectId!,
          plateletAggregation: pageStorage?.plateletAggregation,
          noak: pageStorage?.noak,
          thrombosisProphylaxis: pageStorage?.thrombosisProphylaxis,
          antihypertensives: pageStorage?.antihypertensives,
          antiarrhythmics: pageStorage?.antiarrhythmics,
          antidiabetics: pageStorage?.antidiabetics,
          antiInfectives: pageStorage?.antihypertensives,
          steroids: pageStorage?.steroids,
          inhalatives: pageStorage?.inhalatives,
          analgesics: pageStorage?.analgesics,
        ),
        movementData: PatientData(
          bodyHeight: EditPatientScreen.bodyHeight!,
          patientID: EditPatientScreen.patientID!,
          caseNumber: EditPatientScreen.caseNumber!,
          instKey: EditPatientScreen.instituteKey!,
          patientObjectId: EditPatientScreen.patientObjectId!,
          doctorObjectId: Backend.user.objectId!,
          bodyWeight: pageStorage?.bodyWeight,
          ezpICU: pageStorage?.dischargeTime,
          age: pageStorage?.age,
          gender: pageStorage?.gender,
          bmi: pageStorage?.bodyMassIndex,
          idealBMI: pageStorage?.idealBodyWeight,
          dischargeReason: pageStorage?.reasonForDischarge,
          azpICU: pageStorage?.admissionTime,
          ventilationDays: pageStorage?.ventilationDays,
          azpKH: pageStorage?.admissionTimeToTheHospital,
          ezpKH: pageStorage?.dischargeTimeFromTheHospital,
          icd10Codes: pageStorage?.icd10Codes,
          station: pageStorage?.patientLocation,
          lbgt70: pageStorage?.lungProtectiveVentilation70,
          icuMortality: pageStorage?.icuMortality,
          khMortality: pageStorage?.hospitalMortality,
          icuLengthStay: pageStorage?.icuLengthOfStay,
          khLengthStay: pageStorage?.hospitalLengthOfStay,
          wdaKH: pageStorage?.hospitalReadmission,
          weznDisease: pageStorage?.daysUntilWorkReuptake,
        ),
      );
      context.read<ObjectsListBloc<BackendCatalogOfItemsApi>>().add(
            SaveObject(catalogOfItemsElement),
          );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    _theme ??= Theme.of(context).extension<GlobalTheme>()!;

    if (pages.isEmpty) {
      buildContext = context;
      _back = AppLocalizations.of(context)!.back;
      _next = AppLocalizations.of(context)!.next;
      pageStorage = CatalogOfItemsPageStorage(context);
      pages = pageStorage!.pages;

      nextPageCallback = _nextPageCallback;
    }

    return BlocBuilder<ObjectsListBloc<BackendCatalogOfItemsApi>,
        ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        return PicosScreenFrame(
          title: 'Catalog of items',
          body: PageView(
            controller: controller,
            children: pages,
          ),
          bottomNavigationBar: PicosAddButtonBar(
            leftButton: PicosInkWellButton(
              text: _back!,
              onTap: previousPage,
              buttonColor1: _theme!.grey3,
              buttonColor2: _theme!.grey1,
            ),
            rightButton: PicosInkWellButton(
              text: _next!,
              onTap: nextPage,
            ),
          ),
        );
      },
    );
  }
}
