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

import 'package:picos/widgets/picos_body.dart';

/// Shows page for configuration of vital values.
class ConfigurationVitalValues extends StatefulWidget {
  /// Constructor of page for configuration of vital values.
  const ConfigurationVitalValues({required this.callbackVitalValues, Key? key})
      : super(key: key);

  /// Callback function for vital values.
  final void Function(String, bool) callbackVitalValues;

  @override
  State<ConfigurationVitalValues> createState() =>
      _ConfigurationVitalValuesState();
}

class _ConfigurationVitalValuesState extends State<ConfigurationVitalValues> {
  /// Local variable for weight and BMI.
  bool _entryWeightBMIEnabled = false;

  /// Local variable for heart frequency.
  bool _entryHeartFrequencyEnabled = false;

  /// Local variable for blood pressure.
  bool _entryBloodPressureEnabled = false;

  /// Local variable for blood sugar levels.
  bool _entryBloodSugarLevelsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return PicosBody(
      child: Padding(
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
                value: _entryWeightBMIEnabled,
                onChanged: (bool value) {
                  setState(() {
                    widget.callbackVitalValues(
                      'entryWeightBMIEnabled',
                      value,
                    );
                    _entryWeightBMIEnabled = value;
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
                value: _entryHeartFrequencyEnabled,
                onChanged: (bool value) {
                  setState(() {
                    widget.callbackVitalValues(
                      'entryHeartFrequencyEnabled',
                      value,
                    );
                    _entryHeartFrequencyEnabled = value;
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
                value: _entryBloodPressureEnabled,
                onChanged: (bool value) {
                  setState(() {
                    widget.callbackVitalValues(
                      'entryBloodPressureEnabled',
                      value,
                    );
                    _entryBloodPressureEnabled = value;
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
                value: _entryBloodSugarLevelsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    widget.callbackVitalValues(
                      'entryBloodSugarLevelsEnabled',
                      value,
                    );
                    _entryBloodSugarLevelsEnabled = value;
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
      ),
    );
  }
}
