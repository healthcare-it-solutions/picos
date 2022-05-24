/*   This file is part of Picos, a health trcking mobile app
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

/// contains the gender of the corresponding family member
// ignore: public_member_api_docs
enum Gender { male, female }

/// This is the screen in which a user can add/edit
/// information about his family members
class FamilyMembersAdd extends StatefulWidget {
  // ignore: public_member_api_docs
  const FamilyMembersAdd({Key? key}) : super(key: key);

  @override
  State<FamilyMembersAdd> createState() => _FamilyMembersAddState();
}

class _FamilyMembersAddState extends State<FamilyMembersAdd> {
  String dropDownValue = 'Vater';

  Gender? _gender = Gender.male;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Angehörige/n hinzüfügen'),
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
                decoration: const InputDecoration(
                  labelText: 'Wählen Sie Ihren Familienangehörigen aus.',
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
                  'Vater',
                  'Mutter',
                  'Bruder',
                  'Schwester',
                  'Ehemann',
                  'Ehefrau',
                ].map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  },
                ).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Geschlecht *',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<Gender>(
                      title: const Text(
                        'Herr',
                        style: TextStyle(
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
                      selected: true,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<Gender>(
                      title: const Text(
                        'Frau',
                        style: TextStyle(
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
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Vorname *',
                ),
                keyboardType: TextInputType.name,
                onSaved: (String? value) {
                  //Implement here
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geben Sie den Vornamen ein.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Nachname *',
                ),
                keyboardType: TextInputType.name,
                onSaved: (String? value) {
                  //Implement here
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geben Sie den Nachnamen ein.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'E-Mail-Adresse *',
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (String? value) {
                  //Implement here
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geben Sie die E-Mail-Adresse ein.';
                  } else {
                    return validateEmail(value);
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.numbers),
                  labelText: 'Telefon *',
                ),
                keyboardType: TextInputType.number,
                onSaved: (String? value) {
                  //Implement here
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geben Sie die Telefonnummer ein.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.house),
                  hintText: 'Straßenname Hausnummer\nPLZ Stadt',
                  labelText: 'Anschrift *',
                ),
                keyboardType: TextInputType.multiline,
                minLines: 2,
                maxLines: null,
                onSaved: (String? value) {
                  //Implement here
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geben Sie die Adresse ein.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color.fromRGBO(135, 150, 162, 1),
                        Color.fromRGBO(95, 115, 131, 1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Abbrechen',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color.fromRGBO(149, 193, 31, 1),
                        Color.fromRGBO(110, 171, 39, 1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      addFamilyMember(context, _formKey);
                    },
                    child: const Text(
                      'Speichern',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// returns a message (String)
/// whether e-mail-address validation is successful or not
String? validateEmail(String value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r'{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]'
      r'{0,253}[a-zA-Z0-9])?)*$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Bitte geben Sie eine gültige E-Mail-Adresse ein!';
  }
  return null;
}

/// When 'save'-button is pressed, this method will be triggered.
/// After successful validation, data will be written in database.
void addFamilyMember(BuildContext context, GlobalKey<FormState> _key) {
  if (_key.currentState!.validate()) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Die Daten werden übermittelt!'),
      ),
    );
  }
}
