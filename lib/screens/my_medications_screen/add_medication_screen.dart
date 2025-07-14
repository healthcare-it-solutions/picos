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
import 'package:picos/gen_l10n/app_localizations.dart';
import 'package:picos/api/backend_medications_api.dart';
import 'package:picos/models/medication.dart';
import 'package:picos/widgets/picos_add_button_bar.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:picos/widgets/picos_select.dart';

import '../../state/objects_list_bloc.dart';
import '../../widgets/picos_body.dart';
import '../../widgets/picos_info_card.dart';
import '../../widgets/picos_label.dart';
import '../../widgets/picos_text_field.dart';

/// A screen for adding new medication schedules.
class AddMedicationScreen extends StatefulWidget {
  /// Creates the AddMedicationScreen.
  const AddMedicationScreen({Key? key}) : super(key: key);

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  /// The amount to take in the morning.
  double _morning = 0;

  /// The amount to take in the noon.
  double _noon = 0;

  /// The amount to take in the evening.
  double _evening = 0;

  /// The amount to take before night.
  double _night = 0;

  /// The amount to take in the morning (check value).
  double _morningOld = 0;

  /// The amount to take in the noon (check value).
  double _noonOld = 0;

  /// The amount to take in the evening (check value).
  double _eveningOld = 0;

  /// The amount to take before night (check value).
  double _nightOld = 0;

  /// The compound to be taken.
  String? _compound;
  Medication? _medicationEdit;
  String? _title;
  String? _compoundHint;
  late String _morningHint;
  late String _noonHint;
  late String _eveningHint;
  late String _nightHint;
  bool _disabledCompoundSelect = false;
  bool _compoundAutoFocus = true;

  /// Determines if you are able to add the medication.
  bool _addDisabled = true;

  Expanded _createAmountSelect(
    EdgeInsets padding,
    String hint,
    String medicationTime,
  ) {
    return Expanded(
      child: Padding(
        padding: padding,
        child: PicosSelect(
          selection: Medication.selection,
          hint: hint,
          callBackFunction: (String value) {
            //Since mirrors are disabled or prohibited in Flutter.
            switch (medicationTime) {
              case 'morning':
                _morning = Medication.amountToDouble(value);
                break;
              case 'noon':
                _noon = Medication.amountToDouble(value);
                break;
              case 'evening':
                _evening = Medication.amountToDouble(value);
                break;
              case 'night':
                _night = Medication.amountToDouble(value);
                break;
            }

            checkSelectValues();
          },
        ),
      ),
    );
  }

  void checkSelectValues() {
    if (_medicationEdit == null) {
      return;
    }

    setState(() {
      if (_morning == _morningOld &&
          _noon == _noonOld &&
          _evening == _eveningOld &&
          _night == _nightOld) {
        _addDisabled = true;
        return;
      }

      _addDisabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Init variables.
    if (_title == null) {
      _title = AppLocalizations.of(context)!.addMedication;
      _compoundHint = AppLocalizations.of(context)!.enterCompound;
      _morningHint = AppLocalizations.of(context)!.inTheMorning;
      _noonHint = AppLocalizations.of(context)!.noon;
      _eveningHint = AppLocalizations.of(context)!.inTheEvening;
      _nightHint = AppLocalizations.of(context)!.toTheNight;
    }

    Object? medicationEdit = ModalRoute.of(context)!.settings.arguments;

    //Initialize medicationEdit if the medication is to be edited.
    if (_medicationEdit == null && medicationEdit != null) {
      _medicationEdit = medicationEdit as Medication;

      _morning = _medicationEdit!.morning;
      _noon = _medicationEdit!.noon;
      _evening = _medicationEdit!.evening;
      _night = _medicationEdit!.night;
      _compound = _medicationEdit!.compound;
      _morningOld = _medicationEdit!.morning;
      _noonOld = _medicationEdit!.noon;
      _eveningOld = _medicationEdit!.evening;
      _nightOld = _medicationEdit!.night;

      _title = AppLocalizations.of(context)!.editMedication;
      _compoundHint = _compound;

      _morningHint += ' ${Medication.amountToString(_morning)}';
      _noonHint += ' ${Medication.amountToString(_noon)}';
      _eveningHint += ' ${Medication.amountToString(_evening)}';
      _nightHint += ' ${Medication.amountToString(_night)}';

      _disabledCompoundSelect = false;
      _compoundAutoFocus = false;
    }

    const EdgeInsets selectPaddingRight = EdgeInsets.only(
      bottom: 5,
      right: 5,
      top: 5,
    );
    const EdgeInsets selectPaddingLeft = EdgeInsets.only(
      bottom: 5,
      left: 5,
      top: 5,
    );

    return BlocBuilder<ObjectsListBloc<BackendMedicationsApi>,
        ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        return PicosScreenFrame(
          body: PicosBody(
            child: Column(
              children: <Widget>[
                PicosInfoCard(
                  infoText: RichText(
                    text: TextSpan(
                      text:
                          AppLocalizations.of(context)!.addMedicationInfoPart1,
                      style: const TextStyle(
                        color: PicosInfoCard.infoTextFontColor,
                        fontSize: PicosInfoCard.infoTextFontSize,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: AppLocalizations.of(context)!
                              .addMedicationInfoPart2,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!
                              .addMedicationInfoPart3,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                PicosLabel(AppLocalizations.of(context)!.compound),
                PicosTextField(
                  onChanged: (String value) {
                    _compound = value;

                    setState(() {
                      if (value.isNotEmpty) {
                        _addDisabled = false;
                        return;
                      }

                      _addDisabled = true;
                    });
                  },
                  disabled: _disabledCompoundSelect,
                  autofocus: _compoundAutoFocus,
                  hint: _compoundHint!,
                  initialValue: _compound,
                ),
                const SizedBox(
                  height: 30,
                ),
                PicosLabel(AppLocalizations.of(context)!.intake),
                Row(
                  children: <Expanded>[
                    _createAmountSelect(
                      selectPaddingRight,
                      _morningHint,
                      'morning',
                    ),
                    _createAmountSelect(
                      selectPaddingLeft,
                      _noonHint,
                      'noon',
                    ),
                  ],
                ),
                Row(
                  children: <Expanded>[
                    _createAmountSelect(
                      selectPaddingRight,
                      _eveningHint,
                      'evening',
                    ),
                    _createAmountSelect(
                      selectPaddingLeft,
                      _nightHint,
                      'night',
                    ),
                  ],
                ),
              ],
            ),
          ),
          title: _title,
          bottomNavigationBar: PicosAddButtonBar(
            disabled: _addDisabled,
            onTap: () {
              Medication medication = _medicationEdit ??
                  Medication(
                    compound: _compound!,
                    morning: _morning,
                    noon: _noon,
                    evening: _evening,
                    night: _night,
                  );

              if (_medicationEdit != null) {
                medication = medication.copyWith(
                  compound: _compound!,
                  morning: _morning,
                  noon: _noon,
                  evening: _evening,
                  night: _night,
                );
              }

              context
                  .read<ObjectsListBloc<BackendMedicationsApi>>()
                  .add(SaveObject(medication));
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}
