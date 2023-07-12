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
import 'package:picos/widgets/picos_date_picker.dart';
import 'package:picos/widgets/picos_form_of_address.dart';
import 'package:picos/widgets/picos_number_field.dart';
import 'package:picos/widgets/picos_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/widgets/picos_text_area.dart';
import 'package:picos/widgets/picos_text_field.dart';

import '../catalog_of_items_page.dart';
import '../widgets/catalog_of_items_label.dart';

/// Shows the patients' movement data.
class MovementData extends StatefulWidget {
  /// Creates MovementData.
  const MovementData({
    required this.ageCallback,
    required this.genderCallback,
    required this.bodyWeightCallback,
    required this.bodyHeightCallback,
    required this.bodyMassIndexCallback,
    required this.idealBodyWeightCallback,
    required this.patientIDCallback,
    required this.caseNumberCallback,
    required this.reasonForDischargeCallback,
    required this.admissionTimeICUCallback,
    required this.dischargeTimeICUCallback,
    required this.ventilationDaysICUCallback,
    required this.admissionTimeHospitalCallback,
    required this.dischargeTimeHospitalCallback,
    required this.icd10COdesCallback,
    required this.patientLocationCallback,
    required this.lungProtectiveVentilationGt70pCallback,
    required this.icuMortalityCallback,
    required this.hospitalMortalityCallback,
    required this.hospitalLengthOfStayCallback,
    required this.icuLengthOfStayCallback,
    required this.readmissionRateICUCallback,
    required this.hospitalReadmissionCallback,
    required this.daysUntilWorkReuptakeCallback,
    Key? key,
    this.initialAge,
    this.initialGender,
    this.initialBodyWeight,
    this.initialBodyHeight,
    this.initialBodyMassIndex,
    this.initialIdealBodyWeight,
    this.initialPatientID,
    this.initialCaseNumber,
    this.initialReasonForDischarge,
    this.initialAdmissionTime,
    this.initialDischargeTime,
    this.initialVentilationDays,
    this.initialAdmissionTimeToTheHospital,
    this.initialDischargeTimeFromTheHospital,
    this.initialICD10Codes,
    this.initialPatientLocation,
    this.initialICUMortality,
    this.initialHospitalMortality,
    this.initialHospitaalLengthOfStay,
    this.initialICULengthOfStay,
    this.initialReadmissionRateToTheICU,
    this.initialHospitalReadmission,
    this.initialDaysUntilWorkReuptake,
  }) : super(key: key);

  /// Main diagnosis callback.
  final void Function(int? value) ageCallback;

  /// Progress diagnosis callback.
  final void Function(FormOfAddress? value) genderCallback;

  /// ICUAW callback.
  final void Function(double? value) bodyWeightCallback;

  /// PICS callback.
  final void Function(double? value) bodyHeightCallback;

  /// Co-morbidity callback.
  final void Function(double? value) bodyMassIndexCallback;

  /// Ideal Body Weight callback.
  final void Function(double? value) idealBodyWeightCallback;

  /// Patient ID callback.
  final void Function(String? value) patientIDCallback;

  /// Case Number callback.
  final void Function(String? value) caseNumberCallback;

  /// Reason for Discharge callback.
  final void Function(String? value) reasonForDischargeCallback;

  /// Admission Time for ICU callback.
  final void Function(DateTime? value) admissionTimeICUCallback;

  /// Discharge Time for ICU callback.
  final void Function(DateTime? value) dischargeTimeICUCallback;

  /// Ventilation Days in ICU callback.
  final void Function(int? value) ventilationDaysICUCallback;

  /// Admission Time for Hospital callback.
  final void Function(DateTime? value) admissionTimeHospitalCallback;

  /// Discharge Time for Hospital callback.
  final void Function(DateTime? value) dischargeTimeHospitalCallback;

  /// ICD-10 Codes callback.
  final void Function(String? value) icd10COdesCallback;

