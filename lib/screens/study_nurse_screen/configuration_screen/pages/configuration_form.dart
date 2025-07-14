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
import 'package:picos/gen_l10n/app_localizations.dart';
import 'package:picos/themes/global_theme.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_text_area.dart';
import 'package:picos/widgets/picos_text_field.dart';

import '../../../../widgets/picos_form_of_address.dart';

/// Shows form for patient registration.
class ConfigurationForm extends StatefulWidget {
  /// Constructor of form for patient registration.
  const ConfigurationForm({
    required this.callbackForm,
    required this.initialForm,
    Key? key,
  }) : super(key: key);

  /// Callback function for form.
  final Function(String, String) callbackForm;

  /// Starting values for form.
  final Map<String, String> initialForm;

  @override
  State<ConfigurationForm> createState() => _ConfigurationFormState();
}

class _ConfigurationFormState extends State<ConfigurationForm> {
  late String _entryFormOfAddress = widget.initialForm['entryFormOfAddress']!;
  late String _entryFirstName = widget.initialForm['entryFirstName']!;
  late String _entryFamilyName = widget.initialForm['entryFamilyName']!;
  late String _entryNumber = widget.initialForm['entryNumber']!;
  late String _entryAddress = widget.initialForm['entryAddress']!;
  late String _entryEmail = widget.initialForm['entryEmail']!;

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return PicosBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PicosLabel(AppLocalizations.of(context)!.title),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: RadioListTile<String>(
                  title: Text(
                    AppLocalizations.of(context)!.mrs,
                  ),
                  value: FormOfAddress.female.toString(),
                  groupValue: _entryFormOfAddress,
                  onChanged: (String? value) {
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
                  enableFeedback: true,
                  activeColor: theme.grey1,
                ),
              ),
              Flexible(
                child: RadioListTile<String>(
                  title: Text(
                    AppLocalizations.of(context)!.mr,
                  ),
                  value: FormOfAddress.male.toString(),
                  groupValue: _entryFormOfAddress,
                  onChanged: (String? value) {
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
                  activeColor: theme.grey1,
                ),
              ),
              Flexible(
                child: RadioListTile<String>(
                  title: Text(
                    AppLocalizations.of(context)!.diverse,
                  ),
                  value: FormOfAddress.diverse.toString(),
                  groupValue: _entryFormOfAddress,
                  onChanged: (String? value) {
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
                  activeColor: theme.grey1,
                ),
              ),
            ],
          ),
          PicosLabel(AppLocalizations.of(context)!.firstName),
          PicosTextField(
            initialValue: _entryFirstName,
            hint: AppLocalizations.of(context)!.firstName,
            keyboardType: TextInputType.name,
            onChanged: (String? newValue) {
              setState(() {
                widget.callbackForm('entryFirstName', newValue!);
                _entryFirstName = newValue;
              });
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.entryFirstName;
              }
              return null;
            },
          ),
          PicosLabel(AppLocalizations.of(context)!.familyName),
          PicosTextField(
            initialValue: _entryFamilyName,
            hint: AppLocalizations.of(context)!.familyName,
            keyboardType: TextInputType.name,
            onChanged: (String? newValue) {
              setState(() {
                widget.callbackForm('entryFamilyName', newValue!);
                _entryFamilyName = newValue;
              });
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.entryFamilyName;
              }
              return null;
            },
          ),
          PicosLabel(AppLocalizations.of(context)!.email),
          PicosTextField(
            initialValue: _entryEmail,
            hint: AppLocalizations.of(context)!.email,
            keyboardType: TextInputType.emailAddress,
            onChanged: (String? newValue) {
              setState(() {
                widget.callbackForm('entryEmail', newValue!);
                _entryEmail = newValue;
              });
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.entryEmail;
              } else if (!RegExp(
                '.+@.+',
              ).hasMatch(value)) {
                return AppLocalizations.of(context)!.entryValidEmail;
              } else {
                return null;
              }
            },
          ),
          PicosLabel(AppLocalizations.of(context)!.phoneNumber),
          PicosTextField(
            initialValue: _entryNumber,
            hint: AppLocalizations.of(context)!.phoneNumber,
            keyboardType: TextInputType.phone,
            onChanged: (String? newValue) {
              setState(() {
                widget.callbackForm('entryNumber', newValue!);
                _entryNumber = newValue;
              });
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.entryPhoneNumber;
              }
              return null;
            },
          ),
          PicosLabel(AppLocalizations.of(context)!.address),
          PicosTextArea(
            initialValue: _entryAddress,
            hint: AppLocalizations.of(context)!.address,
            onChanged: (String? newValue) {
              setState(() {
                widget.callbackForm('entryAddress', newValue!);
                _entryAddress = newValue;
              });
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
