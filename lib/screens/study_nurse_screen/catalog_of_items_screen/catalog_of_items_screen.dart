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
  int _currentPage = 0;

  // All values can be accessed here.
  CatalogOfItemsPageStorage? pageStorage;
  CatalogOfItemsElement? _catalogOfItemsElement;
  bool isLoading = true;

  void _nextPageCallback() {
    _currentPage = page.toInt() + 1;
    if (_currentPage == pages.length) {
      try {
        CatalogOfItemsElement catalogOfItemsElement;
        if (_catalogOfItemsElement == null) {
          catalogOfItemsElement = createCatalogFromPageStorage();
        } else {
          catalogOfItemsElement = updateCatalogFromExistingElement();
        }

        context.read<ObjectsListBloc<BackendCatalogOfItemsApi>>().add(
              SaveObject(catalogOfItemsElement),
            );
        Navigator.of(context).pop();
      } catch (e) {
        Stream<String>.error(e);
      }
    }
  }

  CatalogOfItemsElement createCatalogFromPageStorage() {
    ICUDiagnosis icuDiagnosis = createICUDiagnosis();

    VitalSignsObject vitalSignsObject1 = createVitalSignsObject(1);

    VitalSignsObject vitalSignsObject2 = createVitalSignsObject(2);

    VitalSigns vitalSigns = createVitalSigns(
      vitalSignsObject1,
      vitalSignsObject2,
    );

    RespiratoryParametersObject respiratoryParametersObject1 =
        createRespiratoryParametersObject(
      pageStorage?.tidalVolume,
      pageStorage?.respiratoryRate1,
      pageStorage?.oxygenSaturation1,
    );

    RespiratoryParametersObject respiratoryParametersObject2 =
        createRespiratoryParametersObject(
      pageStorage?.tidalVolume,
      pageStorage?.respiratoryRate2,
      pageStorage?.oxygenSaturation2,
    );
    RespiratoryParameters respiratoryParameters = createRespiratoryParameters(
      respiratoryParametersObject1,
      respiratoryParametersObject2,
    );
    BloodGasAnalysisObject bloodGasAnalysisObject1 =
        createBloodGasAnalysisObject(1);

    BloodGasAnalysisObject bloodGasAnalysisObject2 =
        createBloodGasAnalysisObject(2);

    BloodGasAnalysis bloodGasAnalysis = createBloodGasAnalysis(
      bloodGasAnalysisObject1,
      bloodGasAnalysisObject2,
    );

    LaborParameters laborParameters = createLaborParameters();
    PatientData movementData = createMovementData();

    return CatalogOfItemsElement(
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
      movementData: movementData,
    );
  }

  CatalogOfItemsElement updateCatalogFromExistingElement() {
    ICUDiagnosis? icud;
    VitalSignsObject? vitalSignsObject1;
    VitalSignsObject? vitalSignsObject2;
    VitalSigns? vitalSigns;
    RespiratoryParametersObject? respiratoryParametersObject1;
    RespiratoryParametersObject? respiratoryParametersObject2;
    RespiratoryParameters? respiratoryParameters;
    BloodGasAnalysisObject? bloodGasAnalysisObject1;
    BloodGasAnalysisObject? bloodGasAnalysisObject2;
    BloodGasAnalysis? bloodGasAnalysis;
    LaborParameters? laborParameters;
    PatientData? movementData;
    if (_catalogOfItemsElement!.icuDiagnosis != null) {
      icud = _catalogOfItemsElement!.icuDiagnosis!.copyWith(
        mainDiagnosis: pageStorage?.mainDiagnosis,
        ancillaryDiagnosis: pageStorage?.ancillaryDiagnosis,
        intensiveCareUnitAcquiredWeakness:
            pageStorage?.intensiveCareUnitAcquiredWeakness,
        postIntensiveCareSyndrome: pageStorage?.postIntensiveCareSyndrome,
        doctorObjectId: Backend.user.objectId!,
        patientObjectId: EditPatientScreen.patientObjectId!,
      );
    } else {
      icud = createICUDiagnosis();
    }
    if (_catalogOfItemsElement!.vitalSignsObject1 != null) {
      vitalSignsObject1 = _catalogOfItemsElement!.vitalSignsObject1!.copyWith(
        heartRate: pageStorage?.heartRate1,
        systolicArterialPressure: pageStorage?.systolicArterialPressure1,
        meanArterialPressure: pageStorage?.meanArterialPressure1,
        diastolicArterialPressure: pageStorage?.diastolicArterialPressure1,
        centralVenousPressure: pageStorage?.centralVenousPressure1,
      );
    } else {
      vitalSignsObject1 = createVitalSignsObject(1);
    }
    if (_catalogOfItemsElement!.vitalSignsObject2 != null) {
      vitalSignsObject2 = _catalogOfItemsElement!.vitalSignsObject2!.copyWith(
        heartRate: pageStorage?.heartRate2,
        systolicArterialPressure: pageStorage?.systolicArterialPressure2,
        meanArterialPressure: pageStorage?.meanArterialPressure2,
        diastolicArterialPressure: pageStorage?.diastolicArterialPressure2,
        centralVenousPressure: pageStorage?.centralVenousPressure2,
      );
    } else {
      vitalSignsObject2 = createVitalSignsObject(2);
    }

    if (_catalogOfItemsElement!.vitalSigns != null) {
      vitalSigns = _catalogOfItemsElement!.vitalSigns!.copyWith(
        doctorObjectId: Backend.user.objectId!,
        value1: vitalSignsObject1,
        value2: vitalSignsObject2,
        patientObjectId: EditPatientScreen.patientObjectId!,
      );
    } else {
      vitalSigns = createVitalSigns(
        vitalSignsObject1,
        vitalSignsObject2,
      );
    }

    if (_catalogOfItemsElement!.respiratoryParametersObject1 != null) {
      respiratoryParametersObject1 =
          _catalogOfItemsElement!.respiratoryParametersObject1!.copyWith(
        tidalVolume: pageStorage?.tidalVolume,
        respiratoryRate: pageStorage?.respiratoryRate1,
        oxygenSaturation: pageStorage?.oxygenSaturation1,
      );
    } else {
      respiratoryParametersObject1 = createRespiratoryParametersObject(
        pageStorage?.tidalVolume,
        pageStorage?.respiratoryRate1,
        pageStorage?.oxygenSaturation1,
      );
    }

    if (_catalogOfItemsElement!.respiratoryParametersObject2 != null) {
      respiratoryParametersObject2 =
          _catalogOfItemsElement!.respiratoryParametersObject2!.copyWith(
        tidalVolume: pageStorage?.tidalVolume,
        respiratoryRate: pageStorage?.respiratoryRate2,
        oxygenSaturation: pageStorage?.oxygenSaturation2,
      );
    } else {
      respiratoryParametersObject2 = createRespiratoryParametersObject(
        pageStorage?.tidalVolume,
        pageStorage?.respiratoryRate2,
        pageStorage?.oxygenSaturation2,
      );
    }

    if (_catalogOfItemsElement!.respiratoryParameters != null) {
      respiratoryParameters =
          _catalogOfItemsElement!.respiratoryParameters!.copyWith(
        doctorObjectId: Backend.user.objectId!,
        value1: respiratoryParametersObject1,
        value2: respiratoryParametersObject2,
        patientObjectId: EditPatientScreen.patientObjectId!,
      );
    } else {
      respiratoryParameters = createRespiratoryParameters(
        respiratoryParametersObject1,
        respiratoryParametersObject2,
      );
    }

    if (_catalogOfItemsElement!.bloodGasAnalysisObject1 != null) {
      bloodGasAnalysisObject1 =
          _catalogOfItemsElement!.bloodGasAnalysisObject1!.copyWith(
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
    } else {
      bloodGasAnalysisObject1 = createBloodGasAnalysisObject(1);
    }

    if (_catalogOfItemsElement!.bloodGasAnalysisObject2 != null) {
      bloodGasAnalysisObject2 =
          _catalogOfItemsElement!.bloodGasAnalysisObject2!.copyWith(
        arterialOxygenSaturation: pageStorage?.arterialOxygenSaturation2,
        centralVenousOxygenSaturation:
            pageStorage?.centralVenousOxygenSaturation2,
        partialPressureOfOxygen: pageStorage?.partialPressureOfOxygen2,
        partialPressureOfCarbonDioxide:
            pageStorage?.partialPressureOfCarbonDioxide2,
        arterialBaseExcess: pageStorage?.arterialBaseExcess2,
        arterialPH: pageStorage?.arterialPH2,
        arterialSerumBicarbonateConcentration:
            pageStorage?.arterialSerumBicarbonateConcentration2,
        arterialLactate: pageStorage?.arterialLactate2,
        bloodGlucoseLevel: pageStorage?.bloodGlucoseLevel2,
      );
    } else {
      bloodGasAnalysisObject2 = createBloodGasAnalysisObject(2);
    }

    if (_catalogOfItemsElement!.bloodGasAnalysis != null) {
      bloodGasAnalysis = _catalogOfItemsElement!.bloodGasAnalysis!.copyWith(
        doctorObjectId: Backend.user.objectId!,
        value1: bloodGasAnalysisObject1,
        value2: bloodGasAnalysisObject2,
        patientObjectId: EditPatientScreen.patientObjectId!,
      );
    } else {
      bloodGasAnalysis = createBloodGasAnalysis(
        bloodGasAnalysisObject1,
        bloodGasAnalysisObject2,
      );
    }

    if (_catalogOfItemsElement!.laborParameters != null) {
      laborParameters = _catalogOfItemsElement!.laborParameters!.copyWith(
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
        internationalNormalizedRatio: pageStorage?.internationalNormalizedRatio,
        partialThromboplastinTime: pageStorage?.partialThromboplastinTime,
      );
    } else {
      laborParameters = createLaborParameters();
    }
    if (_catalogOfItemsElement!.movementData != null) {
      movementData = _catalogOfItemsElement!.movementData!.copyWith(
        bodyHeight: pageStorage?.bodyHeight,
        patientID: pageStorage?.patientID,
        caseNumber: pageStorage?.caseNumber,
        instKey: EditPatientScreen.instituteKey,
        patientObjectId: EditPatientScreen.patientObjectId,
        doctorObjectId: Backend.user.objectId,
        bodyWeight: pageStorage?.bodyWeight,
        ezpICU: pageStorage?.dischargeTime,
        birthDate: pageStorage?.birthDate,
        gender: pageStorage?.gender,
        bmi: pageStorage?.bodyMassIndex,
        idealBMI: pageStorage?.idealBodyWeight,
        azpICU: pageStorage?.admissionTime,
        ventilationDays: pageStorage?.ventilationDays,
        azpKH: pageStorage?.admissionTimeToTheHospital,
        ezpKH: pageStorage?.dischargeTimeFromTheHospital,
        icd10Codes: pageStorage?.icd10Codes,
        station: pageStorage?.patientLocation,
        lbgt70: pageStorage?.lungProtectiveVentilation70,
        wdaICU: pageStorage?.readmissionRateToTheICU,
        icuLengthStay: pageStorage?.icuLengthOfStay,
        khLengthStay: pageStorage?.hospitalLengthOfStay,
      );
    } else {
      movementData = createMovementData();
    }

    return _catalogOfItemsElement!.copyWith(
      icuDiagnosis: icud,
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
      movementData: movementData,
    );
  }

  ICUDiagnosis createICUDiagnosis() {
    return ICUDiagnosis(
      mainDiagnosis: pageStorage?.mainDiagnosis,
      ancillaryDiagnosis: pageStorage?.ancillaryDiagnosis,
      intensiveCareUnitAcquiredWeakness:
          pageStorage?.intensiveCareUnitAcquiredWeakness,
      postIntensiveCareSyndrome: pageStorage?.postIntensiveCareSyndrome,
      doctorObjectId: Backend.user.objectId!,
      patientObjectId: EditPatientScreen.patientObjectId!,
    );
  }

  VitalSignsObject createVitalSignsObject(int objectNumber) {
    if (objectNumber == 1) {
      return VitalSignsObject(
        heartRate: pageStorage?.heartRate1,
        systolicArterialPressure: pageStorage?.systolicArterialPressure1,
        meanArterialPressure: pageStorage?.meanArterialPressure1,
        diastolicArterialPressure: pageStorage?.diastolicArterialPressure1,
        centralVenousPressure: pageStorage?.centralVenousPressure1,
      );
    } else {
      return VitalSignsObject(
        heartRate: pageStorage?.heartRate2,
        systolicArterialPressure: pageStorage?.systolicArterialPressure2,
        meanArterialPressure: pageStorage?.meanArterialPressure2,
        diastolicArterialPressure: pageStorage?.diastolicArterialPressure2,
        centralVenousPressure: pageStorage?.centralVenousPressure2,
      );
    }
  }

  VitalSigns createVitalSigns(
    VitalSignsObject? value1,
    VitalSignsObject? value2,
  ) {
    return VitalSigns(
      doctorObjectId: Backend.user.objectId!,
      value1: value1,
      value2: value2,
      patientObjectId: EditPatientScreen.patientObjectId!,
    );
  }

  RespiratoryParametersObject createRespiratoryParametersObject(
    double? tidalVolume,
    double? respiratoryRate,
    double? oxygenSaturation,
  ) {
    return RespiratoryParametersObject(
      tidalVolume: tidalVolume,
      respiratoryRate: respiratoryRate,
      oxygenSaturation: oxygenSaturation,
    );
  }

  RespiratoryParameters createRespiratoryParameters(
    RespiratoryParametersObject? value1,
    RespiratoryParametersObject? value2,
  ) {
    return RespiratoryParameters(
      doctorObjectId: Backend.user.objectId!,
      value1: value1,
      value2: value2,
      patientObjectId: EditPatientScreen.patientObjectId!,
    );
  }

  BloodGasAnalysisObject createBloodGasAnalysisObject(int objectNumber) {
    if (objectNumber == 1) {
      return BloodGasAnalysisObject(
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
    } else {
      return BloodGasAnalysisObject(
        arterialOxygenSaturation: pageStorage?.arterialOxygenSaturation2,
        centralVenousOxygenSaturation:
            pageStorage?.centralVenousOxygenSaturation2,
        partialPressureOfOxygen: pageStorage?.partialPressureOfOxygen2,
        partialPressureOfCarbonDioxide:
            pageStorage?.partialPressureOfCarbonDioxide2,
        arterialBaseExcess: pageStorage?.arterialBaseExcess2,
        arterialPH: pageStorage?.arterialPH2,
        arterialSerumBicarbonateConcentration:
            pageStorage?.arterialSerumBicarbonateConcentration2,
        arterialLactate: pageStorage?.arterialLactate2,
        bloodGlucoseLevel: pageStorage?.bloodGlucoseLevel2,
      );
    }
  }

  BloodGasAnalysis createBloodGasAnalysis(
    BloodGasAnalysisObject? value1,
    BloodGasAnalysisObject? value2,
  ) {
    return BloodGasAnalysis(
      doctorObjectId: Backend.user.objectId!,
      value1: value1,
      value2: value2,
      patientObjectId: EditPatientScreen.patientObjectId!,
    );
  }

  LaborParameters createLaborParameters() {
    return LaborParameters(
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
      internationalNormalizedRatio: pageStorage?.internationalNormalizedRatio,
      partialThromboplastinTime: pageStorage?.partialThromboplastinTime,
    );
  }

  PatientData createMovementData() {
    return PatientData(
      bodyHeight: pageStorage?.bodyHeight,
      patientID: pageStorage?.patientID,
      caseNumber: pageStorage?.caseNumber,
      instKey: EditPatientScreen.instituteKey,
      patientObjectId: EditPatientScreen.patientObjectId!,
      doctorObjectId: Backend.user.objectId!,
      bodyWeight: pageStorage?.bodyWeight,
      ezpICU: pageStorage?.dischargeTime,
      birthDate: pageStorage?.birthDate,
      gender: pageStorage?.gender,
      bmi: pageStorage?.bodyMassIndex,
      idealBMI: pageStorage?.idealBodyWeight,
      azpICU: pageStorage?.admissionTime,
      ventilationDays: pageStorage?.ventilationDays,
      azpKH: pageStorage?.admissionTimeToTheHospital,
      ezpKH: pageStorage?.dischargeTimeFromTheHospital,
      icd10Codes: pageStorage?.icd10Codes,
      station: pageStorage?.patientLocation,
      lbgt70: pageStorage?.lungProtectiveVentilation70,
      wdaICU: pageStorage?.readmissionRateToTheICU,
      icuLengthStay: pageStorage?.icuLengthOfStay,
      khLengthStay: pageStorage?.hospitalLengthOfStay,
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchCOI();
  }

  Future<CatalogOfItemsElement?> _fetchCOI() async {
    _catalogOfItemsElement = await BackendCatalogOfItemsApi.getObject();

    setState(() {
      isLoading = false;
      if (_catalogOfItemsElement != null && pageStorage == null) {
        pageStorage = CatalogOfItemsPageStorage(
          context: context,
          catalogOfItemsElement: _catalogOfItemsElement,
        );
        pages = pageStorage!.pages;
        nextPageCallback = _nextPageCallback;
      }
      // When the DB is empty
      else {
        pageStorage = CatalogOfItemsPageStorage(context: context);
      }
    });

    return _catalogOfItemsElement;
  }

  @override
  Widget build(BuildContext context) {
    GlobalTheme? theme = Theme.of(context).extension<GlobalTheme>()!;
    buildContext = context;
    int lastPage = pages.length - 1;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return PicosScreenFrame(
        title: 'Catalog of items',
        body: Form(
          child: PageView(
            controller: controller,
            onPageChanged: (int num) {
              setState(() {
                _currentPage = num;
              });
            },
            children: pages,
          ),
        ),
        bottomNavigationBar: PicosAddButtonBar(
          leftButton: PicosInkWellButton(
            text: AppLocalizations.of(context)!.back,
            onTap: previousPage,
            buttonColor1: theme.grey3,
            buttonColor2: theme.grey1,
          ),
          rightButton: PicosInkWellButton(
            onTap: nextPage,
            text: _currentPage == lastPage
                ? AppLocalizations.of(context)!.save
                : AppLocalizations.of(context)!.next,
          ),
        ),
      );
    }
  }
}
