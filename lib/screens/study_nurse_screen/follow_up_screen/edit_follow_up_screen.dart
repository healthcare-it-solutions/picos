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
import '../../../widgets/picos_add_button_bar.dart';
import '../../../widgets/picos_body.dart';
import '../../../widgets/picos_screen_frame.dart';

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
  int? _distance;
  int? _bloodDiastolic;
  int? _bloodSystolic;
  String? _rhythm;
  String? _rhythmType;
  int? _testResult;
  List<dynamic>? _healthState;
  String? _electricalAxisDeviation;
  int? _heartRate;
  int? _healthScore;
  int? _number;

  bool _saveDisabled = true;

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

  TextStyle errorTextStyle = const TextStyle(color: Colors.red, fontSize: 14);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initFollowUpData();
  }

  void _initFollowUpData() {
    _followUp = ModalRoute.of(context)!.settings.arguments as FollowUp;
    _distance = _followUp.distance;
    _bloodDiastolic = _followUp.bloodDiastolic;
    _bloodSystolic = _followUp.bloodSystolic;
    _rhythm = _followUp.rhythm;
    _rhythmType = _followUp.rhythmType;
    _testResult = _followUp.testResult;
    _healthState = _followUp.healthState;
    _electricalAxisDeviation = _followUp.electricalAxisDeviation;
    _heartRate = _followUp.heartRate;
    _healthScore = _followUp.healthScore;
    _number = _followUp.number;
  }

  @override
  Widget build(BuildContext context) {
    return PicosScreenFrame(
      title: 'V${_followUp.number}',
      body: PicosBody(child: _buildForm()),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle(AppLocalizations.of(context)!.bloodPressure),
          const SizedBox(height: 8),
          _buildBloodPressureField(),
          const SizedBox(height: 24),
          _buildSectionTitle('EKG'),
          const SizedBox(height: 8),
          _buildHeartRateField(),
          const SizedBox(height: 16),
          _buildRhythmSelection(),
          const SizedBox(height: 16),
          _buildLocationTypeSelection(),
          const SizedBox(height: 24),
          _buildSectionTitle('2-MWT'),
          const SizedBox(height: 8),
          _buildDistanceField(),
          const SizedBox(height: 24),
          _buildSectionTitle('MoCA'),
          const SizedBox(height: 8),
          _buildTestResultField(),
          const SizedBox(height: 24),
          _buildSectionTitle(
            'EQ-5D-5L (${AppLocalizations.of(context)!.healthState})',
          ),
          const SizedBox(height: 8),
          _buildHealthStateFields(),
          const SizedBox(height: 24),
          _buildHealthScoreField(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget _buildBottomNavigationBar() {
    return PicosAddButtonBar(
      disabled: _saveDisabled || !_validateForm(),
      onTap: _handleSave,
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

  void _handleSave() {
    if (_validateForm()) {
      _saveFollowUpData();
    }
  }

  void _saveFollowUpData() {
    _followUp = _followUp.copyWith(
      distance: _distance,
      bloodDiastolic: _bloodDiastolic,
      bloodSystolic: _bloodSystolic,
      rhythm: _rhythm,
      rhythmType: _rhythmType,
      testResult: _testResult,
      healthState: _healthState,
      electricalAxisDeviation: _electricalAxisDeviation,
      heartRate: _heartRate,
      healthScore: _healthScore,
      number: _number,
    );
    BackendFollowUpApi.saveFollowUp(_followUp);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  InputBorder focusedBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).focusColor),
    );
  }

  Widget _buildBloodPressureField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: TextFormField(
            initialValue: _bloodSystolic?.toString(),
            decoration: InputDecoration(
              labelText: 'Syst (50-250 mmHg)',
              border: const OutlineInputBorder(),
              focusedBorder: focusedBorder(),
              errorText: _isSystolicValid
                  ? null
                  : AppLocalizations.of(context)!.erroneousInput,
              errorStyle: errorTextStyle,
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
                  _saveDisabled = true;
                } else {
                  _isSystolicValid = true;
                  _saveDisabled = false;
                  _bloodSystolic = intValue;
                }
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            initialValue: _bloodDiastolic?.toString(),
            decoration: InputDecoration(
              labelText: 'Dias (35-150 mmHg)',
              border: const OutlineInputBorder(),
              focusedBorder: focusedBorder(),
              errorText: _isDiastolicValid
                  ? null
                  : AppLocalizations.of(context)!.erroneousInput,
              errorStyle: errorTextStyle,
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
                  _saveDisabled = true;
                } else {
                  _isDiastolicValid = true;
                  _saveDisabled = false;
                  _bloodDiastolic = intValue;
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
      initialValue: _heartRate?.toString(),
      decoration: InputDecoration(
        labelText:
            '${AppLocalizations.of(context)!.heartFrequency} (40-350 /min)',
        border: const OutlineInputBorder(),
        focusedBorder: focusedBorder(),
        errorText: _isHeartRateValid
            ? null
            : AppLocalizations.of(context)!.erroneousInput,
        errorStyle: errorTextStyle,
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
            _saveDisabled = true;
          } else {
            _isHeartRateValid = true;
            _saveDisabled = false;
            _heartRate = intValue;
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
            value: _rhythm,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.rhythm,
              border: const OutlineInputBorder(),
              focusedBorder: focusedBorder(),
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
                _saveDisabled = false;
                _rhythm = newValue;
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: _rhythmType,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.rhythmType,
              border: const OutlineInputBorder(),
              focusedBorder: focusedBorder(),
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
                _saveDisabled = false;
                _rhythmType = newValue;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLocationTypeSelection() {
    return DropdownButtonFormField<String>(
      value: _electricalAxisDeviation,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.electricalAxisDeviation,
        border: const OutlineInputBorder(),
        focusedBorder: focusedBorder(),
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
          _saveDisabled = false;
          _electricalAxisDeviation = newValue;
        });
      },
    );
  }

  Widget _buildDistanceField() {
    return TextFormField(
      initialValue: _distance?.toString(),
      decoration: InputDecoration(
        labelText:
            '${AppLocalizations.of(context)!.walkDistance} (0-600 meter)',
        border: const OutlineInputBorder(),
        focusedBorder: focusedBorder(),
        errorText: _isDistanceValid
            ? null
            : AppLocalizations.of(context)!.erroneousInput,
        errorStyle: errorTextStyle,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (String value) {
        setState(() {
          int? intValue = int.tryParse(value);
          if (intValue == null || (intValue < 0 || intValue > 600)) {
            _isDistanceValid = false;
            _saveDisabled = true;
          } else {
            _isDistanceValid = true;
            _saveDisabled = false;
            _distance = intValue;
          }
        });
      },
    );
  }

  Widget _buildTestResultField() {
    return TextFormField(
      initialValue: _testResult?.toString(),
      decoration: InputDecoration(
        labelText: '${AppLocalizations.of(context)!.testResult} (0-30)',
        border: const OutlineInputBorder(),
        focusedBorder: focusedBorder(),
        errorText: _isTestResultValid
            ? null
            : AppLocalizations.of(context)!.erroneousInput,
        errorStyle: errorTextStyle,
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
            _saveDisabled = true;
          } else {
            _isTestResultValid = true;
            _saveDisabled = false;
            _testResult = intValue;
          }
        });
      },
    );
  }

  Widget _buildHealthStateFields() {
    int fieldsCounter = 5;
    bool hasError = _isHealthStateValid.contains(false);

    List<Widget> fieldWidgets = List<Widget>.generate(
      fieldsCounter,
      (int index) => Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: fieldsCounter - 1),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: '(1-5)',
              border: const OutlineInputBorder(),
              focusedBorder: focusedBorder(),
              errorText: _isHealthStateValid[index] ? null : '',
              errorStyle: errorTextStyle,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            initialValue: _healthState?[index]?.toString(),
            onChanged: (String value) {
              setState(() {
                int? intValue = int.tryParse(value);
                if (intValue == null || (intValue < 1 || intValue > 5)) {
                  _isHealthStateValid[index] = false;
                } else {
                  _isHealthStateValid[index] = true;
                  _healthState ??= <dynamic>['', '', '', '', ''];
                  _healthState?[index] = intValue;
                }
                _saveDisabled = _isHealthStateValid.contains(false);
              });
            },
          ),
        ),
      ),
    );

    return Column(
      children: <Widget>[
        Row(children: fieldWidgets),
        if (hasError)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.erroneousInput,
              style: errorTextStyle,
            ),
          ),
      ],
    );
  }

  Widget _buildHealthScoreField() {
    return TextFormField(
      initialValue: _healthScore?.toString(),
      decoration: InputDecoration(
        labelText: '${AppLocalizations.of(context)!.healthScore} (1-100)',
        border: const OutlineInputBorder(),
        focusedBorder: focusedBorder(),
        errorText: _isHealthScoreValid
            ? null
            : AppLocalizations.of(context)!.erroneousInput,
        errorStyle: errorTextStyle,
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
            _saveDisabled = true;
          } else {
            _isHealthScoreValid = true;
            _saveDisabled = false;
            _healthScore = intValue;
          }
        });
      },
    );
  }
}
