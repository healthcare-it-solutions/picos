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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/models/medication.dart';
import 'package:picos/screens/add_medication_screen/add_medication_screen_label.dart';
import 'package:picos/widgets/picos_ink_well_button.dart';
import 'package:picos/widgets/picos_select.dart';

import '../../repository/medications_repository.dart';
import '../../state/medications_list_bloc.dart';
import '../../widgets/picos_body.dart';
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
                _morning = MedicationsRepository.amountToDouble(value);
                break;
              case 'noon':
                _noon = MedicationsRepository.amountToDouble(value);
                break;
              case 'evening':
                _evening = MedicationsRepository.amountToDouble(value);
                break;
              case 'night':
                _night = MedicationsRepository.amountToDouble(value);
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

      _morningHint += ' ${MedicationsRepository.amountToString(_morning)}';
      _noonHint += ' ${MedicationsRepository.amountToString(_noon)}';
      _eveningHint += ' ${MedicationsRepository.amountToString(_evening)}';
      _nightHint += ' ${MedicationsRepository.amountToString(_night)}';

      _disabledCompoundSelect = true;
      _compoundAutoFocus = false;
    }

    const Color infoTextFontColor = Colors.white;
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

    String addText = AppLocalizations.of(context)!.enterCompound;

    if (!_addDisabled) {
      addText = AppLocalizations.of(context)!.add;
    }

    if (!_addDisabled && medicationEdit != null) {
      addText = AppLocalizations.of(context)!.save;
    }

    return BlocBuilder<MedicationsListBloc, MedicationsListState>(
      builder: (BuildContext context, MedicationsListState state) {
        return Container(
          color: Theme.of(context).appBarTheme.backgroundColor,
          child: SafeArea(
            child: Scaffold(
              bottomNavigationBar: PicosInkWellButton(
                disabled: _addDisabled,
                text: addText,
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
                      morning: _morning,
                      noon: _noon,
                      evening: _evening,
                      night: _night,
                    );
                  }

                  context
                      .read<MedicationsListBloc>()
                      .add(SaveMedication(medication));
                  Navigator.of(context).pop();
                },
              ),
              appBar: AppBar(
                centerTitle: true,
                title: Text(_title!),
                elevation: 0,
              ),
              body: PicosBody(
                child: Column(
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      color: Theme.of(context).dialogBackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(
                                right: 15,
                              ),
                              child: Icon(Icons.info, color: infoTextFontColor),
                            ),
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .addMedicationInfoPart1,
                                  style: const TextStyle(
                                    color: infoTextFontColor,
                                    fontSize: 20,
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
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    AddMedicationScreenLabel(
                      label: AppLocalizations.of(context)!.compound,
                    ),
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
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AddMedicationScreenLabel(
                      label: AppLocalizations.of(context)!.intake,
                    ),
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
            ),
          ),
        );
      },
    );
  }
}
