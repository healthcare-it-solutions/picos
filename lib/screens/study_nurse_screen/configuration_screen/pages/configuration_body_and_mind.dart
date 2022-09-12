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

/// contains patient's pain.
bool painEnabled = false;

/// contains patient's PHQ-4.
bool phq4Enabled = false;

/// shows page for configuration of "Body & Mind"-information.
class ConfigurationBodyAndMind extends StatefulWidget {
  /// Constructor of page for configuration of "Body & Mind"-information.
  const ConfigurationBodyAndMind({Key? key}) : super(key: key);

  @override
  State<ConfigurationBodyAndMind> createState() =>
      _ConfigurationBodyAndMindState();
}

class _ConfigurationBodyAndMindState extends State<ConfigurationBodyAndMind> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                '''${AppLocalizations.of(context)!.infoText1} '''
                '''"${AppLocalizations.of(context)!.bodyAndMind}" '''
                '''${AppLocalizations.of(context)!.infoText2}''',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SwitchListTile(
              value: painEnabled,
              onChanged: (bool value) {
                setState(() {
                  painEnabled = value;
                });
              },
              secondary: const Icon(Icons.mood_bad_outlined),
              title: Text(
                AppLocalizations.of(context)!.pain,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              shape: const Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            SwitchListTile(
              value: phq4Enabled,
              onChanged: (bool value) {
                setState(() {
                  phq4Enabled = value;
                });
              },
              secondary: const Icon(Icons.psychology_outlined),
              title: const Text(
                'PHQ-4',
                style: TextStyle(
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