  /// Patient Location callback.
  final void Function(String? value) patientLocationCallback;

  /// Lung Protective Ventilation > 70 % callback.
  final void Function(bool? value) lungProtectiveVentilationGt70pCallback;

  /// ICU Mortality callback.
  final void Function(double? value) icuMortalityCallback;

  /// Hospital Mortality callback.
  final void Function(double? value) hospitalMortalityCallback;

  /// Hospital Length of Stay Callback.
  final void Function(int? value) hospitalLengthOfStayCallback;

  /// ICU Length of Stay Callback.
  final void Function(int? value) icuLengthOfStayCallback;

  /// Readmission Rate of ICU callback.
  final void Function(double? value) readmissionRateICUCallback;

  /// Hospital Readmission callback.
  final void Function(double? value) hospitalReadmissionCallback;

  /// Days until Work Reuptake callback.
  final void Function(int? value) daysUntilWorkReuptakeCallback;

  /// Starting value for Age.
  final int? initialAge;

  /// Starting value for Gender.
  final FormOfAddress? initialGender;

  /// Starting value for Body Weight.
  final double? initialBodyWeight;

  /// Starting value for Height.
  final double? initialBodyHeight;

  /// Starting value for Body Mass Index.
  final double? initialBodyMassIndex;

  /// Starting value for idealBodyWeight.
  final double? initialIdealBodyWeight;

  /// Starting value for Patient ID
  final String? initialPatientID;

  /// Starting value for Case Number.
  final String? initialCaseNumber;

  /// Starting value for Reason for Discharge.
  final String? initialReasonForDischarge;

  /// Starting value for Admission Time.
  final DateTime? initialAdmissionTime;

  /// Starting value for Discharge Time.
  final DateTime? initialDischargeTime;

  /// Starting value for Ventilation Days.
  final double? initialVentilationDays;

  /// Starting value for Admission Time to the Hospital.
  final DateTime? initialAdmissionTimeToTheHospital;

  /// Starting value for Discharge Time from the Hospital.
  final DateTime? initialDischargeTimeFromTheHospital;

  /// Starting value for ICD-10 Codes.
  final String? initialICD10Codes;

  /// Starting value for Patient Location.
  final String? initialPatientLocation;

  /// Starting value for ICU Mortality.
  final double? initialICUMortality;

  /// Starting value for Hospital Mortality.
  final double? initialHospitalMortality;

  /// Starting value for Hospital Length of Stay.
  final double? initialHospitaalLengthOfStay;

  /// Starting value for ICU Length of Stay.
  final double? initialICULengthOfStay;

  /// Starting value for Readmission Rate to the ICU.
  final double? initialReadmissionRateToTheICU;

  /// Starting value for Hospital Readmission.
  final int? initialHospitalReadmission;

  /// Starting value for Days until Work Reuptake.
  final double? initialDaysUntilWorkReuptake;

  @override
  State<MovementData> createState() => _MovementDataState();
}

class _MovementDataState extends State<MovementData> {
  final bool lungProtectiveVentilation70p = false;

