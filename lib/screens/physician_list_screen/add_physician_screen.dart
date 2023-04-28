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
import 'package:picos/models/physician.dart';
import 'package:picos/state/objects_list_bloc.dart';
import 'package:picos/widgets/picos_add_button_bar.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:picos/widgets/picos_text_field.dart';

import '../../widgets/picos_body.dart';
import '../../widgets/picos_select.dart';

/// This is the screen in which a user can add/edit
/// information about his physicians
class AddPhysicianScreen extends StatefulWidget {
  /// PhysiciansAdd constructor
  const AddPhysicianScreen({Key? key}) : super(key: key);

  @override
  State<AddPhysicianScreen> createState() => _AddPhysicianScreenState();
}

class _AddPhysicianScreenState extends State<AddPhysicianScreen> {
  static final Map<String, String> _selection = <String, String>{};
  static String? _specialty;
  static String? _practice;
  static String? _firstName;
  static String? _familyName;
  static String? _email;
  static String? _phoneNumber;
  static String? _address;
  static String? _streetAndHouseNo;
  static String? _zipCode;
  static String? _city;
  static String? _website;
  static String? _addPhysician;
  static String? _editPhysician;

  //State
  String? _selectedSubjectArea;
  String? _selectedFirstName;
  String? _selectedFamilyName;
  String? _selectedEmail;
  String? _selectedPhoneNumber;
  String? _selectedAddress;
  String? _selectedCity;
  String? _selectedWebsite;
  String? _selectedPractice;
  Physician? _physicianEdit;
  String? _title;

  bool _disabledSave = true;

