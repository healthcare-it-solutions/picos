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

/// Questionnaire blood pressure page.
class EditFollowUpScreen extends StatefulWidget {
  /// BloodPressure constructor.
  const EditFollowUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditFollowUpScreen> createState() => _EditFollowUpScreenState();
}

class _EditFollowUpScreenState extends State<EditFollowUpScreen> {
  TextEditingController _systolicController = TextEditingController();
  TextEditingController _diastolicController = TextEditingController();
  TextEditingController _heartRateController = TextEditingController();
  TextEditingController _distanceController = TextEditingController();
  TextEditingController _testResultController = TextEditingController();
  List<TextEditingController> _healthStateControllers =
      <TextEditingController>[];
  TextEditingController _healthScoreController = TextEditingController();

  late FollowUp _followUp;
  int? distance;
  int? bloodDiastolic;
  int? bloodSystolic;
  String? rythmus;
  int? testResult;
  List<dynamic>? healthState;
  String? locationType;
  int? heartRate;
  int? healthScore;
  int? number;

  bool saveDisabled = true;

  static const Map<String, String> _rythmusSelection1 = <String, String>{
    'SR': 'SR',
    'VHF': 'VHF',
    'VT': 'VT',
  };
  static const Map<String, String> _rythmusSelection2 = <String, String>{
    'Rhythmisch': 'Rhythmisch',
    'Arrhythmisch': 'Arrhythmisch',
  };

  static const Map<String, String> _locationTypeSelection = <String, String>{
    'üRT': 'üRT',
    'RT': 'RT',
    'ST': 'ST',
    'IT': 'IT',
    'LT': 'LT',
    'üLT': 'üLT',
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _followUp = ModalRoute.of(context)!.settings.arguments as FollowUp;
    distance = _followUp.distance;
    bloodDiastolic = _followUp.bloodDiastolic;
    bloodSystolic = _followUp.bloodSystolic;
    rythmus = _followUp.rythmus;
    testResult = _followUp.testResult;
    healthState = _followUp.healthState;
    locationType = _followUp.locationType;
    heartRate = _followUp.heartRate;
    healthScore = _followUp.healthScore;
    number = _followUp.number;

    _systolicController =
        TextEditingController(text: bloodSystolic?.toString() ?? '');
    _diastolicController =
        TextEditingController(text: bloodDiastolic?.toString() ?? '');
    _heartRateController = TextEditingController(text: heartRate?.toString());
    _distanceController = TextEditingController(text: distance?.toString());
    _testResultController = TextEditingController(text: testResult?.toString());
    _healthStateControllers = List<TextEditingController>.generate(
      5,
      (int index) => TextEditingController(),
    );
    _healthScoreController =
        TextEditingController(text: healthScore?.toString() ?? '');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _systolicController.dispose();
    _diastolicController.dispose();
    _heartRateController.dispose();
    _distanceController.dispose();
    _testResultController.dispose();
    for (TextEditingController controller in _healthStateControllers) {
      controller.dispose();
    }
    _healthScoreController.dispose();
    super.dispose();
  }

  bool _isSystolicValid = true;
  bool _isDiastolicValid = true;
  bool _isHeartRateValid = true;
  bool _isDistanceValid = true;
  bool _isTestResultValid = true;
  List<bool> _isHealthStateValid = List<bool>.generate(5, (int index) => true);
  bool _isHealthScoreValid = true;

