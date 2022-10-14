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
import 'package:queen_validators/queen_validators.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${AppLocalizations.of(context)!.title} *',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: RadioListTile<FormOfAddress>(
                    title: Text(
                      AppLocalizations.of(context)!.mr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
                    selected: false,
                  ),
                ),
                Expanded(
                  child: RadioListTile<FormOfAddress>(
                    title: Text(
                      AppLocalizations.of(context)!.mrs,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
                    selected: false,
                  ),
                ),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: const Icon(Icons.person),
                labelText: '${AppLocalizations.of(context)!.firstName} *',
              ),
              keyboardType: TextInputType.name,
              validator: qValidator(
                <TextValidationRule>[
                  IsRequired(AppLocalizations.of(context)!.entryFirstName),
                ],
              ),
              onChanged: (String? newValue) {
                widget.callbackForm('entryFirstName', newValue!);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: const Icon(Icons.person),
                labelText: '${AppLocalizations.of(context)!.familyName} *',
              ),
              keyboardType: TextInputType.name,
              validator: qValidator(
                <TextValidationRule>[
                  IsRequired(AppLocalizations.of(context)!.entryFamilyName),
                ],
              ),
              onChanged: (String? newValue) {
                widget.callbackForm('entryFamilyName', newValue!);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: const Icon(Icons.email),
                labelText: '${AppLocalizations.of(context)!.email} *',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: qValidator(
                <TextValidationRule>[
                  IsRequired(AppLocalizations.of(context)!.entryEmail),
                  IsEmail(AppLocalizations.of(context)!.entryValidEmail),
                ],
              ),
              onChanged: (String? newValue) {
                widget.callbackForm('entryEmail', newValue!);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: const Icon(Icons.numbers),
                labelText: '${AppLocalizations.of(context)!.phoneNumber} *',
              ),
              keyboardType: TextInputType.number,
              validator: qValidator(
                <TextValidationRule>[
                  IsRequired(AppLocalizations.of(context)!.entryPhoneNumber),
                ],
              ),
              onChanged: (String? newValue) {
                widget.callbackForm('entryNumber', newValue!);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: const Icon(Icons.house),
                labelText: '${AppLocalizations.of(context)!.address} *',
              ),
              keyboardType: TextInputType.multiline,
              minLines: 2,
              maxLines: null,
              validator: qValidator(
                <TextValidationRule>[
                  IsRequired(AppLocalizations.of(context)!.entryAddress),
                ],
              ),
              onChanged: (String? newValue) {
                widget.callbackForm('entryAddress', newValue!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
