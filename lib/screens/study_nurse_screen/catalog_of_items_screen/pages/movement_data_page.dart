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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:picos/widgets/picos_date_picker.dart';
import 'package:picos/widgets/picos_number_field.dart';
import 'package:picos/widgets/picos_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/widgets/picos_text_area.dart';

import '../catalog_of_items_page.dart';
import '../widgets/catalog_of_items_label.dart';

/// Shows the patients' movement data.
class MovementDataPage extends StatefulWidget {
  /// Creates MovementData.
  const MovementDataPage({
    required this.birthDateCallback,
    required this.genderCallback,
    required this.bodyWeightCallback,
    required this.bodyHeightCallback,
    required this.bodyMassIndexCallback,
    required this.idealBodyWeightCallback,
    required this.patientIDCallback,
    required this.caseNumberCallback,
    required this.admissionTimeICUCallback,
    required this.dischargeTimeICUCallback,
    required this.ventilationDaysICUCallback,
    required this.admissionTimeHospitalCallback,
    required this.dischargeTimeHospitalCallback,
    required this.icd10COdesCallback,
    required this.patientLocationCallback,
    required this.lungProtectiveVentilationGt70pCallback,
    required this.hospitalLengthOfStayCallback,
    required this.icuLengthOfStayCallback,
    required this.readmissionRateICUCallback,
    Key? key,
    this.initialBirthDate,
    this.initialGender,
    this.initialBodyWeight,
    this.initialBodyHeight,
    this.initialBodyMassIndex,
    this.initialIdealBodyWeight,
    this.initialPatientID,
    this.initialCaseNumber,
    this.initialAdmissionTime,
    this.initialDischargeTime,
    this.initialVentilationDays,
    this.initialAdmissionTimeToTheHospital,
    this.initialDischargeTimeFromTheHospital,
    this.initialICD10Codes,
    this.initialPatientLocation,
    this.initialHospitalLengthOfStay,
    this.initialICULengthOfStay,
    this.initialReadmissionRateToTheICU,
    this.initialLungProtectiveVentilation70p,
  }) : super(key: key);

  /// Birthdate Callback.
  final void Function(DateTime? value) birthDateCallback;

  /// Progress diagnosis callback.
  final void Function(String? value) genderCallback;

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
  final void Function(List<dynamic>? value) icd10COdesCallback;

  /// Patient Location callback.
  final void Function(String? value) patientLocationCallback;

  /// Lung Protective Ventilation > 70 % callback.
  final void Function(bool? value) lungProtectiveVentilationGt70pCallback;

  /// Hospital Length of Stay Callback.
  final void Function(int? value) hospitalLengthOfStayCallback;

  /// ICU Length of Stay Callback.
  final void Function(int? value) icuLengthOfStayCallback;

  /// Readmission Rate of ICU callback.
  final void Function(bool? value) readmissionRateICUCallback;

  /// Starting value for Age.
  final DateTime? initialBirthDate;

  /// Starting value for Gender.
  final String? initialGender;

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

  /// Starting value for Admission Time.
  final DateTime? initialAdmissionTime;

  /// Starting value for Discharge Time.
  final DateTime? initialDischargeTime;

  /// Starting value for Ventilation Days.
  final int? initialVentilationDays;

  /// Starting value for Admission Time to the Hospital.
  final DateTime? initialAdmissionTimeToTheHospital;

  /// Starting value for Discharge Time from the Hospital.
  final DateTime? initialDischargeTimeFromTheHospital;

  /// Starting value for ICD-10 Codes.
  final List<dynamic>? initialICD10Codes;

  /// Starting value for Patient Location.
  final String? initialPatientLocation;

  /// Starting value for Hospital Length of Stay.
  final int? initialHospitalLengthOfStay;

  /// Starting value for ICU Length of Stay.
  final int? initialICULengthOfStay;

  /// Starting value for Readmission Rate to the ICU.
  final bool? initialReadmissionRateToTheICU;

