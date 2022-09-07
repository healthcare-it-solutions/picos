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

/// contains patient's medication.
bool medicationEnabled = false;

/// contains patient's therapy.
bool therapyEnabled = false;

/// contains patient's doctor's visit.
bool doctorsVisitEnabled = false;

/// First page of Configurations
class Page5 extends StatefulWidget {
  /// Constructor of Page1
  const Page5({Key? key}) : super(key: key);

  @override
  State<Page5> createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.all(10),
      key: formKey,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                '''${AppLocalizations.of(context)!.infoText1} '''
                '''"${AppLocalizations.of(context)!.medicationAndTherapy}" '''
                '''${AppLocalizations.of(context)!.infoText2}''',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SwitchListTile(
              value: medicationEnabled,
              onChanged: (bool value) {
                setState(() {
                  medicationEnabled = value;
                });
              },
              secondary: const Icon(Icons.medication),
              title: Text(
                AppLocalizations.of(context)!.medication,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              shape: const Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            SwitchListTile(
              value: therapyEnabled,
              onChanged: (bool value) {
                setState(() {
                  therapyEnabled = value;
                });
              },
              secondary: const Icon(Icons.healing_outlined),
              title: Text(
                AppLocalizations.of(context)!.therapy,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              shape: const Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            SwitchListTile(
              value: doctorsVisitEnabled,
              onChanged: (bool value) {
                setState(() {
                  doctorsVisitEnabled = value;
                });
              },
              secondary: const Icon(Icons.local_hospital_outlined),
              title: Text(
                AppLocalizations.of(context)!.doctorsVisit,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              shape: const Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
