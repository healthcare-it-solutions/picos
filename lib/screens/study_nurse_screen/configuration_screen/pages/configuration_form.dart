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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/models/patient.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_text_area.dart';
import 'package:picos/widgets/picos_text_field.dart';

/// Shows form for patient registration.
class ConfigurationForm extends StatefulWidget {
  /// Constructor of form for patient registration.
  const ConfigurationForm({required this.callbackForm, Key? key})
      : super(key: key);

  /// Callback function for form.
  final Function(String, String) callbackForm;

  @override
  State<ConfigurationForm> createState() => _ConfigurationFormState();
}

class _ConfigurationFormState extends State<ConfigurationForm> {
  /// Local variable for form of address.
  FormOfAddress _entryFormOfAddress = FormOfAddress.female;

  @override
  void initState() {
    setState(() {
      widget.callbackForm('entryFormOfAddress', _entryFormOfAddress.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PicosBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PicosLabel(label: AppLocalizations.of(context)!.title),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: RadioListTile<FormOfAddress>(
                  title: Text(
                    AppLocalizations.of(context)!.mrs,
                  ),
                  value: FormOfAddress.female,
                  groupValue: _entryFormOfAddress,
                  onChanged: (FormOfAddress? value) {
                    setState(() {
                      widget.callbackForm(
                        'entryFormOfAddress',
                        FormOfAddress.female.toString(),
                      );
                      _entryFormOfAddress = value!;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                  selected: false,
                ),
              ),
              Flexible(
                child: RadioListTile<FormOfAddress>(
                  title: Text(
                    AppLocalizations.of(context)!.mr,
                  ),
                  value: FormOfAddress.male,
                  groupValue: _entryFormOfAddress,
                  onChanged: (FormOfAddress? value) {
                    setState(() {
                      widget.callbackForm(
                        'entryFormOfAddress',
                        FormOfAddress.male.toString(),
                      );
                      _entryFormOfAddress = value!;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                  selected: false,
                ),
              ),
              Flexible(
                child: RadioListTile<FormOfAddress>(
                  title: Text(
                    AppLocalizations.of(context)!.diverse,
                  ),
                  value: FormOfAddress.diverse,
                  groupValue: _entryFormOfAddress,
                  onChanged: (FormOfAddress? value) {
                    setState(() {
                      widget.callbackForm(
                        'entryFormOfAddress',
                        FormOfAddress.diverse.toString(),
                      );
                      _entryFormOfAddress = value!;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                  selected: false,
                ),
              ),
            ],
          ),
          PicosLabel(label: AppLocalizations.of(context)!.firstName),
          PicosTextField(
            hint: AppLocalizations.of(context)!.firstName,
            keyboardType: TextInputType.name,
            onChanged: (String? newValue) {
              widget.callbackForm('entryFirstName', newValue!);
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.entryFirstName;
              }
              return null;
            },
          ),
          PicosLabel(label: AppLocalizations.of(context)!.familyName),
          PicosTextField(
            hint: AppLocalizations.of(context)!.familyName,
            keyboardType: TextInputType.name,
            onChanged: (String? newValue) {
              widget.callbackForm('entryFamilyName', newValue!);
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.entryFamilyName;
              }
              return null;
            },
          ),
          PicosLabel(label: AppLocalizations.of(context)!.email),
          PicosTextField(
            hint: AppLocalizations.of(context)!.email,
            keyboardType: TextInputType.emailAddress,
            onChanged: (String? newValue) {
              widget.callbackForm('entryEmail', newValue!);
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.entryEmail;
              } else if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
              ).hasMatch(value)) {
                return AppLocalizations.of(context)!.entryValidEmail;
              } else {
                return null;
              }
            },
          ),
          PicosLabel(label: AppLocalizations.of(context)!.phoneNumber),
          PicosTextField(
            hint: AppLocalizations.of(context)!.phoneNumber,
            keyboardType: TextInputType.phone,
            onChanged: (String? newValue) {
              widget.callbackForm('entryNumber', newValue!);
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.entryPhoneNumber;
              }
              return null;
            },
          ),
          PicosLabel(label: AppLocalizations.of(context)!.address),
          PicosTextArea(
            hint: AppLocalizations.of(context)!.address,
            onChanged: (String? newValue) {
              widget.callbackForm('entryAddress', newValue!);
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.entryAddress;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
