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
import 'package:picos/widgets/picos_ink_well_button.dart';
import 'package:picos/themes/global_theme.dart';

/// contains the gender of the corresponding family member
enum Gender {
  /// element for denoting the title of men
  male,
  /// element for denoting the title of women
  female,
}

/// This is the screen in which a user can add/edit
/// information about his family members
class FamilyMembersAdd extends StatefulWidget {
  /// FamilyMembersAdd constructor
  const FamilyMembersAdd({Key? key}) : super(key: key);

  @override
  State<FamilyMembersAdd> createState() => _FamilyMembersAddState();
}

class _FamilyMembersAddState extends State<FamilyMembersAdd> {
  Gender? _gender = Gender.male;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String dropDownValue = AppLocalizations.of(context)!.father;

    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addFamilyMember),
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
                  labelText: AppLocalizations.of(context)!.chooseFamilyMember,
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
                  AppLocalizations.of(context)!.father,
                  AppLocalizations.of(context)!.mother,
                  AppLocalizations.of(context)!.brother,
                  AppLocalizations.of(context)!.sister,
                  AppLocalizations.of(context)!.husband,
                  AppLocalizations.of(context)!.wife,
                ].map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.title,
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
                    return validateEmail(value, context);
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
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child: PicosInkWellButton(
              text: AppLocalizations.of(context)!.abort,
              onTap: () {
                Navigator.pop(context);
              },
              disabled: false,
              buttonColor1: theme.grey3,
              buttonColor2: theme.grey1,
            ),
          ),
          Expanded(
            child: PicosInkWellButton(
              text: AppLocalizations.of(context)!.save,
              onTap: () {
                addFamilyMember(context, _formKey);
              },
              disabled: false,
            ),
          ),
        ],
      ),
    );
  }
}

/// returns a message (String)
/// whether e-mail-address validation is successful or not
String? validateEmail(String value, BuildContext context) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r'{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]'
      r'{0,253}[a-zA-Z0-9])?)*$';

  RegExp regex = RegExp(
    pattern,
  );

  if (!regex.hasMatch(value)) {
    return AppLocalizations.of(context)!.entryValidEmail;
  }

  return null;
}

/// When 'save'-button is pressed, this method will be triggered.
/// After successful validation, data will be written in database.
void addFamilyMember(BuildContext context, GlobalKey<FormState> key) {
  if (key.currentState!.validate()) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context)!.submitData,
        ),
      ),
    );
  }
}
