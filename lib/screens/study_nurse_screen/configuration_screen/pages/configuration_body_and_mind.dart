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
import 'package:picos/widgets/picos_switch.dart';

/// Shows page for configuration of "Body & Mind"-information.
class ConfigurationBodyAndMind extends StatefulWidget {
  /// Constructor of page for configuration of "Body & Mind"-information.
  const ConfigurationBodyAndMind({
    required this.callbackBodyAndMind,
    required this.initialBodyAndMind,
    Key? key,
  }) : super(key: key);

  /// Callback function for body and mind.
  final void Function(String, bool) callbackBodyAndMind;

  /// Starting values for body and mind.
  final Map<String, bool> initialBodyAndMind;

  @override
  State<ConfigurationBodyAndMind> createState() =>
      _ConfigurationBodyAndMindState();
}

class _ConfigurationBodyAndMindState extends State<ConfigurationBodyAndMind> {
  late bool _entryPainEnabled = widget.initialBodyAndMind['entryPainEnabled']!;
  late bool _entryPhq4Enabled = widget.initialBodyAndMind['entryPhq4Enabled']!;

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
                  '''"${AppLocalizations.of(context)!.bodyAndMind}" '''
                  '''${AppLocalizations.of(context)!.infoText2}''',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              PicosSwitch(
                initialValue: _entryPainEnabled,
                onChanged: _entryPainEnabled
                    ? null
                    : (bool value) {
                        setState(() {
                          widget.callbackBodyAndMind(
                            'entryPainEnabled',
                            value,
                          );
                          _entryPainEnabled = value;
                        });
                      },
                secondary: const Icon(Icons.mood_bad_outlined),
                title: AppLocalizations.of(context)!.pain,
                textStyle: const TextStyle(fontSize: 16),
              ),
              PicosSwitch(
                initialValue: _entryPhq4Enabled,
                onChanged: _entryPhq4Enabled
                    ? null
                    : (bool value) {
                        setState(() {
                          widget.callbackBodyAndMind(
                            'entryPhq4Enabled',
                            value,
                          );
                          _entryPhq4Enabled = value;
                        });
                      },
                secondary: const Icon(Icons.psychology_outlined),
                title: 'PHQ-4',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
