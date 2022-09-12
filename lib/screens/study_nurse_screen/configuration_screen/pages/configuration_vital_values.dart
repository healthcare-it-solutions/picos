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

/// contains patient's weight.
bool weightBMIEnabled = false;

/// contains patient's heart frequency.
bool heartFrequencyEnabled = false;

/// contains patient's blood pressure.
bool bloodPressureEnabled = false;

/// contains patient's blood sugar level.
bool bloodSugarLevelsEnabled = false;

/// shows page for configuration of vital values.
class ConfigurationVitalValues extends StatefulWidget {
  /// Constructor of page for configuration of vital values.
  const ConfigurationVitalValues({Key? key}) : super(key: key);

  @override
  State<ConfigurationVitalValues> createState() =>
      _ConfigurationVitalValuesState();
}

class _ConfigurationVitalValuesState extends State<ConfigurationVitalValues> {
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
                '''"${AppLocalizations.of(context)!.vitalValues}" '''
                '''${AppLocalizations.of(context)!.infoText2}''',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SwitchListTile(
              value: weightBMIEnabled,
              onChanged: (bool value) {
                setState(() {
                  weightBMIEnabled = value;
                });
              },
              secondary: const Icon(Icons.monitor_weight_outlined),
              title: Text(
                AppLocalizations.of(context)!.weightBMI,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              shape: const Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            SwitchListTile(
              value: heartFrequencyEnabled,
              onChanged: (bool value) {
                setState(() {
                  heartFrequencyEnabled = value;
                });
              },
              secondary: const Icon(Icons.monitor_heart_outlined),
              title: Text(
                AppLocalizations.of(context)!.heartFrequency,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              shape: const Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            SwitchListTile(
              value: bloodPressureEnabled,
              onChanged: (bool value) {
                setState(() {
                  bloodPressureEnabled = value;
                });
              },
              secondary: const Icon(Icons.bloodtype_outlined),
              title: Text(
                AppLocalizations.of(context)!.bloodPressure,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              shape: const Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            SwitchListTile(
              value: bloodSugarLevelsEnabled,
              onChanged: (bool value) {
                setState(() {
                  bloodSugarLevelsEnabled = value;
                });
              },
              secondary: const Icon(Icons.device_thermostat_outlined),
              title: Text(
                AppLocalizations.of(context)!.bloodSugarLevels,
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