  @override
  Widget build(BuildContext context) {
    return PicosScreenFrame(
      title: 'Follow-Up ${_followUp.number}',
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
                '2-MWT',
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
                'EQ-5D-5L Gesundheitszustand',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              _buildHealthStateFields(),
              const SizedBox(height: 24),
              _buildHealthScoreField(),
              const SizedBox(height: 24),
              // Andere Widgets oder Logik hier hinzufügen, falls notwendig
              // ...
            ],
          ),
        ),
      ),
      bottomNavigationBar: PicosAddButtonBar(
        disabled: !_validateForm(),
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
              labelText: 'Systolisch (50-250)',
              border: const OutlineInputBorder(),
              errorText: _isSystolicValid ? null : 'Bitte Interval beachten!',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (String value) {
              int? intValue = int.tryParse(value);
              if (intValue != null && (intValue < 50 || intValue > 250)) {
                setState(() {
                  _isSystolicValid = false;
                });
              } else {
                setState(() {
                  _isSystolicValid = true;
                  bloodSystolic = intValue;
                });
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            initialValue: bloodDiastolic?.toString(),
            decoration: InputDecoration(
              labelText: 'Diastolic (35-150)',
              border: const OutlineInputBorder(),
              errorText: _isDiastolicValid ? null : 'Bitte Interval beachten!',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (String value) {
              setState(() {
                int? intValue = int.tryParse(value);
                if (intValue != null && (intValue < 35 || intValue > 150)) {
                  _isDiastolicValid = false;
                } else {
                  _isDiastolicValid = true;
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
        labelText: 'Herzrate (40-350)',
        border: const OutlineInputBorder(),
        errorText: !_isHeartRateValid
            ? 'Bitte einen Wert zwischen 40-350 eingeben'
            : null,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (String value) {
        setState(() {
          int? intValue = int.tryParse(value);
          if (intValue != null && (intValue < 40 || intValue > 350)) {
            _isHeartRateValid = false;
          } else {
            _isHeartRateValid = true;
            heartRate = intValue;
          }
        });
      },
    );
  }

  Widget _buildRhythmSelection() {
    rythmus = rythmus ?? _rythmusSelection1.keys.first;
    String? rythmusType = _rythmusSelection2.keys.first;
    locationType = locationType ?? _locationTypeSelection.keys.first;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: DropdownButtonFormField<String>(
            value: rythmus,
            decoration: const InputDecoration(
              labelText: 'Rhythmus',
              border: OutlineInputBorder(),
            ),
            items: _rythmusSelection1.entries
                .map((MapEntry<String, String> entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                saveDisabled = false;
                rythmus = newValue;
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: rythmusType,
            decoration: const InputDecoration(
              labelText: 'Rhythmus Typ',
              border: OutlineInputBorder(),
            ),
            items: _rythmusSelection2.entries
                .map((MapEntry<String, String> entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                saveDisabled = false;
                rythmusType = newValue;
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
      decoration: const InputDecoration(
        labelText: 'Standorttyp',
        border: OutlineInputBorder(),
      ),
      items:
          _locationTypeSelection.entries.map((MapEntry<String, String> entry) {
        return DropdownMenuItem<String>(
          value: entry.key,
          child: Text(entry.value),
        );
      }).toList(),
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
        labelText: 'Strecke (1-600)',
        border: const OutlineInputBorder(),
        errorText: _isDistanceValid
            ? null
            : 'Bitte einen Wert zwischen 1-600 eingeben',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (String value) {
        setState(() {
          int? intValue = int.tryParse(value);
          if (intValue != null && (intValue < 1 || intValue > 600)) {
            _isDistanceValid = false;
          } else {
            _isDistanceValid = true;
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
        labelText: 'Testergebnis (0-30)',
        border: const OutlineInputBorder(),
        errorText: _isTestResultValid
            ? null
            : 'Bitte einen Wert zwischen 0-30 eingeben',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (String value) {
        setState(() {
          int? intValue = int.tryParse(value);
          if (intValue != null && (intValue < 0 || intValue > 30)) {
            _isTestResultValid = false;
          } else {
            _isTestResultValid = true;
            testResult = intValue;
          }
        });
      },
    );
  }

  Widget _buildHealthStateFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List<Widget>.generate(
        _healthStateControllers.length,
        (int index) => Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : 8,
              right: index == _healthStateControllers.length - 1 ? 0 : 8,
            ),
            child: TextFormField(
              controller: _healthStateControllers[index],
              decoration: InputDecoration(
                labelText: 'Zustand ${index + 1}',
                border: const OutlineInputBorder(),
                errorText: _isHealthStateValid[index]
                    ? null
                    : 'Bitte einen Wert zwischen 1-5 eingeben',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (String value) {
                setState(() {
                  int? intValue = int.tryParse(value);
                  if (intValue != null && (intValue < 1 || intValue > 5)) {
                    _isHealthStateValid[index] = false;
                  } else {
                    _isHealthStateValid[index] = true;
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
        labelText: 'Gesundheitsscore (1-100)',
        border: const OutlineInputBorder(),
        errorText: _isHealthScoreValid
            ? null
            : 'Bitte einen Wert zwischen 1-100 eingeben',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (String value) {
        setState(() {
          int? intValue = int.tryParse(value);
          if (intValue != null && (intValue < 1 || intValue > 100)) {
            _isHealthScoreValid = false;
          } else {
            _isHealthScoreValid = true;
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
      rythmus: rythmus,
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