  @override
  Widget build(BuildContext context) {
    const int textAreaLines = 3;

    const String cm = 'cm';
    const String kgm2 = 'kg/m2';
    const String kg = 'kg';
    const String percent = '%';
    String nYear = 'n/${AppLocalizations.of(context)!.year}';

    return CatalogOfItemsPage(
      title: AppLocalizations.of(context)!.patientsMovementData,
      children: <Widget>[
        Column(
          children: <Widget>[
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.age,
            ),
            PicosNumberField(
              hint: AppLocalizations.of(context)!.years,
              digitsOnly: true,
              onChanged: (String value) {
                widget.ageCallback(int.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.gender,
            ),
            PicosFormOfAddress(
              callBackFunction: (FormOfAddress value) {
                widget.genderCallback(value);
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.weight,
            ),
            PicosNumberField(
              hint: kg,
              onChanged: (String value) {
                widget.bodyWeightCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.height),
            PicosNumberField(
              hint: cm,
              digitsOnly: true,
              onChanged: (String value) {
                widget.bodyHeightCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.bmi),
            PicosNumberField(
              hint: kgm2,
              onChanged: (String value) {
                widget.bodyMassIndexCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.idealBodyWeight,
            ),
            PicosNumberField(
              hint: kg,
              onChanged: (String value) {
                widget.idealBodyWeightCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.patientID),
            PicosTextArea(
              maxLines: textAreaLines,
              onChanged: (String value) {
                widget.patientIDCallback(value);
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.caseNumber),
            PicosTextArea(
              maxLines: textAreaLines,
              onChanged: (String value) {
                widget.caseNumberCallback(value);
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.reasonForDischarge,
            ),
            PicosTextArea(
              maxLines: textAreaLines,
              onChanged: (String value) {
                widget.reasonForDischargeCallback(value);
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.admissionTimeICU,
            ),
            PicosDatePicker(
              callBackFunction: (DateTime value) {
                widget.admissionTimeICUCallback(value);
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.dischargeTimeICU,
            ),
            PicosDatePicker(
              callBackFunction: (DateTime value) {
                widget.dischargeTimeICUCallback(value);
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.ventilationDaysICU,
            ),
            PicosNumberField(
              hint: AppLocalizations.of(context)!.days,
              onChanged: (String value) {
                widget.ventilationDaysICUCallback(int.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.admissionTimeHospital,
            ),
            PicosDatePicker(
              callBackFunction: (DateTime value) {},
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.dischargeTimeHospital,
            ),
            PicosDatePicker(
              callBackFunction: (DateTime value) {},
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.icd10Codes),
            PicosTextField(
              hint: 'ICD-10 Codes',
              onChanged: (String value) {
                widget.icd10COdesCallback(value);
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.patientLocation,
            ),
            PicosTextArea(
              maxLines: textAreaLines,
              onChanged: (String value) {
                widget.patientLocationCallback(value);
              },
            ),
          ],
        ),
        Row(
          children: <Expanded>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: CatalogOfItemsLabel(
                  AppLocalizations.of(context)!.lungProtectiveVentilation70p,
                ),
              ),
            ),
            Expanded(
              child: PicosSwitch(
                initialValue: lungProtectiveVentilation70p,
                onChanged: (bool value) {
                  setState(
                    () {
                      widget.lungProtectiveVentilationGt70pCallback(
                        value,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            CatalogOfItemsLabel(AppLocalizations.of(context)!.icuMortality),
            PicosNumberField(
              hint: percent,
              onChanged: (String value) {
                widget.icuMortalityCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.hospitalMortality,
            ),
            PicosNumberField(
              hint: percent,
              onChanged: (String value) {
                widget.hospitalMortalityCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.hospitalLengthOfStay,
            ),
            PicosNumberField(
              hint: AppLocalizations.of(context)!.days,
              onChanged: (String value) {
                widget.hospitalLengthOfStayCallback(int.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.icuLengthOfStay,
            ),
            PicosNumberField(
              hint: AppLocalizations.of(context)!.days,
              onChanged: (String value) {
                widget.icuLengthOfStayCallback(int.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.readmissionRateICU,
            ),
            PicosNumberField(
              hint: percent,
              onChanged: (String value) {
                widget.readmissionRateICUCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.hospitalReadmission,
            ),
            PicosNumberField(
              hint: nYear,
              onChanged: (String value) {
                widget.readmissionRateICUCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.daysUntilWorkReuptake,
            ),
            PicosNumberField(
              hint: AppLocalizations.of(context)!.days,
              onChanged: (String value) {
                widget.daysUntilWorkReuptakeCallback(int.tryParse(value));
              },
            ),
          ],
        ),
      ],
    );
  }
}
