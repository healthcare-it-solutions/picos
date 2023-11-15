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
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/api/backend_follow_up_api.dart';
import 'package:picos/models/follow_up.dart';
import '../../widgets/picos_add_button_bar.dart';
import '../../widgets/picos_body.dart';
import '../../widgets/picos_screen_frame.dart';

/// Edit follow up screen.
class EditFollowUpScreen extends StatefulWidget {
  /// EditFollowUpScreen constructor.
  const EditFollowUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditFollowUpScreen> createState() => _EditFollowUpScreenState();
}

class _EditFollowUpScreenState extends State<EditFollowUpScreen> {
  late FollowUp _followUp;
  int? distance;
  int? bloodDiastolic;
  int? bloodSystolic;
  String? rhythm;
  String? rhythmTyp;
  int? testResult;
  List<dynamic>? healthState;
  String? locationType;
  int? heartRate;
  int? healthScore;
  int? number;

  bool saveDisabled = true;

  Map<String, String> rythmusSelect = <String, String>{
    'SR': 'SR',
    'VHF': 'VHF',
    'VT': 'VT',
  };
  Map<String, String> rythmusTypSelect = <String, String>{
    'Rhythmisch': 'Rhythmisch',
    'Arrhythmisch': 'Arrhythmisch',
  };

  Map<String, String> locationTypeSelect = <String, String>{
    'üRT': 'üRT',
    'RT': 'RT',
    'ST': 'ST',
    'IT': 'IT',
    'LT': 'LT',
    'üLT': 'üLT',
  };

  bool _isSystolicValid = true;
  bool _isDiastolicValid = true;
  bool _isHeartRateValid = true;
  bool _isDistanceValid = true;
  bool _isTestResultValid = true;
  final List<bool> _isHealthStateValid =
      List<bool>.generate(5, (int index) => true);
  bool _isHealthScoreValid = true;

