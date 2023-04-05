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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/api/backend_patient_profile_api.dart';
import 'package:picos/models/patient.dart';
import 'package:picos/models/patient_profile.dart';
import 'package:picos/state/objects_list_bloc.dart';
import 'package:picos/util/backend.dart';
import 'package:picos/widgets/picos_add_button_bar.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_screen_frame.dart';

/// A screen for adding new medication schedules.
class AddPatientScreen extends StatefulWidget {
  /// Creates the AddMedicationScreen.
  const AddPatientScreen({Key? key}) : super(key: key);

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  /// Local variable for weight and BMI.
  late bool _weightBMI;

  /// Local variable for heart frequency.
  late bool _heartFrequency;

  /// Local variable for blood pressure.
  late bool _bloodPressure;

  /// Local variable for blood sugar levels.
  late bool _bloodSugarLevels;

  /// Local variable for walk distance.
  late bool _walkDistance;

  /// Local variable for sleep duration.
  late bool _sleepDuration;

  /// Local variable for sleep quality.
  late bool _sleepQuality;

  /// Local variable for pain.
  late bool _pain;

  /// Local variable for blood PHQ4.
  late bool _phq4;

  /// Local variable for medication.
  late bool _medication;

  /// Local variable for therapy.
  late bool _therapy;

  /// Local variable for doctor visits.
  late bool _doctorsVisit;

  late String _caseNumber;

  late String _patientID;

  late String _instituteKey;

  late String height;

  /// Determines if you are able to add the medication.
  bool _addDisabled = true;

  String? _title;

  Patient? _patientEdit;

  Map<String, dynamic>? _patientProfileElement;

  Future<bool> _allProfileQEntries() async {
    if (_patientProfileElement != null) return true;

    List<dynamic> listPatientProfile =
        await Backend.getAll(PatientProfile.databaseTable);

    _patientProfileElement = listPatientProfile.firstWhere(
      (dynamic element) =>
          element['Patient']['objectId'] == _patientEdit!.objectId,
    );

    _weightBMI = _patientProfileElement!['Weight_BMI'];
    _heartFrequency = _patientProfileElement!['HeartRate'];
    _bloodPressure = _patientProfileElement!['BloodPressure'];
    _bloodSugarLevels = _patientProfileElement!['BloodSugar'];
    _walkDistance = _patientProfileElement!['WalkingDistance'];
    _sleepDuration = _patientProfileElement!['SleepDuration'];
    _sleepQuality = _patientProfileElement!['SISQS'];
    _pain = _patientProfileElement!['Pain'];
    _phq4 = _patientProfileElement!['PHQ4'];
    _medication = _patientProfileElement!['Medication'];
    _therapy = _patientProfileElement!['Therapies'];
    _doctorsVisit = _patientProfileElement!['Stays'];

    return true;
  }

  @override
  Widget build(BuildContext context) {
    _title ??= 'Edit Patient information';

    _patientEdit = ModalRoute.of(context)!.settings.arguments as Patient;

    return FutureBuilder<bool>(
      future: _allProfileQEntries(),
      builder: ((BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData && !snapshot.hasError) {
          return const CircularProgressIndicator();
        }

        return BlocBuilder<ObjectsListBloc<BackendPatientProfileApi>,
            ObjectsListState>(
          builder: (BuildContext context, ObjectsListState state) {
            return PicosScreenFrame(
              body: PicosBody(
                child: Column(
                  children: <Widget>[
                    PicosLabel(AppLocalizations.of(context)!.vitalValues),
                    SwitchListTile(
                      value: _weightBMI,
                      onChanged: (bool value) {
                        setState(() {
                          _addDisabled = false;
                          _weightBMI = value;
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
                    const SizedBox(
                      height: 25,
                    ),
                    SwitchListTile(
                      value: _heartFrequency,
                      onChanged: (bool value) {
                        setState(() {
                          _addDisabled = false;
                        });
                        _heartFrequency = value;
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
                    const SizedBox(
                      height: 25,
                    ),
                    SwitchListTile(
                      value: _bloodPressure,
                      onChanged: (bool value) {
                        setState(() {
                          _addDisabled = false;
                        });
                        _bloodPressure = value;
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
                    const SizedBox(
                      height: 25,
                    ),
                    SwitchListTile(
                      value: _bloodSugarLevels,
                      onChanged: (bool value) {
                        setState(() {
                          _addDisabled = false;
                        });
                        _bloodSugarLevels = value;
                      },
                      secondary: const Icon(Icons.device_thermostat_outlined),
                      title: Text(
                        AppLocalizations.of(context)!.bloodSugar,
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
              title: _title,
              bottomNavigationBar: PicosAddButtonBar(
                disabled: _addDisabled,
                onTap: () {
                  PatientProfile patientProfile = PatientProfile(
                    weightBMIEnabled: _weightBMI,
                    heartFrequencyEnabled: _heartFrequency,
                    bloodPressureEnabled: _bloodPressure,
                    bloodSugarLevelsEnabled: _bloodSugarLevels,
                    walkDistanceEnabled: _walkDistance,
                    sleepDurationEnabled: _sleepDuration,
                    sleepQualityEnabled: _sleepQuality,
                    painEnabled: _pain,
                    phq4Enabled: _phq4,
                    medicationEnabled: _medication,
                    therapyEnabled: _therapy,
                    doctorsVisitEnabled: _doctorsVisit,
                    patientObjectId: _patientProfileElement!['Patient']
                        ['ObjectId'],
                    doctorObjectId: _patientProfileElement!['Doctor']
                        ['ObjectId'],
                  );

                  if (_patientEdit != null) {
                    patientProfile = patientProfile.copyWith(
                      weightBMIEnabled: _weightBMI,
                      heartFrequencyEnabled: _heartFrequency,
                      bloodPressureEnabled: _bloodPressure,
                      bloodSugarLevelsEnabled: _bloodSugarLevels,
                      walkDistanceEnabled: _walkDistance,
                      sleepDurationEnabled: _sleepDuration,
                      sleepQualityEnabled: _sleepQuality,
                      painEnabled: _pain,
                      phq4Enabled: _phq4,
                      medicationEnabled: _medication,
                      therapyEnabled: _therapy,
                      doctorsVisitEnabled: _doctorsVisit,
                      patientObjectId: _patientProfileElement!['Patient']
                          ['objectId'],
                      doctorObjectId: _patientProfileElement!['Doctor']
                          ['objectId'],
                    );
                  }

                  context
                      .read<ObjectsListBloc<BackendPatientProfileApi>>()
                      .add(SaveObject(patientProfile));
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        );
      }),
    );
  }
}
