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
import 'package:picos/api/backend_patients_list_api.dart';
import 'package:picos/models/patient_data.dart';
import 'package:picos/models/patient_profile.dart';
import 'package:picos/models/patients_list_element.dart';
import 'package:picos/state/objects_list_bloc.dart';
import 'package:picos/widgets/picos_add_button_bar.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:picos/widgets/picos_select.dart';
import 'package:picos/widgets/picos_text_field.dart';

/// A screen for adding new patient.
class AddPatientScreen extends StatefulWidget {
  /// Creates the AddPatientScreen.
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

  /// Local variable for case number.
  late String _caseNumber;

  /// Local variable for Patient ID.
  late String _patientID;

  /// Local vcariable for institute key.
  late String _instituteKey;

  /// Local variable for body height.
  late double _bodyHeight;

  /// Determines if you are able to add the patient.
  bool _addDisabled = true;

  String? _title;

  PatientsListElement? _patientsListElement;

  Future<bool> _patientListElementInformation(
    PatientsListElement patListElement,
  ) async {
    if (_patientsListElement != null) return true;

    _weightBMI = patListElement.patientProfile.weightBMIEnabled;
    _heartFrequency = patListElement.patientProfile.heartFrequencyEnabled;
    _bloodPressure = patListElement.patientProfile.bloodPressureEnabled;
    _bloodSugarLevels = patListElement.patientProfile.bloodSugarLevelsEnabled;
    _walkDistance = patListElement.patientProfile.walkDistanceEnabled;
    _sleepDuration = patListElement.patientProfile.sleepDurationEnabled;
    _sleepQuality = patListElement.patientProfile.sleepQualityEnabled;
    _pain = patListElement.patientProfile.painEnabled;
    _phq4 = patListElement.patientProfile.phq4Enabled;
    _medication = patListElement.patientProfile.medicationEnabled;
    _therapy = patListElement.patientProfile.therapyEnabled;
    _doctorsVisit = patListElement.patientProfile.doctorsVisitEnabled;

    _bodyHeight = patListElement.patientData.bodyHeight;
    _patientID = patListElement.patientData.patientID;
    _caseNumber = patListElement.patientData.caseNumber;
    _instituteKey = patListElement.patientData.instKey;

    return true;
  }