  @override
  Widget build(BuildContext context) {
    _followUp = ModalRoute.of(context)!.settings.arguments as FollowUp;
    distance = _followUp.distance;
    bloodDiastolic = _followUp.bloodDiastolic;
    bloodSystolic = _followUp.bloodSystolic;
    rhythm = _followUp.rhythm;
    rhythmTyp = _followUp.rhythmTyp;
    testResult = _followUp.testResult;
    healthState = _followUp.healthState;
    locationType = _followUp.electricalAxisDeviation;
    heartRate = _followUp.heartRate;
    healthScore = _followUp.healthScore;
    number = _followUp.number;

    return PicosScreenFrame(
      title: 'V${_followUp.number}',
      body: PicosBody(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.bloodPressure,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              _buildBloodPressureField(),
              const SizedBox(height: 24),
              Text(
                'EKG',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              _buildHeartRateField(),
              const SizedBox(height: 16),
              _buildRhythmSelection(),
              const SizedBox(height: 16),
              _buildLocationTypeSelection(),
              const SizedBox(height: 24),
              Text(
                '2-MWT (Meter)',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              _buildDistanceField(),
              const SizedBox(height: 24),
              Text(
                'MoCA',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              _buildTestResultField(),
              const SizedBox(height: 24),
              Text(
                'EQ-5D-5L (${AppLocalizations.of(context)!.healthState})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              _buildHealthStateFields(),
              const SizedBox(height: 24),
              _buildHealthScoreField(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PicosAddButtonBar(
        disabled: saveDisabled || !_validateForm(),
        onTap: () {
          if (_validateForm()) {
            _saveFollowUpData();
          }
        },
      ),
    );
  }

  bool _validateForm() {
    return _isSystolicValid &&
        _isDiastolicValid &&
        _isHeartRateValid &&
        _isDistanceValid &&
        _isTestResultValid &&
        !_isHealthStateValid.contains(false) &&
        _isHealthScoreValid;
  }

  Widget _buildBloodPressureField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: TextFormField(
            initialValue: bloodSystolic?.toString(),
            decoration: InputDecoration(
              labelText: 'Syst (50-250 mmHg)',
              border: const OutlineInputBorder(),
              errorText: _isSystolicValid
                  ? null
                  : AppLocalizations.of(context)!.erroneousInput,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (String value) {
              setState(() {
                int? intValue = int.tryParse(value);
                if (intValue == null || (intValue < 50 || intValue > 250)) {
                  _isSystolicValid = false;
                  saveDisabled = true;
                } else {
                  _isSystolicValid = true;
                  saveDisabled = false;
                  bloodSystolic = intValue;
                }
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            initialValue: bloodDiastolic?.toString(),
            decoration: InputDecoration(
              labelText: 'Dias (35-150 mmHg)',
              border: const OutlineInputBorder(),
              errorText: _isDiastolicValid
                  ? null
                  : AppLocalizations.of(context)!.erroneousInput,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (String value) {
              setState(() {
                int? intValue = int.tryParse(value);
                if (intValue == null || (intValue < 35 || intValue > 150)) {
                  _isDiastolicValid = false;
                  saveDisabled = true;
                } else {
                  _isDiastolicValid = true;
                  saveDisabled = false;
                  bloodDiastolic = intValue;
                }
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeartRateField() {
    return TextFormField(
      initialValue: heartRate?.toString(),
      decoration: InputDecoration(
        labelText:
            '${AppLocalizations.of(context)!.heartFrequency} (40-350 /min)',
        border: const OutlineInputBorder(),
        errorText: _isHeartRateValid
            ? null
            : AppLocalizations.of(context)!.erroneousInput,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (String value) {
        setState(() {
          int? intValue = int.tryParse(value);
          if (intValue == null || (intValue < 40 || intValue > 350)) {
            _isHeartRateValid = false;
            saveDisabled = true;
          } else {
            _isHeartRateValid = true;
            saveDisabled = false;
            heartRate = intValue;
          }
        });
      },
    );
  }

  Widget _buildRhythmSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: DropdownButtonFormField<String>(
            value: rhythm,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.rhythm,
              border: const OutlineInputBorder(),
            ),
            items: rythmusSelect.entries.map((MapEntry<String, String> entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value),
              );
            }).toList(),
            hint: Text(AppLocalizations.of(context)!.rhythm),
            onChanged: (String? newValue) {
              setState(() {
                saveDisabled = false;
                rhythm = newValue;
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: rhythmTyp,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.rhythmType,
              border: const OutlineInputBorder(),
            ),
            items:
                rythmusTypSelect.entries.map((MapEntry<String, String> entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value),
              );
            }).toList(),
            hint: Text(AppLocalizations.of(context)!.rhythmType),
            onChanged: (String? newValue) {
              setState(() {
                saveDisabled = false;
                rhythmTyp = newValue;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLocationTypeSelection() {
    return DropdownButtonFormField<String>(
      value: locationType,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.electricalAxisDeviation,
        border: const OutlineInputBorder(),
      ),
      items: locationTypeSelect.entries.map((MapEntry<String, String> entry) {
        return DropdownMenuItem<String>(
          value: entry.key,
          child: Text(entry.value),
        );
      }).toList(),
      hint: Text(AppLocalizations.of(context)!.electricalAxisDeviation),
      onChanged: (String? newValue) {
        setState(() {
          saveDisabled = false;
          locationType = newValue;
        });
      },
    );
  }

  Widget _buildDistanceField() {
    return TextFormField(
      initialValue: distance?.toString(),
      decoration: InputDecoration(
        labelText: '${AppLocalizations.of(context)!.walkDistance} (1-600)',
        border: const OutlineInputBorder(),
        errorText: _isDistanceValid
            ? null
            : AppLocalizations.of(context)!.erroneousInput,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (String value) {
        setState(() {
          int? intValue = int.tryParse(value);
          if (intValue == null || (intValue < 1 || intValue > 600)) {
            _isDistanceValid = false;
            saveDisabled = true;
          } else {
            _isDistanceValid = true;
            saveDisabled = false;
            distance = intValue;
          }
        });
      },
    );
  }

  Widget _buildTestResultField() {
    return TextFormField(
      initialValue: testResult?.toString(),
      decoration: InputDecoration(
        labelText: '${AppLocalizations.of(context)!.testResult} (0-30)',
        border: const OutlineInputBorder(),
        errorText: _isTestResultValid
            ? null
            : AppLocalizations.of(context)!.erroneousInput,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (String value) {
        setState(() {
          int? intValue = int.tryParse(value);
          if (intValue == null || (intValue < 0 || intValue > 30)) {
            _isTestResultValid = false;
            saveDisabled = true;
          } else {
            _isTestResultValid = true;
            saveDisabled = false;
            testResult = intValue;
          }
        });
      },
    );
  }

  Widget _buildHealthStateFields() {
    int fieldsCounter = 5;
    return Row(
      children: List<Widget>.generate(
        fieldsCounter,
        (int index) => Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: fieldsCounter - 1),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: '(1-5)',
                border: const OutlineInputBorder(),
                errorText: _isHealthStateValid[index]
                    ? null
                    : AppLocalizations.of(context)!.erroneousInput,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              initialValue: healthState?[index]?.toString(),
              onChanged: (String value) {
                setState(() {
                  int? intValue = int.tryParse(value);
                  if (intValue == null || (intValue < 1 || intValue > 5)) {
                    _isHealthStateValid[index] = false;
                    saveDisabled = true;
                  } else {
                    _isHealthStateValid[index] = true;
                    saveDisabled = false;
                    healthState ??= <dynamic>['', '', '', '', ''];
                    healthState?[index] = intValue;
                  }
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHealthScoreField() {
    return TextFormField(
      initialValue: healthScore?.toString(),
      decoration: InputDecoration(
        labelText: '${AppLocalizations.of(context)!.healthScore} (1-100)',
        border: const OutlineInputBorder(),
        errorText: _isHealthScoreValid
            ? null
            : AppLocalizations.of(context)!.erroneousInput,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (String value) {
        setState(() {
          int? intValue = int.tryParse(value);
          if (intValue == null || (intValue < 1 || intValue > 100)) {
            _isHealthScoreValid = false;
            saveDisabled = true;
          } else {
            _isHealthScoreValid = true;
            saveDisabled = false;
            healthScore = intValue;
          }
        });
      },
    );
  }

  void _saveFollowUpData() {
    _followUp = _followUp.copyWith(
      distance: distance,
      bloodDiastolic: bloodDiastolic,
      bloodSystolic: bloodSystolic,
      rythmus: rhythm,
      rythmusTyp: rhythmTyp,
      testResult: testResult,
      healthState: healthState,
      locationType: locationType,
      heartRate: heartRate,
      healthScore: healthScore,
      number: number,
    );
    BackendFollowUpApi.saveFollowUp(_followUp);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
