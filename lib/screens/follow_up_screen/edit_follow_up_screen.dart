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
  final TextEditingController _systolicController = TextEditingController();
  final TextEditingController _diastolicController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _twoMWTController = TextEditingController();
  final TextEditingController _moCaController = TextEditingController();
  List<TextEditingController> _healthStateControllers =
      <TextEditingController>[];
  final TextEditingController _healthScoreController = TextEditingController();

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
  void initState() {
    super.initState();
    _healthStateControllers = List<TextEditingController>.generate(
      5,
      (int index) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    // Dispose all controllers.
    _systolicController.dispose();
    _diastolicController.dispose();
    _heartRateController.dispose();
    _twoMWTController.dispose();
    _moCaController.dispose();
    for (TextEditingController controller in _healthStateControllers) {
      controller.dispose();
    }
    _healthScoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FollowUp followUp = ModalRoute.of(context)!.settings.arguments as FollowUp;
    distance = followUp.distance;
    bloodDiastolic = followUp.bloodDiastolic;
    bloodSystolic = followUp.bloodSystolic;
    rythmus = followUp.rythmus;
    testResult = followUp.testResult;
    healthState = followUp.healthState;
    locationType = followUp.locationType;
    heartRate = followUp.heartRate;
    healthScore = followUp.healthScore;
    number = followUp.number;

    rythmus = rythmus ?? _rythmusSelection1.keys.first;
    String? rythmusType = _rythmusSelection2.keys.first;
    locationType = locationType ?? _locationTypeSelection.keys.first;

    return PicosScreenFrame(
      title: 'V${followUp.number}',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _systolicController,
                      decoration: const InputDecoration(
                        labelText: 'Systolic (50-250)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: bloodSystolic?.toString(),
                      onChanged: (String value) {
                        int intValue = int.tryParse(value) ?? 0;
                        if (intValue < 50 || intValue > 250) {
                          _systolicController.text =
                              (intValue < 1) ? '50' : '250';
                        }
                        setState(() {
                          saveDisabled = false;
                          bloodSystolic = int.tryParse(value);
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _diastolicController,
                      decoration: const InputDecoration(
                        labelText: 'Diastolic (35-150)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: bloodDiastolic?.toString(),
                      onChanged: (String value) {
                        int intValue = int.tryParse(value) ?? 0;
                        if (intValue < 35 || intValue > 150) {
                          _diastolicController.text =
                              (intValue < 1) ? '35' : '150';
                        }
                        setState(() {
                          saveDisabled = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              // Add spacing between sections
              const SizedBox(height: 24),
              Text(
                'EKG',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _heartRateController,
                decoration: const InputDecoration(
                  labelText: 'Herzrate (40-350)',
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    TextInputType.number,
                initialValue: heartRate?.toString(),
                onChanged: (String value) {
                  int intValue = int.tryParse(value) ?? 0;
                  if (intValue < 40 || intValue > 350) {
                    _heartRateController.text = (intValue < 1) ? '40' : '350';
                  }
                  setState(() {
                    saveDisabled = false;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
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
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: locationType,
                decoration: const InputDecoration(
                  labelText: 'Standorttyp',
                  border: OutlineInputBorder(),
                ),
                items: _locationTypeSelection.entries
                    .map((MapEntry<String, String> entry) {
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
              ),
              const SizedBox(height: 24),
              Text(
                '2-MWT',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _twoMWTController,
                decoration: const InputDecoration(
                  labelText: 'Strecke (1-600)',
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    TextInputType.number,
                initialValue: distance?.toString(),
                onChanged: (String value) {
                  int intValue = int.tryParse(value) ?? 0;
                  if (intValue < 1 || intValue > 600) {
                    _twoMWTController.text = (intValue < 1) ? '1' : '600';
                  }
                  setState(() {
                    saveDisabled = false;
                  });
                },
              ),
              // Add spacing between sections
              const SizedBox(height: 24),
              Text(
                'MoCA',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _moCaController,
                decoration: const InputDecoration(
                  labelText: 'Testergebnis (0-30)',
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    TextInputType.number,
                onChanged: (String value) {
                  int intValue = int.tryParse(value) ?? 0;
                  if (intValue < 0 || intValue > 30) {
                    _moCaController.text = (intValue < 0) ? '0' : '30';
                  }
                  setState(() {
                    saveDisabled = false;
                  });
                },
              ),

              const SizedBox(height: 24),
              Text(
                'EQ-5D-5L Gesundheitszustand',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List<Widget>.generate(
                  _healthStateControllers.length,
                  (int index) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 0 : 8,
                        right:
                            index == _healthStateControllers.length - 1 ? 0 : 8,
                      ),
                      child: TextFormField(
                        controller: _healthStateControllers[index],
                        decoration: InputDecoration(
                          labelText: 'Zustand ${index + 1}',
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        initialValue: healthState?.toString(),
                        onChanged: (String value) {
                          int intValue = int.tryParse(value) ?? 0;
                          if (intValue < 1 || intValue > 5) {
                            _healthStateControllers[index].text =
                                (intValue < 1) ? '1' : '5';
                          }
                          setState(() {
                            saveDisabled = false;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _healthScoreController,
                decoration: const InputDecoration(
                  labelText: 'Gesundheitsscore (1-100)',
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    TextInputType.number,
                initialValue: healthScore?.toString(),
                onChanged: (String value) {
                  int intValue = int.tryParse(value) ?? 0;
                  if (intValue < 1 || intValue > 100) {
                    _healthScoreController.text = (intValue < 1)
                        ? '1'
                        : (intValue > 100 ? '100' : value);
                  }
                  setState(() {
                    saveDisabled = false;
                    healthScore = int.tryParse(value);
                  });
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PicosAddButtonBar(
        disabled: saveDisabled,
        onTap: () {
          FollowUp newFollowUp = followUp.copyWith(
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
          BackendFollowUpApi.saveFollowUp(newFollowUp);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
