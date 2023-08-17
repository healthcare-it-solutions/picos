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
import 'package:picos/util/backend.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_ink_well_button.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:picos/widgets/picos_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/patient.dart';

/// This is the screen for the user's profile information.
class ProfileScreen extends StatefulWidget {
  /// Constructor for Profile Screen.
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Patient? _patient;
  final String _form = 'Form';
  final String _firstName = 'Firstname';
  final String _lastName = 'Lastname';
  final String _eMail = 'email';
  final String _phoneNumber = 'PhoneNo';
  final String _address = 'Address';
  final String _objectId = 'objectId';

  String errorMessage = '';
  String successMessage = '';

  TextEditingController addressController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController newPassword = TextEditingController(text: '');
  TextEditingController newPasswordRepeat = TextEditingController(text: '');

  bool disabled = false;

  bool _isStrongPassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  Future<void> _changePassword() async {
    ParseUser currentUser = Backend.user;

    if (newPassword.text.isEmpty || newPasswordRepeat.text.isEmpty) {
      _setErrorMessage(AppLocalizations.of(context)!.allFieldsMustbeFilled);
      return;
    }

    if (newPassword.text != newPasswordRepeat.text) {
      _setErrorMessage(
        AppLocalizations.of(context)!.passwordMismatchErrorMessage,
      );
      return;
    }

    if (!_isStrongPassword(newPassword.text)) {
      _setErrorMessage(AppLocalizations.of(context)!.strongPassword);
      return;
    }

    currentUser.password = newPassword.text;
    setState(() {
      disabled = true;
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
    } else {
      _setErrorMessage(
        AppLocalizations.of(context)!.passwordSavedFailureMessage,
      );
    }
  }

  void _setErrorMessage(String message) {
    setState(() {
      errorMessage = message;
      successMessage = '';
      disabled = false;
    });
  }

  void _setSuccessMessage(String message) {
    setState(() {
      successMessage = message;
      errorMessage = '';
      disabled = false;
    });
  }

  Future<void> _updatePatient(Map<String, dynamic> changes) async {
    if (_patient == null) {
      _setErrorMessage(
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
        AppLocalizations.of(context)!.updateFailed,
      );
    } else {
      _setSuccessMessage(
        AppLocalizations.of(context)!.updateSuccess,
      );

      _patient = Patient(
        firstName: changes[_firstName] ?? _patient!.firstName,
        familyName: changes[_lastName] ?? _patient!.familyName,
        email: changes[_eMail] ?? _patient!.email,
        number: changes[_phoneNumber] ?? _patient!.number,
        address: changes[_address] ?? _patient!.address,
        formOfAddress: _patient!.formOfAddress,
        objectId: _patient!.objectId,
        createdAt: _patient!.createdAt,
        updatedAt: DateTime.now(),
      );
      PatientCache().patient = _patient;
    }
  }

  Future<void> _updateField(String fieldName, String newValue) async {
    await _updatePatient(<String, dynamic>{fieldName: newValue});
  }

  Future<void> _fetchPatient() async {
    if (PatientCache().patient != null) {
      _patient = PatientCache().patient;
    } else {
      if (Backend.user.objectId != null) {
        ParseResponse responsePatient = await Backend.getEntry(
          Patient.databaseTable,
          _objectId,
          Backend.user.objectId!,
        );

        dynamic element = responsePatient.results?.first;
        if (element != null) {
          _patient = Patient(
            firstName: element[_firstName] ?? '',
            familyName: element[_lastName] ?? '',
            email: element[_eMail] ?? '',
            number: element[_phoneNumber] ?? '',
            address: element[_address] ?? '',
            formOfAddress: element[_form] ?? '',
            objectId: element[_objectId],
            createdAt: element['createdAt'],
            updatedAt: element['updatedAt'],
          );
          PatientCache().patient = _patient;
        }
      }
    }

    addressController.text = _patient?.address ?? '';
    firstNameController.text = _patient?.firstName ?? '';
    lastNameController.text = _patient?.familyName ?? '';
    phoneController.text = _patient?.number ?? '';
    emailController.text = _patient?.email ?? '';
  }

  @override
  void initState() {
    super.initState();
    _fetchPatient();
  }

  @override
  Widget build(BuildContext context) {
    if (_patient == null) {
      return const CircularProgressIndicator();
    }
    return PicosScreenFrame(
      title: AppLocalizations.of(context)!.myProfile,
      body: PicosBody(
        child: Column(
          children: <Widget>[
            PicosLabel(AppLocalizations.of(context)!.firstName),
            PicosTextField(controller: firstNameController),
            PicosInkWellButton(
              text: AppLocalizations.of(context)!.changeFirstname,
              disabled: disabled,
              onTap: () => _updateField(_firstName, firstNameController.text),
            ),
            PicosLabel(AppLocalizations.of(context)!.familyName),
            PicosTextField(controller: lastNameController),
            PicosInkWellButton(
              text: AppLocalizations.of(context)!.changeLastname,
              disabled: disabled,
              onTap: () => _updateField(_lastName, lastNameController.text),
            ),
            PicosLabel(AppLocalizations.of(context)!.email),
            PicosTextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
            ),
            PicosInkWellButton(
              text: AppLocalizations.of(context)!.changeEmail,
              disabled: disabled,
              onTap: () => _updateField(_eMail, emailController.text),
            ),
            PicosLabel(AppLocalizations.of(context)!.phoneNumber),
            PicosTextField(
              keyboardType: TextInputType.phone,
              controller: phoneController,
            ),
            PicosInkWellButton(
              text: AppLocalizations.of(context)!.changePhoneNumber,
              disabled: disabled,
              onTap: () => _updateField(_phoneNumber, phoneController.text),
            ),
            PicosLabel(AppLocalizations.of(context)!.address),
            PicosTextField(controller: addressController),
            PicosInkWellButton(
              text: AppLocalizations.of(context)!.changeAddress,
              disabled: disabled,
              onTap: () => _updateField(_address, addressController.text),
            ),
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
              disabled: disabled,
              onTap: _changePassword,
            ),
            errorMessage.isNotEmpty
                ? Text(
                    errorMessage,
                    style: const TextStyle(color: Color(0xFFe63329)),
                  )
                : successMessage.isNotEmpty
                    ? Text(
                        successMessage,
                        style: const TextStyle(color: Colors.lightGreen),
                      )
                    : const Text(' '),
          ],
        ),
      ),
    );
  }
}

/// A singleton class to cache the patient data.
class PatientCache {
  // Private constructor to prevent direct instantiation from outside.
  PatientCache._internal();

  /// Factory constructor that returns the singleton instance of PatientCache.
  factory PatientCache() {
    return _singleton;
  }

  // The singleton instance of the PatientCache.
  static final PatientCache _singleton = PatientCache._internal();

  /// The cached patient data.
  Patient? patient;
}
