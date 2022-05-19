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
          //key: _formKey,
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
                  'Ehefrau'
                ].map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem(
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
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text(
                        'Männlich',
                        style: TextStyle(fontWeight: FontWeight.bold),
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
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text(
                        'Weiblich',
                        style: TextStyle(fontWeight: FontWeight.bold),
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
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Nachname *',
                ),
                keyboardType: TextInputType.name,
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'E-Mail-Adresse *',
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.numbers),
                  labelText: 'Telefon *',
                ),
                keyboardType: TextInputType.number,
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
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
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
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
                      colors: [
                        Color.fromRGBO(149, 193, 31, 1),
                        Color.fromRGBO(110, 171, 39, 1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint('Speichern');
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
