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

/// Shows page for configuration of "Medication & Therapy"-information.
class ConfigurationMedicationAndTherapy extends StatefulWidget {
  /// Constructor of page for configuration of
  /// "Medication & Therapy"-information.
  const ConfigurationMedicationAndTherapy({
    required this.callbackMedicationAndTherapy,
    required this.initialMedicationAndTherapy,
    Key? key,
  }) : super(key: key);

  /// Callback function for medication and therapy.
  final void Function(String, bool) callbackMedicationAndTherapy;

  /// Starting values for medication and therapy.
  final Map<String, bool> initialMedicationAndTherapy;

  @override
  State<ConfigurationMedicationAndTherapy> createState() =>
      _ConfigurationMedicationAndTherapyState();
}

class _ConfigurationMedicationAndTherapyState
    extends State<ConfigurationMedicationAndTherapy> {
  late bool _entryMedicationEnabled =
      widget.initialMedicationAndTherapy['entryMedicationEnabled']!;
  late bool _entryTherapyEnabled =
      widget.initialMedicationAndTherapy['entryTherapyEnabled']!;
  late bool _entryDoctorsVisitEnabled =
      widget.initialMedicationAndTherapy['entryDoctorsVisitEnabled']!;

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
                  '''"${AppLocalizations.of(context)!.medicationAndTherapy}" '''
                  '''${AppLocalizations.of(context)!.infoText2}''',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              PicosSwitch(
                initialValue: _entryMedicationEnabled,
                onChanged: _entryMedicationEnabled
                    ? null
                    : (bool value) {
                        setState(() {
                          widget.callbackMedicationAndTherapy(
                            'entryMedicationEnabled',
                            value,
                          );
                          _entryMedicationEnabled = value;
                        });
                      },
                secondary: const Icon(Icons.medication),
                title: AppLocalizations.of(context)!.medication,
                textStyle: const TextStyle(fontSize: 16),
              ),
              PicosSwitch(
                initialValue: _entryTherapyEnabled,
                onChanged: _entryTherapyEnabled
                    ? null
                    : (bool value) {
                        setState(() {
                          widget.callbackMedicationAndTherapy(
                            'entryTherapyEnabled',
                            value,
                          );
                          _entryTherapyEnabled = value;
                        });
                      },
                secondary: const Icon(Icons.healing_outlined),
                title: AppLocalizations.of(context)!.therapy,
                textStyle: const TextStyle(fontSize: 16),
              ),
              PicosSwitch(
                initialValue: _entryDoctorsVisitEnabled,
                onChanged: _entryDoctorsVisitEnabled
                    ? null
                    : (bool value) {
                        setState(() {
                          widget.callbackMedicationAndTherapy(
                            'entryDoctorsVisitEnabled',
                            value,
                          );
                          _entryDoctorsVisitEnabled = value;
                        });
                      },
                secondary: const Icon(Icons.local_hospital_outlined),
                title: AppLocalizations.of(context)!.doctorsVisit,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