  @override
  Widget build(BuildContext context) {
    _title ??= AppLocalizations.of(context)!.editPatientInformation;

    _patientsListElement =
        ModalRoute.of(context)!.settings.arguments as PatientsListElement;

    return FutureBuilder<bool>(
      future: _patientListElementInformation(_patientsListElement!),
      builder: ((BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData && !snapshot.hasError) {
          return const CircularProgressIndicator();
        }

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
                      _heartFrequency = value;
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
                const SizedBox(
                  height: 25,
                ),
                SwitchListTile(
                  value: _bloodPressure,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _bloodPressure = value;
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
                const SizedBox(
                  height: 25,
                ),
                SwitchListTile(
                  value: _bloodSugarLevels,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _bloodSugarLevels = value;
                    });
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
                const SizedBox(
                  height: 25,
                ),
                PicosLabel(AppLocalizations.of(context)!.activityAndRest),
                const SizedBox(
                  height: 10,
                ),
                SwitchListTile(
                  value: _walkDistance,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _walkDistance = value;
                    });
                  },
                  secondary: const Icon(Icons.directions_walk_outlined),
                  title: Text(
                    AppLocalizations.of(context)!.walkDistance,
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
                  value: _sleepDuration,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _sleepDuration = value;
                    });
                  },
                  secondary: const Icon(Icons.access_alarm_outlined),
                  title: Text(
                    AppLocalizations.of(context)!.sleepDuration,
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
                  value: _sleepQuality,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _sleepQuality = value;
                    });
                  },
                  secondary: const Icon(Icons.bed_outlined),
                  title: Text(
                    AppLocalizations.of(context)!.sleepQuality,
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
                PicosLabel(AppLocalizations.of(context)!.bodyAndMind),
                const SizedBox(
                  height: 10,
                ),
                SwitchListTile(
                  value: _pain,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _pain = value;
                    });
                  },
                  secondary: const Icon(Icons.mood_bad_outlined),
                  title: Text(
                    AppLocalizations.of(context)!.pain,
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
                  value: _phq4,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _phq4 = value;
                    });
                  },
                  secondary: const Icon(Icons.psychology_outlined),
                  title: const Text(
                    'PHQ-4',
                    style: TextStyle(
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
                PicosLabel(
                  AppLocalizations.of(context)!.medicationAndTherapy,
                ),
                const SizedBox(
                  height: 10,
                ),
                SwitchListTile(
                  value: _medication,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _medication = value;
                    });
                  },
                  secondary: const Icon(Icons.medication),
                  title: Text(
                    AppLocalizations.of(context)!.medication,
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
                  value: _therapy,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _therapy = value;
                    });
                  },
                  secondary: const Icon(Icons.healing_outlined),
                  title: Text(
                    AppLocalizations.of(context)!.therapy,
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
                  value: _doctorsVisit,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _doctorsVisit = value;
                    });
                  },
                  secondary: const Icon(Icons.local_hospital_outlined),
                  title: Text(
                    AppLocalizations.of(context)!.doctorsVisit,
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
                PicosLabel(AppLocalizations.of(context)!.caseNumber),
                PicosTextField(
                  hint: _caseNumber,
                  onChanged: (String? value) {
                    setState(() {
                      _addDisabled = false;
                    });

                    _caseNumber = value!;
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.enterCaseNumber;
                    }
                    return null;
                  },
                ),
                PicosLabel(AppLocalizations.of(context)!.patientID),
                PicosTextField(
                  hint: _patientID,
                  onChanged: (String? value) {
                    setState(() {
                      _addDisabled = false;
                    });

                    _patientID = value!;
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.enterPatientID;
                    }
                    return null;
                  },
                ),
                PicosLabel(AppLocalizations.of(context)!.instituteKey),
                PicosSelect(
                  selection: const <String, String>{
                    '1': '100',
                    '2': '101',
                    '3': '102',
                    '4': '103',
                    '5': '104',
                    '6': '105',
                    '7': '201',
                    '8': '300',
                    '9': '400',
                    '10': '501',
                    '11': '502'
                  },
                  callBackFunction: (String? value) {
                    setState(() {
                      _addDisabled = false;
                    });

                    _instituteKey = value!;
                  },
                  hint: _instituteKey,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return '''     ${AppLocalizations.of(context)!.enterInstituteKey}''';
                    }
                    return null;
                  },
                ),
                PicosLabel(AppLocalizations.of(context)!.height),
                PicosTextField(
                  hint: _bodyHeight.toString(),
                  onChanged: (String? value) {
                    setState(() {
                      _addDisabled = false;
                    });

                    _bodyHeight = double.parse(value!);
                  },
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value == null) {
                      return AppLocalizations.of(context)!.enterHeight;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          title: _title,
          bottomNavigationBar: PicosAddButtonBar(
            disabled: _addDisabled,
            onTap: () {
              PatientData updatedPatientData = PatientData(
                bodyHeight: _bodyHeight,
                patientID: _patientID,
                caseNumber: _caseNumber,
                instKey: _instituteKey,
              );

              PatientProfile updatedPatientProfile = PatientProfile(
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
                patientObjectId:
                    _patientsListElement!.patientData.patientObjectId!,
                doctorObjectId:
                    _patientsListElement!.patientData.doctorObjectId!,
              );

              PatientsListElement patientsListElement = PatientsListElement(
                patient: _patientsListElement!.patient,
                patientData: updatedPatientData,
                patientProfile: updatedPatientProfile,
              );

              if (_patientsListElement != null) {
                updatedPatientData.copyWith(
                  bodyHeight: _bodyHeight,
                  patientID: _patientID,
                  caseNumber: _caseNumber,
                  instKey: _instituteKey,
                );

                updatedPatientProfile.copyWith(
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
                  patientObjectId:
                      _patientsListElement!.patientData.patientObjectId!,
                  doctorObjectId:
                      _patientsListElement!.patientData.doctorObjectId!,
                );

                patientsListElement = patientsListElement.copyWith(
                  patient: _patientsListElement!.patient,
                  patientData: updatedPatientData,
                  patientProfile: updatedPatientProfile,
                  objectId: _patientsListElement!.patient.objectId,
                  createdAt: _patientsListElement!.patient.createdAt,
                  updatedAt: _patientsListElement!.patient.updatedAt,
                );
              }

              context
                  .read<ObjectsListBloc<BackendPatientsListApi>>()
                  .add(SaveObject(patientsListElement));
              Navigator.of(context).pop();
            },
          ),
        );
      }),
    );
  }
}
