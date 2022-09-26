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
import 'package:queen_validators/queen_validators.dart';

import 'package:picos/util/backend_data.dart';

/// Shows form for patient registration.
class ConfigurationForm extends StatefulWidget {
  /// Constructor of form for patient registration.
  const ConfigurationForm({Key? key}) : super(key: key);

  @override
  State<ConfigurationForm> createState() => _ConfigurationFormState();
}

class _ConfigurationFormState extends State<ConfigurationForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                child: RadioListTile<Gender>(
                  title: Text(
                    AppLocalizations.of(context)!.mr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  value: Gender.male,
                  groupValue: PersonalData.gender,
                  onChanged: (Gender? value) {
                    setState(
                      () {
                        PersonalData.gender = value!;
                      },
                    );
                  },
                  selected: false,
                ),
              ),
              Expanded(
                child: RadioListTile<Gender>(
                  title: Text(
                    AppLocalizations.of(context)!.mrs,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  value: PersonalData.gender,
                  groupValue: PersonalData.gender,
                  onChanged: (Gender? value) {
                    setState(
                      () {
                        PersonalData.gender = value!;
                      },
                    );
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
              setState(
                () {
                  PersonalData.firstName = newValue!;
                },
              );
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
              setState(
                () {
                  PersonalData.familyName = newValue!;
                },
              );
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
              setState(
                () {
                  PersonalData.email = newValue!;
                },
              );
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
              setState(
                () {
                  PersonalData.number = newValue!;
                },
              );
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
              setState(
                () {
                  PersonalData.address = newValue!;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
