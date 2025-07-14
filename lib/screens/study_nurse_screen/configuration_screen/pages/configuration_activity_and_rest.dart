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
import 'package:picos/gen_l10n/app_localizations.dart';
import 'package:picos/widgets/picos_body.dart';

import '../../../../widgets/picos_switch.dart';

/// Shows page for configuration of "Activity & Rest"-information.
class ConfigurationActivityAndRest extends StatefulWidget {
  /// Constructor of page for configuration of "Activity & Rest"-information.
  const ConfigurationActivityAndRest({
    required this.callbackActivityAndRest,
    required this.initialAlactivityAndRest,
    Key? key,
  }) : super(key: key);

  /// Callback function for activity and rest.
  final void Function(String, bool) callbackActivityAndRest;

  /// Starting values for activity and rest.
  final Map<String, bool> initialAlactivityAndRest;

  @override
  State<ConfigurationActivityAndRest> createState() =>
      _ConfigurationActivityAndRestState();
}

class _ConfigurationActivityAndRestState
    extends State<ConfigurationActivityAndRest> {
  late bool _entryWalkDistanceEnabled =
      widget.initialAlactivityAndRest['entryWalkDistanceEnabled']!;
  late bool _entrySleepDurationEnabled =
      widget.initialAlactivityAndRest['entrySleepDurationEnabled']!;
  late bool _entrySleepQualityEnabled =
      widget.initialAlactivityAndRest['entrySleepQualityEnabled']!;

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
                  '''"${AppLocalizations.of(context)!.activityAndRest}" '''
                  '''${AppLocalizations.of(context)!.infoText2}''',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              PicosSwitch(
                initialValue: _entryWalkDistanceEnabled,
                onChanged: (bool value) {
                  setState(() {
                    widget.callbackActivityAndRest(
                      'entryWalkDistanceEnabled',
                      value,
                    );
                    _entryWalkDistanceEnabled = value;
                  });
                },
                secondary: const Icon(Icons.directions_walk_outlined),
                title: AppLocalizations.of(context)!.walkDistance,
                textStyle: const TextStyle(fontSize: 16),
              ),
              PicosSwitch(
                initialValue: _entrySleepDurationEnabled,
                onChanged: _entrySleepDurationEnabled
                    ? null
                    : (bool value) {
                        setState(() {
                          widget.callbackActivityAndRest(
                            'entrySleepDurationEnabled',
                            value,
                          );
                          _entrySleepDurationEnabled = value;
                        });
                      },
                secondary: const Icon(Icons.access_alarm_outlined),
                title: AppLocalizations.of(context)!.sleepDuration,
                textStyle: const TextStyle(fontSize: 16),
              ),
              PicosSwitch(
                initialValue: _entrySleepQualityEnabled,
                onChanged: _entrySleepQualityEnabled
                    ? null
                    : (bool value) {
                        setState(() {
                          widget.callbackActivityAndRest(
                            'entrySleepQualityEnabled',
                            value,
                          );
                          _entrySleepQualityEnabled = value;
                        });
                      },
                secondary: const Icon(Icons.bed_outlined),
                title: AppLocalizations.of(context)!.sleepQuality,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
