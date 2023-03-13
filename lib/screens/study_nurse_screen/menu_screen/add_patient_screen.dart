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
import 'package:picos/api/backend_medications_api.dart';
import 'package:picos/models/patient.dart';
import 'package:picos/state/objects_list_bloc.dart';
import 'package:picos/widgets/picos_add_button_bar.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_info_card.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:picos/widgets/picos_text_field.dart';

/// A screen for adding new medication schedules.
class AddPatientScreen extends StatefulWidget {
  /// Creates the AddMedicationScreen.
  const AddPatientScreen({Key? key}) : super(key: key);

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  /// The denotation for the first name.
  late String _firstName;

  /// The denotation for the last name.
  late String _lastName;

  /// The denotation for the form of address.
  late String _formOfAddress;

  /// The denotation for phone number.
  late String _number;

  /// The denotation for email.
  late String _email;

  /// The denotation for address.
  late String _address;

  /// Determines if you are able to add the medication.
  bool _addDisabled = true;

  final String _title = 'Edit patient';

  Patient? _patientEdit;

  @override
  Widget build(BuildContext context) {
    //Object? patientEdit = ModalRoute.of(context)!.settings.arguments;

    //Initialize medicationEdit if the medication is to be edited.
    /*if (_patientEdit == null && patientEdit != null) {
      _patientEdit = patientEdit as Patient;

      _morning = _patientEdit!.morning;
      _noon = _patientEdit!.noon;
      _evening = _patientEdit!.evening;
      _night = _patientEdit!.night;
      _compound = _patientEdit!.compound;
      _morningOld = _patientEdit!.morning;
      _noonOld = _patientEdit!.noon;
      _eveningOld = _patientEdit!.evening;
      _nightOld = _patientEdit!.night;

      _title = AppLocalizations.of(context)!.editMedication;
      _compoundHint = _compound;

      _morningHint += ' ${Patient.amountToString(_morning)}';
      _noonHint += ' ${Patient.amountToString(_noon)}';
      _eveningHint += ' ${Patient.amountToString(_evening)}';
      _nightHint += ' ${Patient.amountToString(_night)}';

      _disabledCompoundSelect = false;
      _compoundAutoFocus = false;
    }*/

    /*const EdgeInsets selectPaddingRight = EdgeInsets.only(
      bottom: 5,
      right: 5,
      top: 5,
    );
    const EdgeInsets selectPaddingLeft = EdgeInsets.only(
      bottom: 5,
      left: 5,
      top: 5,
    );*/

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
                PicosLabel(AppLocalizations.of(context)!.firstName),
                PicosTextField(
                  onChanged: (String value) {
                    _firstName = value;

                    setState(() {
                      if (value.isNotEmpty) {
                        _addDisabled = false;
                        return;
                      }

                      _addDisabled = true;
                    });
                  },
                  hint: _firstName,
                  initialValue: _firstName,
                ),
                const SizedBox(
                  height: 25,
                ),
                PicosLabel(AppLocalizations.of(context)!.familyName),
                PicosTextField(
                  onChanged: (String value) {
                    _lastName = value;

                    setState(() {
                      if (value.isNotEmpty) {
                        _addDisabled = false;
                        return;
                      }

                      _addDisabled = true;
                    });
                  },
                  hint: _lastName,
                  initialValue: _lastName,
                ),
                const SizedBox(
                  height: 25,
                ),
                PicosLabel(AppLocalizations.of(context)!.email),
                PicosTextField(
                  onChanged: (String value) {
                    _email = value;

                    setState(() {
                      if (value.isNotEmpty) {
                        _addDisabled = false;
                        return;
                      }

                      _addDisabled = true;
                    });
                  },
                  hint: _email,
                  initialValue: _email,
                ),
                const SizedBox(
                  height: 25,
                ),
                PicosLabel(AppLocalizations.of(context)!.phoneNumber),
                PicosTextField(
                  onChanged: (String value) {
                    _number = value;

                    setState(() {
                      if (value.isNotEmpty) {
                        _addDisabled = false;
                        return;
                      }

                      _addDisabled = true;
                    });
                  },
                  hint: _number,
                  initialValue: _number,
                ),
                const SizedBox(
                  height: 25,
                ),
                PicosLabel(AppLocalizations.of(context)!.address),
                PicosTextField(
                  onChanged: (String value) {
                    _address = value;

                    setState(() {
                      if (value.isNotEmpty) {
                        _addDisabled = false;
                        return;
                      }

                      _addDisabled = true;
                    });
                  },
                  hint: _address,
                  initialValue: _address,
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          title: _title,
          bottomNavigationBar: PicosAddButtonBar(
            disabled: _addDisabled,
            onTap: () {
              Patient patient = _patientEdit ??
                  Patient(
                    formOfAddress: _formOfAddress,
                    firstName: _firstName,
                    familyName: _lastName,
                    email: _email,
                    number: _number,
                    address: _address,
                  );

              if (_patientEdit != null) {
                patient = patient.copyWith(
                  formOfAddress: _formOfAddress,
                  firstName: _firstName,
                  familyName: _lastName,
                  email: _email,
                  number: _number,
                  address: _address,
                );
              }

              context
                  .read<ObjectsListBloc<BackendMedicationsApi>>()
                  .add(SaveObject(patient));
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}
