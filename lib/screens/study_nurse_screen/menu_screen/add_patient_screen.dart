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
import 'package:picos/api/backend_patient_api.dart';
import 'package:picos/models/patient.dart';
import 'package:picos/state/objects_list_bloc.dart';
import 'package:picos/widgets/picos_add_button_bar.dart';
import 'package:picos/widgets/picos_body.dart';
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
  String _firstName = '';

  /// The denotation for the last name.
  String _lastName = '';

  /// The denotation for the form of address.
  String _formOfAddress = '';

  /// The denotation for phone number.
  String _number = '';

  /// The denotation for email.
  String _email = '';

  /// The denotation for address.
  String _address = '';

  /// Determines if you are able to add the medication.
  bool _addDisabled = true;

  String? _title;

  Patient? _patientEdit;

  late String _firstNameHint;
  late String _lastNameHint;
  late String _formOfAddressHint;
  late String _numberHint;
  late String _emailHint;
  late String _addressHint;

  @override
  Widget build(BuildContext context) {
    if (_title == null) {
      _title = 'Edit Patient';
      _firstNameHint = 'Please enter the first name.';
      _lastNameHint = 'Please enter the last name.';
      _emailHint = 'Please enter the email address.';
      _numberHint = 'Please enter the phone number.';
      _addressHint = 'Please enter the address.';
      _formOfAddressHint = 'Please enter the form of Address';
    }

    Object? patientEdit = ModalRoute.of(context)!.settings.arguments;

    if (_patientEdit == null && patientEdit != null) {
      _patientEdit = patientEdit as Patient;

      _firstName = _patientEdit!.firstName!;
      _lastName = _patientEdit!.familyName!;
      _email = _patientEdit!.email;
      _number = _patientEdit!.number!;
      _address = _patientEdit!.address!;
      _formOfAddress = _patientEdit!.formOfAddress!;

      _firstNameHint = _patientEdit!.firstName!;
      _lastNameHint = _patientEdit!.familyName!;
      _emailHint = _patientEdit!.email;
      _numberHint = _patientEdit!.number!;
      _addressHint = _patientEdit!.address!;
      _formOfAddressHint = _patientEdit!.formOfAddress!;
    }

    return BlocBuilder<ObjectsListBloc<BackendMedicationsApi>,
        ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        return PicosScreenFrame(
          body: PicosBody(
            child: Column(
              children: <Widget>[
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
                  hint: _firstNameHint,
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
                  hint: _lastNameHint,
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
                  hint: _emailHint,
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
                  hint: _numberHint,
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
                  hint: _addressHint,
                  initialValue: _address,
                ),
                const SizedBox(
                  height: 25,
                ),
                PicosLabel(AppLocalizations.of(context)!.title),
                PicosTextField(
                  onChanged: (String value) {
                    _formOfAddress = value;

                    setState(() {
                      if (value.isNotEmpty) {
                        _addDisabled = false;
                        return;
                      }

                      _addDisabled = true;
                    });
                  },
                  hint: _formOfAddressHint,
                  initialValue: _formOfAddress,
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
                  .read<ObjectsListBloc<BackendPatientApi>>()
                  .add(SaveObject(patient));
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}
