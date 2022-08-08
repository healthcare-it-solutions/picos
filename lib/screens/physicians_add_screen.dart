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
import 'package:picos/util/persistance/validators.dart';
import 'package:picos/widgets/picos_add_button_bar.dart';
import 'package:email_validator/email_validator.dart';

/// contains the gender of the corresponding physician
enum Gender {
  /// element for denoting the title of men
  male,
  /// element for denoting the title of women
  female,
}

/// This is the screen in which a user can add/edit
/// information about his physicians
class PhysiciansAdd extends StatefulWidget {
  /// PhysiciansAdd constructor
  const PhysiciansAdd({Key? key}) : super(key: key);

  @override
  State<PhysiciansAdd> createState() => _PhysiciansAddState();
}

class _PhysiciansAddState extends State<PhysiciansAdd> {
  Gender? _gender = Gender.male;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String dropDownValue = AppLocalizations.of(context)!.familyDoctor;

    Validators validators = Validators(context: context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addPhysician),
        backgroundColor: const Color.fromRGBO(
          25,
          102,
          117,
          1.0,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.chooseField,
                ),
                isExpanded: true,
                value: dropDownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      dropDownValue = newValue!;
                    },
                  );
                },
                items: <String>[
                  AppLocalizations.of(context)!.familyDoctor,
                  AppLocalizations.of(context)!.cardiologist,
                  AppLocalizations.of(context)!.nephrologist,
                  AppLocalizations.of(context)!.neurologist,
                ].map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.local_hospital),
                  labelText: '${AppLocalizations.of(context)!.practiceName} *',
                ),
                keyboardType: TextInputType.name,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.entryPracticeName;
                  }
                  return null;
                },
              ),
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
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(
                          () {
                            _gender = value;
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
                      value: Gender.female,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(
                          () {
                            _gender = value;
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
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.entryFirstName;
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: '${AppLocalizations.of(context)!.familyName} *',
                ),
                keyboardType: TextInputType.name,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.entryFamilyName;
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.email),
                  labelText: '${AppLocalizations.of(context)!.email} *',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.entryEmail;
                  } else {
                    return EmailValidator.validate(value)
                        ? 'Valid'
                        : AppLocalizations.of(context)!.entryValidEmail;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.numbers),
                  labelText: '${AppLocalizations.of(context)!.phoneNumber} *',
                ),
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.entryPhoneNumber;
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.web),
                  labelText: '${AppLocalizations.of(context)!.website} *',
                  prefix: const Text('https://'), 
                ),
                keyboardType: TextInputType.url,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.entryWebsite;
                  } else {
                    return validators.validateURL('https://$value');
                  }
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
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.entryAddress;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PicosAddButtonBar(
        formKey: _formKey,
      ),
    );
  }
}