  /// Starting value for Lung Protective Ventilation.
  final bool? initialLungProtectiveVentilation70p;

  @override
  State<MovementDataPage> createState() => _MovementDataPageState();
}

class _MovementDataPageState extends State<MovementDataPage> {
  DateTime? _selectedBirthDate;
  DateTime? _selectedAdmissionTime;
  DateTime? _selectedDischargeTime;
  DateTime? _selectedAdmissionTimeToTheHospital;
  DateTime? _selectedDischargeTimeFromTheHospital;

  double bmi = 0;
  int bodyHeight = 0;
  double bodyWeight = 0;

  @override
  void initState() {
    super.initState();
    _selectedBirthDate = widget.initialBirthDate;
    _selectedAdmissionTime = widget.initialAdmissionTime;
    _selectedDischargeTime = widget.initialDischargeTime;
    _selectedAdmissionTimeToTheHospital =
        widget.initialAdmissionTimeToTheHospital;
    _selectedDischargeTimeFromTheHospital =
        widget.initialDischargeTimeFromTheHospital;

    if (widget.initialBodyHeight != null && widget.initialBodyWeight != null) {
      bodyHeight = widget.initialBodyHeight!.toInt();
      bodyWeight = widget.initialBodyWeight ?? 0;

      if (widget.initialBodyHeight != null) {
        bodyHeight = widget.initialBodyHeight!.toInt();
      } else {
        bodyHeight = 0;
      }

      bodyWeight = widget.initialBodyWeight ?? 0;

      if (bodyWeight != 0 && bodyHeight != 0) {
        bmi = _calculateBmi(bodyHeight, bodyWeight);
      } else {
        bmi = 0;
      }
    }
  }

  double _calculateBmi(int height, double bodyWeight) {
    return (bodyWeight / pow(height / 100, 2));
  }