  void _checkInputs() {
    if (_selectedSubjectArea == null ||
        _selectedFirstName == null ||
        _selectedFamilyName == null ||
        _selectedEmail == null ||
        _selectedPhoneNumber == null ||
        _selectedWebsite == null ||
        _selectedAddress == null ||
        _selectedPractice == null ||
        _selectedCity == null ||
        _selectedSubjectArea!.isEmpty ||
        _selectedFirstName!.isEmpty ||
        _selectedFamilyName!.isEmpty ||
        _selectedEmail!.isEmpty ||
        _selectedPhoneNumber!.isEmpty ||
        _selectedWebsite!.isEmpty ||
        _selectedAddress!.isEmpty ||
        _selectedPractice!.isEmpty ||
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
      _selection.addAll(<String, String>{
        PhysicianSubjectArea.otolaryngology.name:
            PhysicianSubjectArea.otolaryngology.getLocalization(context),
        PhysicianSubjectArea.gynecology.name:
            PhysicianSubjectArea.gynecology.getLocalization(context),
        PhysicianSubjectArea.otolaryngology.name:
            PhysicianSubjectArea.otolaryngology.getLocalization(context),
        PhysicianSubjectArea.generalPractitioner.name:
            PhysicianSubjectArea.generalPractitioner.getLocalization(context),
        PhysicianSubjectArea.skinAndVenerealDiseases.name: PhysicianSubjectArea
            .skinAndVenerealDiseases
            .getLocalization(context),
        PhysicianSubjectArea.internalMedicine.name:
            PhysicianSubjectArea.internalMedicine.getLocalization(context),
        PhysicianSubjectArea.microbiology.name:
            PhysicianSubjectArea.microbiology.getLocalization(context),
        PhysicianSubjectArea.neurology.name:
            PhysicianSubjectArea.neurology.getLocalization(context),
        PhysicianSubjectArea.pathology.name:
            PhysicianSubjectArea.pathology.getLocalization(context),
        PhysicianSubjectArea.pulmonology.name:
            PhysicianSubjectArea.pulmonology.getLocalization(context),
        PhysicianSubjectArea.psychiatry.name:
            PhysicianSubjectArea.psychiatry.getLocalization(context),
        PhysicianSubjectArea.urology.name:
            PhysicianSubjectArea.urology.getLocalization(context),
      });

      _specialty = AppLocalizations.of(context)!.specialty;
      _practice = AppLocalizations.of(context)!.practice;
      _firstName = AppLocalizations.of(context)!.firstName;
      _familyName = AppLocalizations.of(context)!.familyName;
      _email = AppLocalizations.of(context)!.email;
      _phoneNumber = AppLocalizations.of(context)!.phoneNumber;
      _address = AppLocalizations.of(context)!.address;
      _streetAndHouseNo = AppLocalizations.of(context)!.streetAndHouseNo;
      _zipCode = AppLocalizations.of(context)!.zipCode;
      _city = AppLocalizations.of(context)!.city;
      _title = AppLocalizations.of(context)!.title;
      _website = AppLocalizations.of(context)!.website;
      _addPhysician = AppLocalizations.of(context)!.addPhysician;
      _editPhysician = AppLocalizations.of(context)!.editPhysician;
    }

    _title = _addPhysician;
    Object? physicianEdit = ModalRoute.of(context)!.settings.arguments;

    if (_physicianEdit == null && physicianEdit != null) {
      _title = _editPhysician;
      _physicianEdit = physicianEdit as Physician;

      _selectedSubjectArea = _physicianEdit!.subjectArea;
      _selectedFirstName = _physicianEdit!.firstName;
      _selectedFamilyName = _physicianEdit!.lastName;
      _selectedEmail = _physicianEdit!.mail;
      _selectedPhoneNumber = _physicianEdit!.phone;
      _selectedAddress = _physicianEdit!.address;
      _selectedCity = _physicianEdit!.city;
      _selectedWebsite = _physicianEdit!.homepage;
      _selectedPractice = _physicianEdit!.practice;
    }

    return BlocBuilder<ObjectsListBloc<BackendPhysiciansApi>, ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        const double columnPadding = 10;

        return PicosScreenFrame(
          title: _title,
          body: PicosBody(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                PicosLabel(_practice!),
                PicosTextField(
                  hint: _practice!,
                  keyboardType: TextInputType.name,
                  initialValue: _selectedPractice,
                  onChanged: (String value) {
                    _selectedPractice = value;
                    _checkInputs();
                  },
                ),
                const SizedBox(height: columnPadding),
                PicosSelect(
                  selection: _selection,
                  callBackFunction: (String value) {
                    _selectedSubjectArea = value;
                    _checkInputs();
                  },
                  initialValue: _selectedSubjectArea,
                  hint: _specialty,
                ),
                const SizedBox(height: columnPadding),
                PicosLabel(_firstName!),
                PicosTextField(
                  hint: _firstName!,
                  keyboardType: TextInputType.name,
                  initialValue: _selectedFirstName,
                  onChanged: (String value) {
                    _selectedFirstName = value;
                    _checkInputs();
                  },
                ),
                const SizedBox(height: columnPadding),
                PicosLabel(
                  _familyName!,
                ),
                PicosTextField(
                  hint: _familyName!,
                  keyboardType: TextInputType.name,
                  initialValue: _selectedFamilyName,
                  onChanged: (String value) {
                    _selectedFamilyName = value;
                    _checkInputs();
                  },
                ),
                const SizedBox(height: columnPadding),
                PicosLabel(_email!),
                PicosTextField(
                  hint: _email!,
                  keyboardType: TextInputType.emailAddress,
                  initialValue: _selectedEmail,
                  onChanged: (String value) {
                    _selectedEmail = value;
                    _checkInputs();
                  },
                ),
                const SizedBox(height: columnPadding),
                PicosLabel(_phoneNumber!),
                PicosTextField(
                  hint: _phoneNumber!,
                  keyboardType: TextInputType.phone,
                  initialValue: _selectedPhoneNumber,
                  onChanged: (String value) {
                    _selectedPhoneNumber = value;
                    _checkInputs();
                  },
                ),
                const SizedBox(height: columnPadding),
                PicosLabel(_address!),
                PicosTextField(
                  hint: _streetAndHouseNo!,
                  keyboardType: TextInputType.streetAddress,
                  initialValue: _selectedAddress,
                  onChanged: (String value) {
                    _selectedAddress = value;
                    _checkInputs();
                  },
                ),
                const SizedBox(height: columnPadding),
                PicosLabel(_city!),
                PicosTextField(
                  hint: '${_city!}, ${_zipCode!}',
                  keyboardType: TextInputType.streetAddress,
                  initialValue: _selectedCity,
                  onChanged: (String value) {
                    _selectedCity = value;
                    _checkInputs();
                  },
                ),
                const SizedBox(height: columnPadding),
                PicosLabel(_website!),
                PicosTextField(
                  hint: _website!,
                  keyboardType: TextInputType.url,
                  initialValue: _selectedWebsite,
                  onChanged: (String value) {
                    _selectedWebsite = value;
                    _checkInputs();
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: PicosAddButtonBar(
            disabled: _disabledSave,
            onTap: () {
              Physician physician = _physicianEdit != null
                  ? _physicianEdit!.copyWith(
                      practice: _selectedPractice!,
                      address: _selectedAddress!,
                      city: _selectedCity!,
                      homepage: _selectedWebsite!,
                      lastName: _selectedFamilyName!,
                      mail: _selectedEmail!,
                      phone: _selectedPhoneNumber!,
                      subjectArea: _selectedSubjectArea!,
                      firstName: _selectedFirstName!,
                    )
                  : Physician(
                      practice: _selectedPractice!,
                      address: _selectedAddress!,
                      city: _selectedCity!,
                      homepage: _selectedWebsite!,
                      lastName: _selectedFamilyName!,
                      mail: _selectedEmail!,
                      phone: _selectedPhoneNumber!,
                      subjectArea: _selectedSubjectArea!,
                      firstName: _selectedFirstName!,
                    );

              context
                  .read<ObjectsListBloc<BackendPhysiciansApi>>()
                  .add(SaveObject(physician));
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}
