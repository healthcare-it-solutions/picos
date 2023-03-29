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
import 'package:picos/api/backend_physicians_api.dart';
import 'package:picos/state/objects_list_bloc.dart';
import 'package:picos/widgets/picos_add_button_bar.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:picos/widgets/picos_text_field.dart';

import '../../widgets/picos_body.dart';
import '../../widgets/picos_select.dart';

/// Contains the gender of the corresponding physician.
enum Gender {
  /// element for denoting the title of men
  male,

  /// element for denoting the title of women
  female,
}

/// This is the screen in which a user can add/edit
/// information about his physicians
class AddPhysicianScreen extends StatefulWidget {
  /// PhysiciansAdd constructor
  const AddPhysicianScreen({Key? key}) : super(key: key);

  @override
  State<AddPhysicianScreen> createState() => _AddPhysicianScreenState();
}

class _AddPhysicianScreenState extends State<AddPhysicianScreen> {
  static final List<String> _selection = <String>[];
  static late final String _specialty;
  static late final String _practice;
  static late final String _firstName;
  static late final String _familyName;
  static late final String _email;
  static late final String _phoneNumber;
  static late final String _mobilePhone;
  static late final String _address;
  static late final String _streetAndHouseNo;
  static late final String _zipCode;
  static late final String _city;

  //State
  String? _selectedSubjectArea;
  String? _selectedFirstName;
  String? _selectedFamilyName;
  String? _selectedEmail;
  String? _selectedPhoneNumber;
  String? _selectedMobilePhone;
  String? _selectedAddress;
  String? _selectedZipCode;
  String? _selectedCity;

  bool _disabledSave = true;

  void _checkInputs() {
    if (_selectedSubjectArea == null ||
        _selectedFirstName == null ||
        _selectedFamilyName == null ||
        _selectedEmail == null ||
        _selectedPhoneNumber == null ||
        _selectedMobilePhone == null ||
        _selectedAddress == null ||
        _selectedZipCode == null ||
        _selectedCity == null ||
        _selectedSubjectArea!.isEmpty ||
        _selectedFirstName!.isEmpty ||
        _selectedFamilyName!.isEmpty ||
        _selectedEmail!.isEmpty ||
        _selectedPhoneNumber!.isEmpty ||
        _selectedMobilePhone!.isEmpty ||
        _selectedAddress!.isEmpty ||
        _selectedZipCode!.isEmpty ||
        _selectedCity!.isEmpty) {
      setState(() {
        _disabledSave = true;
      });
      return;
    }

    setState(() {
      _disabledSave = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selection.isEmpty) {
      _selection.add(AppLocalizations.of(context)!.ophthalmology);
      _selection.add(AppLocalizations.of(context)!.gynecology);
      _selection.add(AppLocalizations.of(context)!.otolaryngology);
      _selection.add(AppLocalizations.of(context)!.generalPractitioner);
      _selection.add(AppLocalizations.of(context)!.skinAndVenerealDiseases);
      _selection.add(AppLocalizations.of(context)!.internalMedicine);
      _selection.add(AppLocalizations.of(context)!.microbiology);
      _selection.add(AppLocalizations.of(context)!.neurology);
      _selection.add(AppLocalizations.of(context)!.pathology);
      _selection.add(AppLocalizations.of(context)!.pulmonology);
      _selection.add(AppLocalizations.of(context)!.psychiatry);
      _selection.add(AppLocalizations.of(context)!.urology);

      _specialty = AppLocalizations.of(context)!.specialty;
      _practice = AppLocalizations.of(context)!.practice;
      _firstName = AppLocalizations.of(context)!.firstName;
      _familyName = AppLocalizations.of(context)!.familyName;
      _email = AppLocalizations.of(context)!.email;
      _phoneNumber = AppLocalizations.of(context)!.phoneNumber;
      _mobilePhone = AppLocalizations.of(context)!.mobilePhone;
      _address = AppLocalizations.of(context)!.address;
      _streetAndHouseNo = AppLocalizations.of(context)!.streetAndHouseNo;
      _zipCode = AppLocalizations.of(context)!.zipCode;
      _city = AppLocalizations.of(context)!.city;
    }

    return BlocBuilder<ObjectsListBloc<BackendPhysiciansApi>, ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        const double columnPadding = 10;
        const double doubleInputPadding = 15;

        return PicosScreenFrame(
          body: PicosBody(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                PicosLabel(
                  _practice,
                ),
                PicosSelect(
                  selection: _selection,
                  callBackFunction: (String value) {
                    _selectedSubjectArea = value;
                    _checkInputs();
                  },
                  hint: _selectedSubjectArea ?? _specialty,
                ),
                const SizedBox(
                  height: columnPadding,
                ),
                PicosLabel(
                  _firstName,
                ),
                PicosTextField(
                  hint: _firstName,
                  keyboardType: TextInputType.name,
                  initialValue: _selectedFirstName,
                  onChanged: (String value) {
                    _selectedFirstName = value;
                    _checkInputs();
                  },
                ),
                const SizedBox(
                  height: columnPadding,
                ),
                PicosLabel(
                  _familyName,
                ),
                PicosTextField(
                  hint: _familyName,
                  keyboardType: TextInputType.name,
                  initialValue: _selectedFamilyName,
                  onChanged: (String value) {
                    _selectedFamilyName = value;
                    _checkInputs();
                  },
                ),
                const SizedBox(
                  height: columnPadding,
                ),
                PicosLabel(
                  _email,
                ),
                PicosTextField(
                  hint: _email,
                  keyboardType: TextInputType.emailAddress,
                  initialValue: _selectedEmail,
                  onChanged: (String value) {
                    _selectedEmail = value;
                    _checkInputs();
                  },
                ),
                const SizedBox(
                  height: columnPadding,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          PicosLabel(_phoneNumber),
                          PicosTextField(
                            hint: _phoneNumber,
                            keyboardType: TextInputType.phone,
                            initialValue: _selectedPhoneNumber,
                            onChanged: (String value) {
                              _selectedPhoneNumber = value;
                              _checkInputs();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: doubleInputPadding,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          PicosLabel(_mobilePhone),
                          PicosTextField(
                            hint: _mobilePhone,
                            keyboardType: TextInputType.phone,
                            initialValue: _selectedMobilePhone,
                            onChanged: (String value) {
                              _selectedMobilePhone = value;
                              _checkInputs();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: columnPadding,
                ),
                PicosLabel(_address),
                PicosTextField(
                  hint: _streetAndHouseNo,
                  keyboardType: TextInputType.streetAddress,
                  initialValue: _selectedAddress,
                  onChanged: (String value) {
                    _selectedAddress = value;
                    _checkInputs();
                  },
                ),
                const SizedBox(
                  height: columnPadding,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: PicosTextField(
                        hint: _zipCode,
                        keyboardType: TextInputType.streetAddress,
                        initialValue: _selectedZipCode,
                        onChanged: (String value) {
                          _selectedZipCode = value;
                          _checkInputs();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: doubleInputPadding,
                    ),
                    Expanded(
                      child: PicosTextField(
                        hint: _city,
                        keyboardType: TextInputType.streetAddress,
                        initialValue: _selectedCity,
                        onChanged: (String value) {
                          _selectedCity = value;
                          _checkInputs();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: PicosAddButtonBar(
            disabled: _disabledSave,
            onTap: () {},
          ),
        );
      },
    );
  }
}
