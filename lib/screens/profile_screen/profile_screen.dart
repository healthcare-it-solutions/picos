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
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:picos/themes/global_theme.dart';
import 'package:picos/util/backend.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_ink_well_button.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:picos/widgets/picos_text_field.dart';
import 'package:picos/gen_l10n/app_localizations.dart';

import '../../models/patient.dart';
import '../../widgets/picos_form_of_address.dart';

/// This is the screen for the user's profile information.
class ProfileScreen extends StatefulWidget {
  /// Constructor for Profile Screen.
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Patient? _patient;
  static const String _password = 'password';
  static const String _form = 'Form';
  static const String _firstName = 'Firstname';
  static const String _lastName = 'Lastname';
  static const String _eMail = 'email';
  static const String _phoneNumber = 'PhoneNo';
  static const String _address = 'Address';
  static const String _bloodSugarMg = 'unitMg';
  static const String _objectId = 'objectId';

  final Map<String, String> _errorMessages = <String, String>{};
  final Map<String, String> _successMessages = <String, String>{};

  final TextEditingController addressController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController newPasswordRepeat = TextEditingController();

  bool _disabled = false;
  FormOfAddress selectedFormOfAddress = FormOfAddress.female;
  List<bool> isSelectedBloodSugarUnits = <bool>[];

  @override
  void initState() {
    _fetchPatient();
    super.initState();
  }

