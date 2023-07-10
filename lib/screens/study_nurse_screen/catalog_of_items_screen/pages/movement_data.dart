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
    required this.heightCallback,
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
    this.age,
    this.gender,
    this.bodyWeight,
    this.height,
    this.bodyMassIndex,
    this.idealBodyWeight,
    this.patientIDs,
    this.caseNumber,
    this.reasonForDischarge,
    this.admissionTime,
    this.dischargeTime,
    this.ventilationDays,
    this.admissionTimeToTheHospital,
    this.dischargeTimeFromTheHospital,
    this.icd10Codes,
    this.patientLocation,
    this.icuMortality,
    this.hospitalMortality,
    this.hospitaalLengthOfStay,
    this.icuLengthOfStay,
    this.readmissionRateToTheICU,
    this.hospitalReadmission,
    this.daysUntilWorkReuptake,
  }) : super(key: key);

  /// Main diagnosis callback.
  final void Function(int? value) ageCallback;

  /// Progress diagnosis callback.
  final void Function(FormOfAddress? value) genderCallback;

  /// ICUAW callback.
  final void Function(double? value) bodyWeightCallback;

  /// PICS callback.
  final void Function(double? value) heightCallback;

  /// Co-morbidity callback.
  final void Function(double? value) bodyMassIndexCallback;

  final void Function(double? value) idealBodyWeightCallback;

  final void Function(String? value) patientIDCallback;

  final void Function(String? value) caseNumberCallback;

  final void Function(String? value) reasonForDischargeCallback;

  final void Function(DateTime? value) admissionTimeICUCallback;

  final void Function(DateTime? value) dischargeTimeICUCallback;

  final void Function(int? value) ventilationDaysICUCallback;

  final void Function(DateTime? value) admissionTimeHospitalCallback;

  final void Function(DateTime? value) dischargeTimeHospitalCallback;

  final void Function(String? value) icd10COdesCallback;

  final void Function(String? value) patientLocationCallback;

  final void Function(bool? value) lungProtectiveVentilationGt70pCallback;

  final void Function(double? value) icuMortalityCallback;

  final void Function(double? value) hospitalMortalityCallback;

  final void Function(int? value) hospitalLengthOfStayCallback;

  final void Function(int? value) icuLengthOfStayCallback;

  final void Function(double? value) readmissionRateICUCallback;

  final void Function(double? value) hospitalReadmissionCallback;

  final void Function(int? value) daysUntilWorkReuptakeCallback;

  final int? age;

  final FormOfAddress? gender;

  final double? bodyWeight;

  final double? height;

  final double? bodyMassIndex;

  final double? idealBodyWeight;

  final String? patientIDs;

  final String? caseNumber;

  final String? reasonForDischarge;

  final DateTime? admissionTime;

  final DateTime? dischargeTime;

  final double? ventilationDays;

  final DateTime? admissionTimeToTheHospital;

  final DateTime? dischargeTimeFromTheHospital;

  final String? icd10Codes;

  final String? patientLocation;

  final double? icuMortality;

  final double? hospitalMortality;

  final double? hospitaalLengthOfStay;

  final double? icuLengthOfStay;

  final double? readmissionRateToTheICU;

  final int? hospitalReadmission;

  final double? daysUntilWorkReuptake;

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
      padding: EdgeInsets.zero,
      title: AppLocalizations.of(context)!.patientsMovementData,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
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
                  widget.heightCallback(double.tryParse(value));
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
        ),
        PicosSwitch(
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
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
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
        )
      ],
    );
  }
}