  @override
  Widget build(BuildContext context) {
    const String cm = 'cm';
    const int textAreaLines = 3;
    const String kg = 'kg';
    const ShapeBorder roundedRectangleBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
    );
    return CatalogOfItemsPage(
      title: AppLocalizations.of(context)!.patientsMovementData,
      children: <Widget>[
        Column(
          children: <Widget>[
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.birthDate,
            ),
            PicosDatePicker(
              callBackFunction: (DateTime value) {
                widget.birthDateCallback(value);
                setState(() {
                  _selectedBirthDate = value;
                });
              },
              initialValue: _selectedBirthDate,
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.gender,
            ),
            PicosTextArea(
              maxLines: textAreaLines,
              initialValue: widget.initialGender?.toString(),
              onChanged: (String value) {
                widget.genderCallback(value);
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.weight,
            ),
            PicosNumberField(
              hint: kg,
              initialValue: widget.initialBodyWeight?.toString(),
              onChanged: (String value) {
                widget.bodyWeightCallback(double.tryParse(value));

                setState(() {
                  bodyWeight = double.tryParse(value) ?? 0;

                  if (bodyWeight != 0 && bodyHeight != 0) {
                    bmi = _calculateBmi(bodyHeight, bodyWeight);
                  } else {
                    bmi = 0;
                  }
                });
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.height),
            PicosNumberField(
              hint: cm,
              initialValue: widget.initialBodyHeight?.toString(),
              digitsOnly: true,
              onChanged: (String value) {
                widget.bodyHeightCallback(double.tryParse(value));

                setState(() {
                  bodyHeight = int.tryParse(value) ?? 0;

                  if (bodyWeight != 0 && bodyHeight != 0) {
                    bmi = _calculateBmi(bodyHeight, bodyWeight);
                  } else {
                    bmi = 0;
                  }
                });
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.bmi),
            Text(
              bmi.toString(),
              textAlign: TextAlign.left,
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.patientID),
            PicosTextArea(
              maxLines: textAreaLines,
              initialValue: widget.initialPatientID,
              onChanged: (String value) {
                widget.patientIDCallback(value);
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.caseNumber),
            PicosTextArea(
              maxLines: textAreaLines,
              initialValue: widget.initialCaseNumber,
              onChanged: (String value) {
                widget.caseNumberCallback(value);
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.idealBodyWeight,
            ),
            PicosNumberField(
              hint: kg,
              initialValue: widget.initialIdealBodyWeight?.toString(),
              onChanged: (String value) {
                widget.idealBodyWeightCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.admissionTimeICU,
            ),
            PicosDatePicker(
              callBackFunction: (DateTime value) {
                widget.admissionTimeICUCallback(value);
                setState(() {
                  _selectedAdmissionTime = value;
                });
              },
              initialValue: _selectedAdmissionTime,
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.dischargeTimeICU,
            ),
            PicosDatePicker(
              callBackFunction: (DateTime value) {
                widget.dischargeTimeICUCallback(value);
                setState(() {
                  _selectedDischargeTime = value;
                });
              },
              initialValue: _selectedDischargeTime,
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.ventilationDaysICU,
            ),
            PicosNumberField(
              hint: AppLocalizations.of(context)!.days,
              onChanged: (String value) {
                widget.ventilationDaysICUCallback(int.tryParse(value));
              },
              initialValue: widget.initialVentilationDays?.toString(),
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.admissionTimeHospital,
            ),
            PicosDatePicker(
              callBackFunction: (DateTime value) {
                widget.admissionTimeHospitalCallback(value);
                setState(() {
                  _selectedAdmissionTimeToTheHospital = value;
                });
              },
              initialValue: _selectedAdmissionTimeToTheHospital,
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.dischargeTimeHospital,
            ),
            PicosDatePicker(
              callBackFunction: (DateTime value) {
                widget.dischargeTimeHospitalCallback(value);
                setState(() {
                  _selectedDischargeTimeFromTheHospital = value;
                });
              },
              initialValue: _selectedDischargeTimeFromTheHospital,
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.icd10Codes),
            PicosTextArea(
              hint: 'ICD-10 Codes',
              initialValue: widget.initialICD10Codes?[0].toString(),
              onChanged: (String value) {
                List<dynamic> list = <dynamic>[];
                list.add(value);
                widget.icd10COdesCallback(list);
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.patientLocation,
            ),
            PicosTextArea(
              maxLines: textAreaLines,
              initialValue: widget.initialPatientLocation,
              onChanged: (String value) {
                widget.patientLocationCallback(value);
              },
            ),
          ],
        ),
        Row(
          children: <Expanded>[
            Expanded(
              child: CatalogOfItemsLabel(
                AppLocalizations.of(context)!.lungProtectiveVentilation70p,
              ),
            ),
            Expanded(
              child: PicosSwitch(
                initialValue: widget.initialLungProtectiveVentilation70p,
                onChanged: (bool? value) {
                  widget.lungProtectiveVentilationGt70pCallback(value);
                },
                shape: roundedRectangleBorder,
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.hospitalLengthOfStay,
            ),
            PicosNumberField(
              hint: AppLocalizations.of(context)!.days,
              initialValue: widget.initialHospitalLengthOfStay?.toString(),
              onChanged: (String value) {
                widget.hospitalLengthOfStayCallback(int.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.icuLengthOfStay,
            ),
            PicosNumberField(
              hint: AppLocalizations.of(context)!.days,
              initialValue: widget.initialICULengthOfStay?.toString(),
              onChanged: (String value) {
                widget.icuLengthOfStayCallback(int.tryParse(value));
              },
            ),
            PicosSwitch(
              initialValue: widget.initialReadmissionRateToTheICU,
              onChanged: (bool? value) {
                widget.readmissionRateICUCallback(value);
              },
              title: AppLocalizations.of(context)!.readmissionRateICU,
              shape: roundedRectangleBorder,
            ),
          ],
        ),
      ],
    );
  }
}
