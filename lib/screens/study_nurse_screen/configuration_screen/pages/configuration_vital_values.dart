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

import '../../../../widgets/picos_switch.dart';

/// Shows page for configuration of vital values.
class ConfigurationVitalValues extends StatefulWidget {
  /// Constructor of page for configuration of vital values.
  const ConfigurationVitalValues({
    required this.callbackVitalValues,
    required this.initialVitalValues,
    Key? key,
  }) : super(key: key);

  /// Callback function for vital values.
  final void Function(String, bool) callbackVitalValues;

  /// Starting values for vital values.
  final Map<String, bool> initialVitalValues;

  @override
  State<ConfigurationVitalValues> createState() =>
      _ConfigurationVitalValuesState();
}

class _ConfigurationVitalValuesState extends State<ConfigurationVitalValues> {
  late bool _entryWeightBMIEnabled =
      widget.initialVitalValues['entryWeightBMIEnabled']!;
  late bool _entryHeartFrequencyEnabled =
      widget.initialVitalValues['entryHeartFrequencyEnabled']!;
  late bool _entryBloodPressureEnabled =
      widget.initialVitalValues['entryBloodPressureEnabled']!;
  late bool _entryBloodSugarLevelsEnabled =
      widget.initialVitalValues['entryBloodSugarLevelsEnabled']!;

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
              PicosSwitch(
                initialValue: _entryWeightBMIEnabled,
                onChanged: _entryWeightBMIEnabled
                    ? null
                    : (bool value) {
                        setState(() {
                          widget.callbackVitalValues(
                            'entryWeightBMIEnabled',
                            value,
                          );
                          _entryWeightBMIEnabled = value;
                        });
                      },
                secondary: const Icon(Icons.monitor_weight_outlined),
                title: AppLocalizations.of(context)!.weightBMI,
                textStyle: const TextStyle(fontSize: 16),
              ),
              PicosSwitch(
                initialValue: _entryHeartFrequencyEnabled,
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
                title: AppLocalizations.of(context)!.heartFrequency,
                textStyle: const TextStyle(fontSize: 16),
              ),
              PicosSwitch(
                initialValue: _entryBloodPressureEnabled,
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
                title: AppLocalizations.of(context)!.bloodPressure,
                textStyle: const TextStyle(fontSize: 16),
              ),
              PicosSwitch(
                initialValue: _entryBloodSugarLevelsEnabled,
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
                title: AppLocalizations.of(context)!.bloodSugar,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
