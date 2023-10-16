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
import 'package:picos/models/patient_profile.dart';
import 'package:picos/models/patients_list_element.dart';
import 'package:picos/state/objects_list_bloc.dart';
import 'package:picos/widgets/picos_add_button_bar.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_ink_well_button.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:picos/widgets/picos_switch.dart';

/// A screen for adding new patient.
class EditPatientScreen extends StatefulWidget {
  /// Creates the AddPatientScreen.
  const EditPatientScreen({Key? key}) : super(key: key);

  /// global patientObjectId.
  static String? patientObjectId;

  /// global body height.
  static double? bodyHeight;

  /// global patient ID.
  static String? patientID;

  /// global case number.
  static String? caseNumber;

  /// global institute key.
  static String? instituteKey;

  @override
  State<EditPatientScreen> createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {
  /// Local variable for weight and BMI.
  bool _weightBMI = false;

  /// Local variable for heart frequency.
  bool _heartFrequency = false;

  /// Local variable for blood pressure.
  bool _bloodPressure = false;

  /// Local variable for blood sugar levels.
  bool _bloodSugarLevels = false;

  /// Local variable for walk distance.
  bool _walkDistance = false;

  /// Local variable for sleep duration.
  bool _sleepDuration = false;

  /// Local variable for sleep quality.
  bool _sleepQuality = false;

  /// Local variable for pain.
  bool _pain = false;

  /// Local variable for blood PHQ4.
  bool _phq4 = false;

  /// Local variable for medication.
  bool _medication = false;

  /// Local variable for therapy.
  bool _therapy = false;

  /// Local variable for doctor visits.
  bool _doctorsVisit = false;

  /// Determines if you are able to add the patient.
  bool _addDisabled = true;

  String? _title;

  PatientsListElement? _patientsListElement;

  Column _picosSwitchAndSizedBox(
    bool valueProfile,
    Function(bool value)? function,
    String title,
    ShapeBorder shape,
  ) {
    return Column(
      children: <Widget>[
        PicosSwitch(
          initialValue: valueProfile,
          onChanged: function,
          title: title,
          shape: shape,
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_patientsListElement == null) {
      PatientsListElement? patientsListElement =
          ModalRoute.of(context)!.settings.arguments as PatientsListElement;

      _patientsListElement = patientsListElement;

      _title = '${_patientsListElement!.patient.firstName} '
          '${_patientsListElement!.patient.familyName}';

      _weightBMI = _patientsListElement!.patientProfile.weightBMIEnabled;
      _heartFrequency =
          _patientsListElement!.patientProfile.heartFrequencyEnabled;
      _bloodPressure =
          _patientsListElement!.patientProfile.bloodPressureEnabled;
      _bloodSugarLevels =
          _patientsListElement!.patientProfile.bloodSugarLevelsEnabled;
      _walkDistance = _patientsListElement!.patientProfile.walkDistanceEnabled;
      _sleepDuration =
          _patientsListElement!.patientProfile.sleepDurationEnabled;
      _sleepQuality = _patientsListElement!.patientProfile.sleepQualityEnabled;
      _pain = _patientsListElement!.patientProfile.painEnabled;
      _phq4 = _patientsListElement!.patientProfile.phq4Enabled;
      _medication = _patientsListElement!.patientProfile.medicationEnabled;
      _therapy = _patientsListElement!.patientProfile.therapyEnabled;
      _doctorsVisit = _patientsListElement!.patientProfile.doctorsVisitEnabled;

      EditPatientScreen.patientObjectId =
          _patientsListElement!.patient.objectId;
      EditPatientScreen.bodyHeight =
          _patientsListElement!.patientData.bodyHeight;
      EditPatientScreen.patientID = _patientsListElement!.patientData.patientID;
      EditPatientScreen.caseNumber =
          _patientsListElement!.patientData.caseNumber;
      EditPatientScreen.instituteKey =
          _patientsListElement!.patientData.instKey;
    }

    return BlocBuilder<ObjectsListBloc<BackendPatientsListApi>,
        ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        if (state.status == ObjectsListStatus.initial ||
            state.status == ObjectsListStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == ObjectsListStatus.failure) {
          return const Center(
            child: Text('Error'),
          );
        }

        return PicosScreenFrame(
          body: PicosBody(
            child: Column(
              children: <Widget>[
                PicosLabel(AppLocalizations.of(context)!.vitalValues),
                _picosSwitchAndSizedBox(
                  _weightBMI,
                  _weightBMI
                      ? null
                      : (bool value) {
                          setState(() {
                            _addDisabled = false;
                            _weightBMI = value;
                          });
                        },
                  AppLocalizations.of(context)!.weightBMI,
                  const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                _picosSwitchAndSizedBox(
                  _heartFrequency,
                  (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _heartFrequency = value;
                    });
                  },
                  AppLocalizations.of(context)!.heartFrequency,
                  const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                _picosSwitchAndSizedBox(
                  _bloodPressure,
                  (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _bloodPressure = value;
                    });
                  },
                  AppLocalizations.of(context)!.bloodPressure,
                  const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                _picosSwitchAndSizedBox(
                  _bloodSugarLevels,
                  (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _bloodSugarLevels = value;
                    });
                  },
                  AppLocalizations.of(context)!.bloodSugar,
                  const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                PicosLabel(AppLocalizations.of(context)!.activityAndRest),
                const SizedBox(
                  height: 10,
                ),
                _picosSwitchAndSizedBox(
                  _walkDistance,
                  (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _walkDistance = value;
                    });
                  },
                  AppLocalizations.of(context)!.walkDistance,
                  const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                _picosSwitchAndSizedBox(
                  _sleepDuration,
                  _sleepDuration
                      ? null
                      : (bool value) {
                          setState(() {
                            _addDisabled = false;
                            _sleepDuration = value;
                          });
                        },
                  AppLocalizations.of(context)!.sleepDuration,
                  const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                _picosSwitchAndSizedBox(
                  _sleepQuality,
                  _sleepQuality
                      ? null
                      : (bool value) {
                          setState(() {
                            _addDisabled = false;
                            _sleepQuality = value;
                          });
                        },
                  AppLocalizations.of(context)!.sleepQuality,
                  const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                PicosLabel(AppLocalizations.of(context)!.bodyAndMind),
                const SizedBox(
                  height: 10,
                ),
                _picosSwitchAndSizedBox(
                  _pain,
                  _pain
                      ? null
                      : (bool value) {
                          setState(() {
                            _addDisabled = false;
                            _pain = value;
                          });
                        },
                  AppLocalizations.of(context)!.pain,
                  const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                _picosSwitchAndSizedBox(
                  _phq4,
                  _phq4
                      ? null
                      : (bool value) {
                          setState(() {
                            _addDisabled = false;
                            _phq4 = value;
                          });
                        },
                  'PHQ-4',
                  const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                PicosLabel(
                  AppLocalizations.of(context)!.medicationAndTherapy,
                ),
                const SizedBox(
                  height: 10,
                ),
                _picosSwitchAndSizedBox(
                  _medication,
                  _medication
                      ? null
                      : (bool value) {
                          setState(() {
                            _addDisabled = false;
                            _medication = value;
                          });
                        },
                  AppLocalizations.of(context)!.medication,
                  const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                _picosSwitchAndSizedBox(
                  _therapy,
                  _therapy
                      ? null
                      : (bool value) {
                          setState(() {
                            _addDisabled = false;
                            _therapy = value;
                          });
                        },
                  AppLocalizations.of(context)!.therapy,
                  const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                _picosSwitchAndSizedBox(
                  _doctorsVisit,
                  _doctorsVisit
                      ? null
                      : (bool value) {
                          setState(() {
                            _addDisabled = false;
                            _doctorsVisit = value;
                          });
                        },
                  AppLocalizations.of(context)!.doctorsVisit,
                  const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                PicosInkWellButton(
                  text: 'Zum Catalog of Items',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/study-nurse-screen/catalog-of-items',
                    );
                  },
                ),
              ],
            ),
          ),
          title: _title,
          bottomNavigationBar: PicosAddButtonBar(
            disabled: _addDisabled,
            onTap: () {
              if (_patientsListElement != null) {
                PatientProfile newPatientProfile;
                newPatientProfile =
                    _patientsListElement!.patientProfile.copyWith(
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
                );

                PatientsListElement newPatientListElement;

                newPatientListElement = _patientsListElement!.copyWith(
                  patientProfile: newPatientProfile,
                );

                context
                    .read<ObjectsListBloc<BackendPatientsListApi>>()
                    .add(SaveObject(newPatientListElement));
                Navigator.of(context).pop();
              }
            },
          ),
        );
      },
    );
  }
}