  bool _isStrongPassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp('[a-z]')) &&
        password.contains(RegExp('[A-Z]')) &&
        password.contains(RegExp('[!"#\$%&\'()*+,-./:;<=>?@[\\]^_`{|}~]')) &&
        password.contains(RegExp('[0-9]'));
  }

  Future<void> _changePassword() async {
    ParseUser currentUser = Backend.user;

    if (newPassword.text.isEmpty || newPasswordRepeat.text.isEmpty) {
      _setErrorMessage(
        _password,
        AppLocalizations.of(context)!.allFieldsMustbeFilled,
      );
      return;
    }

    if (newPassword.text != newPasswordRepeat.text) {
      _setErrorMessage(
        _password,
        AppLocalizations.of(context)!.passwordMismatchErrorMessage,
      );
      return;
    }

    if (!_isStrongPassword(newPassword.text)) {
      _setErrorMessage(
        _password,
        AppLocalizations.of(context)!.strongPassword,
      );
      return;
    }

    currentUser.password = newPassword.text;
    setState(() {
      _disabled = true;
    });

    ParseResponse responseSaveNewPassword = await currentUser.save();
    if (!mounted) return;
    if (responseSaveNewPassword.success) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.passwordChangeSuccessful),
            content:
                Text(AppLocalizations.of(context)!.passwordChangeLogoutMessage),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.ok),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/login-screen');
                },
              ),
            ],
          );
        },
      );
      _setSuccessMessage(
        _password,
        AppLocalizations.of(context)!.passwordChangeSuccessful,
      );
    } else {
      _setErrorMessage(
        _password,
        AppLocalizations.of(context)!.passwordSavedFailureMessage,
      );
    }
  }

  void _setMessage(Map<String, String> map, String field, String message) {
    setState(() {
      map[field] = message;
      if (map == _errorMessages) {
        _successMessages[field] = '';
      } else {
        _errorMessages[field] = '';
      }
      _disabled = false;
    });
  }

  void _setErrorMessage(String field, String message) {
    _setMessage(_errorMessages, field, message);
  }

  void _setSuccessMessage(String field, String message) {
    _setMessage(_successMessages, field, message);
  }

  Widget _getMessageText(GlobalTheme theme, String field) {
    if (_errorMessages.containsKey(field) &&
        _errorMessages[field]!.isNotEmpty) {
      return Text(
        _errorMessages[field]!,
        style: TextStyle(color: theme.red),
      );
    } else if (_successMessages.containsKey(field) &&
        _successMessages[field]!.isNotEmpty) {
      return Text(
        _successMessages[field]!,
        style: const TextStyle(color: Colors.lightGreen),
      );
    }
    return const Text(' ');
  }

  Future<void> _updatePatient(Map<String, dynamic> changes) async {
    String? changedField = changes.keys.first;
    if (_patient == null) {
      _setErrorMessage(
        changedField,
        AppLocalizations.of(context)!.unknownError,
      );
      return;
    }
    ParseResponse response = await Backend.updateEntry(
      Patient.databaseTable,
      _patient!.objectId!,
      changes,
    );

    if (!mounted) return;

    if (!response.success) {
      _setErrorMessage(
        changedField,
        AppLocalizations.of(context)!.updateFailed,
      );
    } else {
      _setSuccessMessage(
        changedField,
        AppLocalizations.of(context)!.updateSuccess,
      );

      _patient = Patient(
        firstName: changes[_firstName] ?? _patient!.firstName,
        familyName: changes[_lastName] ?? _patient!.familyName,
        email: changes[_eMail] ?? _patient!.email,
        number: changes[_phoneNumber] ?? _patient!.number,
        address: changes[_address] ?? _patient!.address,
        formOfAddress: changes[_form] ?? _patient!.formOfAddress,
        objectId: _patient!.objectId,
        createdAt: _patient!.createdAt,
        updatedAt: DateTime.now(),
      );
    }
  }

  String _getEmptyMessage(String fieldName) {
    switch (fieldName) {
      case _firstName:
        return AppLocalizations.of(context)!.entryFirstName;
      case _lastName:
        return AppLocalizations.of(context)!.entryFamilyName;
      case _eMail:
        return AppLocalizations.of(context)!.entryEmail;
      case _phoneNumber:
        return AppLocalizations.of(context)!.entryPhoneNumber;
      case _address:
        return AppLocalizations.of(context)!.entryAddress;
      default:
        return '';
    }
  }

  Future<void> _updateField(String fieldName, dynamic newValue) async {
    if (newValue.toString().isEmpty) {
      _setErrorMessage(
        fieldName,
        _getEmptyMessage(fieldName),
      );
      return;
    }
    await _updatePatient(<String, dynamic>{fieldName: newValue});
  }

  Future<void> _fetchPatient() async {
    if (Backend.user.objectId != null) {
      dynamic responsePatient = await ParseObject(Patient.databaseTable)
          .getObject(Backend.user.objectId!);

      dynamic element = responsePatient.results?.first;
      if (element != null) {
        _patient = Patient(
          firstName: element[_firstName] ?? '',
          familyName: element[_lastName] ?? '',
          email: element[_eMail] ?? '',
          number: element[_phoneNumber] ?? '',
          address: element[_address] ?? '',
          formOfAddress: element[_form] ?? selectedFormOfAddress.toString(),
          objectId: element[_objectId],
          createdAt: element['createdAt'],
          updatedAt: element['updatedAt'],
        );
        isSelectedBloodSugarUnits.add(element[_bloodSugarMg]);
        isSelectedBloodSugarUnits.add(!element[_bloodSugarMg]);
      }
    }

    setState(() {
      selectedFormOfAddress =
          _formOfAddressFromString(_patient?.formOfAddress) ??
              selectedFormOfAddress;
      addressController.text = _patient?.address ?? '';
      firstNameController.text = _patient?.firstName ?? '';
      lastNameController.text = _patient?.familyName ?? '';
      phoneController.text = _patient?.number ?? '';
      emailController.text = _patient?.email ?? '';
    });
  }

  FormOfAddress? _formOfAddressFromString(String? str) {
    switch (str) {
      case 'FormOfAddress.female':
        return FormOfAddress.female;
      case 'FormOfAddress.male':
        return FormOfAddress.male;
      case 'FormOfAddress.diverse':
        return FormOfAddress.diverse;
      default:
        return null;
    }
  }

  Widget getPadding(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    if (_patient == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return PicosScreenFrame(
      title: AppLocalizations.of(context)!.myProfile,
      body: SafeArea(
        child: PicosBody(
          child: Column(
            children: <Widget>[
              PicosLabel(AppLocalizations.of(context)!.title),
              RadioGroup<FormOfAddress>(
                groupValue: selectedFormOfAddress,
                onChanged: (FormOfAddress? newValue) {
                  selectedFormOfAddress = newValue!;
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: RadioListTile<FormOfAddress>(
                        title: Text(
                          AppLocalizations.of(context)!.mrs,
                        ),
                        value: FormOfAddress.female,
                        contentPadding: EdgeInsets.zero,
                        selected: false,
                        activeColor: theme.grey1,
                      ),
                    ),
                    Flexible(
                      child: RadioListTile<FormOfAddress>(
                        title: Text(
                          AppLocalizations.of(context)!.mr,
                        ),
                        value: FormOfAddress.male,
                        contentPadding: EdgeInsets.zero,
                        selected: false,
                        activeColor: theme.grey1,
                      ),
                    ),
                    Flexible(
                      child: RadioListTile<FormOfAddress>(
                        title: Text(
                          AppLocalizations.of(context)!.diverse,
                        ),
                        value: FormOfAddress.diverse,
                        contentPadding: EdgeInsets.zero,
                        selected: false,
                        activeColor: theme.grey1,
                      ),
                    ),
                  ],
                ),
              ),
              PicosInkWellButton(
                text: AppLocalizations.of(context)!.changeTitle,
                disabled: _disabled,
                onTap: () =>
                    _updateField(_form, selectedFormOfAddress.toString()),
              ),
              _getMessageText(theme, _form),
              PicosLabel(AppLocalizations.of(context)!.firstName),
              PicosTextField(controller: firstNameController),
              PicosInkWellButton(
                text: AppLocalizations.of(context)!.changeFirstname,
                disabled: _disabled,
                onTap: () => _updateField(_firstName, firstNameController.text),
              ),
              _getMessageText(theme, _firstName),
              PicosLabel(AppLocalizations.of(context)!.familyName),
              PicosTextField(controller: lastNameController),
              PicosInkWellButton(
                text: AppLocalizations.of(context)!.changeLastname,
                disabled: _disabled,
                onTap: () => _updateField(_lastName, lastNameController.text),
              ),
              _getMessageText(theme, _lastName),
              PicosLabel(AppLocalizations.of(context)!.email),
              PicosTextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
              PicosInkWellButton(
                text: AppLocalizations.of(context)!.changeEmail,
                disabled: _disabled,
                onTap: () => _updateField(_eMail, emailController.text),
              ),
              _getMessageText(theme, _eMail),
              PicosLabel(AppLocalizations.of(context)!.phoneNumber),
              PicosTextField(
                keyboardType: TextInputType.phone,
                controller: phoneController,
              ),
              PicosInkWellButton(
                text: AppLocalizations.of(context)!.changePhoneNumber,
                disabled: _disabled,
                onTap: () => _updateField(_phoneNumber, phoneController.text),
              ),
              _getMessageText(theme, _phoneNumber),
              PicosLabel(AppLocalizations.of(context)!.address),
              PicosTextField(controller: addressController),
              PicosInkWellButton(
                text: AppLocalizations.of(context)!.changeAddress,
                disabled: _disabled,
                onTap: () => _updateField(_address, addressController.text),
              ),
              _getMessageText(theme, _address),
              PicosLabel(AppLocalizations.of(context)!.newPassword),
              PicosTextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                controller: newPassword,
              ),
              PicosLabel(AppLocalizations.of(context)!.newPasswordRepeat),
              PicosTextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                controller: newPasswordRepeat,
              ),
              PicosInkWellButton(
                text: AppLocalizations.of(context)!.changePassword,
                disabled: _disabled,
                onTap: _changePassword,
              ),
              _getMessageText(theme, _password),
              PicosLabel(AppLocalizations.of(context)!.bloodSugarUnit),
              ToggleButtons(
                borderColor: theme.black,
                fillColor: theme.grey3,
                borderWidth: 2,
                selectedBorderColor: theme.black,
                selectedColor: theme.white,
                borderRadius: BorderRadius.circular(5),
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < isSelectedBloodSugarUnits.length; i++) {
                      isSelectedBloodSugarUnits[i] = i == index;
                    }
                  });
                },
                isSelected: isSelectedBloodSugarUnits,
                children: <Widget>[
                  getPadding('MG/DL'),
                  getPadding('MMol/L'),
                ],
              ),
              PicosInkWellButton(
                text: AppLocalizations.of(context)!.changeBloodSugarUnit,
                disabled: _disabled,
                onTap: () {
                  _updateField(_bloodSugarMg, isSelectedBloodSugarUnits[0]);
                  Backend.user.set('unitMg', isSelectedBloodSugarUnits[0]);
                },
              ),
              _getMessageText(theme, _bloodSugarMg),
            ],
          ),
        ),
      ),
    );
  }
}
