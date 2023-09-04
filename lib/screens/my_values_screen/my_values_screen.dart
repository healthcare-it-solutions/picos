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
import 'package:picos/util/backend.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/patient_profile.dart';
import '../../widgets/picos_display_card.dart';
import '../../widgets/picos_info_card.dart';
import '../../widgets/picos_screen_frame.dart';
import '../../widgets/picos_svg_icon.dart';

/// This is the screen for the user's profile information.
class MyValuesScreen extends StatefulWidget {
  /// Constructor for Profile Screen.
  const MyValuesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MyValuesScreen> createState() => _MyValuesScreenState();
}

class _MyValuesScreenState extends State<MyValuesScreen> {
  bool _weightBMIEnabled = false;
  bool _heartFrequencyEnabled = false;
  bool _bloodPressureEnabled = false;
  bool _bloodSugarLevelsEnabled = false;
  bool _walkDistanceEnabled = false;
  bool _sleepDurationEnabled = false;

  PatientProfile? _patientProfile;

  bool? _weightBMIEnabledBackend;
  bool? _heartFrequencyEnabledBackend;
  bool? _bloodPressureEnabledBackend;
  bool? _bloodSugarLevelsEnabledBackend;
  bool? _walkDistanceEnabledBackend;
  bool? _sleepDurationEnabledBackend;

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _weightBMIEnabled = prefs.getBool('weight_bmi') ?? false;
      _heartFrequencyEnabled = prefs.getBool('heart_frequency') ?? false;
      _bloodPressureEnabled = prefs.getBool('blood_pressure') ?? false;
      _bloodSugarLevelsEnabled = prefs.getBool('blood_sugar') ?? false;
      _walkDistanceEnabled = prefs.getBool('walk_distance') ?? false;
      _sleepDurationEnabled = prefs.getBool('sleep_duration') ?? false;
    });
  }

  Future<void> _savePreference(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  Future<void> _fetchPatientProfile() async {
    if (Backend.user.objectId != null) {
      dynamic responsePatient = await Backend.getEntry(
        PatientProfile.databaseTable,
        'Patient',
        Backend.user.objectId!,
      );
      dynamic element = responsePatient.results?.first;
      if (element != null) {
        _patientProfile = PatientProfile(
          weightBMIEnabled: element['Weight_BMI'],
          heartFrequencyEnabled: element['HeartRate'],
          bloodPressureEnabled: element['BloodPressure'],
          bloodSugarLevelsEnabled: element['BloodSugar'],
          walkDistanceEnabled: element['WalkingDistance'],
          sleepDurationEnabled: element['SleepDuration'],
          sleepQualityEnabled: element['SISQS'],
          painEnabled: element['Pain'],
          phq4Enabled: element['PHQ4'],
          medicationEnabled: element['Medication'],
          therapyEnabled: element['Therapies'],
          doctorsVisitEnabled: element['Stays'],
          patientObjectId: element['Patient']['objectId'],
          doctorObjectId: element['Doctor']['objectId'],
          objectId: element['objectId'],
          createdAt: element['createdAt'],
          updatedAt: element['updatedAt'],
        );
      }

      setState(() {
        _weightBMIEnabledBackend = _patientProfile!.weightBMIEnabled;
        _heartFrequencyEnabledBackend = _patientProfile!.heartFrequencyEnabled;
        _bloodPressureEnabledBackend = _patientProfile!.bloodPressureEnabled;
        _bloodSugarLevelsEnabledBackend =
            _patientProfile!.bloodSugarLevelsEnabled;
        _walkDistanceEnabledBackend = _patientProfile!.walkDistanceEnabled;
        _sleepDurationEnabledBackend = _patientProfile!.sleepDurationEnabled;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _fetchPatientProfile();
  }

  @override
  Widget build(BuildContext context) {
    if (_patientProfile == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return PicosScreenFrame(
      title: AppLocalizations.of(context)!.myMedicalData,
      body: PicosBody(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            child: Material(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  PicosDisplayCard(
                    backgroundColor: Theme.of(context).dialogBackgroundColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(
                            right: 13,
                          ),
                          child: Icon(
                            Icons.info,
                            color: PicosInfoCard.infoTextFontColor,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.infoMyValue,
                            style: const TextStyle(
                              color: PicosInfoCard.infoTextFontColor,
                              fontSize: 16.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SwitchListTile(
                    value:
                        _weightBMIEnabled && (_weightBMIEnabledBackend ?? true),
                    onChanged: _weightBMIEnabledBackend == false
                        ? null
                        : (bool value) {
                            setState(() {
                              _weightBMIEnabled = value;
                            });
                            _savePreference('weight_bmi', value);
                          },
                    secondary: const PicosSvgIcon(
                      assetName: 'assets/Gewicht.svg',
                      height: 25,
                      width: 25,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.weightBMI,
                      style: const TextStyle(
                        fontSize: PicosInfoCard.infoTextFontSize,
                      ),
                    ),
                    shape: const Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  SwitchListTile(
                    value: _heartFrequencyEnabled &&
                        (_heartFrequencyEnabledBackend ?? true),
                    onChanged: _heartFrequencyEnabledBackend == false
                        ? null
                        : (bool value) {
                            setState(() {
                              _heartFrequencyEnabled = value;
                            });
                            _savePreference('heart_frequency', value);
                          },
                    secondary: const PicosSvgIcon(
                      assetName: 'assets/Herzfrequenz.svg',
                      height: 25,
                      width: 25,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.heartFrequency,
                      style: const TextStyle(
                        fontSize: PicosInfoCard.infoTextFontSize,
                      ),
                    ),
                    shape: const Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  SwitchListTile(
                    value: _bloodPressureEnabled &&
                        (_bloodPressureEnabledBackend ?? true),
                    onChanged: _bloodPressureEnabledBackend == false
                        ? null
                        : (bool value) {
                            setState(() {
                              _bloodPressureEnabled = value;
                            });
                            _savePreference('blood_pressure', value);
                          },
                    secondary: const PicosSvgIcon(
                      assetName: 'assets/Blutdruck.svg',
                      height: 25,
                      width: 25,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.bloodPressure,
                      style: const TextStyle(
                        fontSize: PicosInfoCard.infoTextFontSize,
                      ),
                    ),
                    shape: const Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  SwitchListTile(
                    value: _bloodSugarLevelsEnabled &&
                        (_bloodSugarLevelsEnabledBackend ?? true),
                    onChanged: _bloodSugarLevelsEnabledBackend == false
                        ? null
                        : (bool value) {
                            setState(() {
                              _bloodSugarLevelsEnabled = value;
                            });
                            _savePreference('blood_sugar', value);
                          },
                    secondary: const PicosSvgIcon(
                      assetName: 'assets/Blutzucker.svg',
                      height: 25,
                      width: 25,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.bloodSugar,
                      style: const TextStyle(
                        fontSize: PicosInfoCard.infoTextFontSize,
                      ),
                    ),
                    shape: const Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  SwitchListTile(
                    value: _walkDistanceEnabled &&
                        (_walkDistanceEnabledBackend ?? true),
                    onChanged: _walkDistanceEnabledBackend == false
                        ? null
                        : (bool value) {
                            setState(() {
                              _walkDistanceEnabled = value;
                            });
                            _savePreference('walk_distance', value);
                          },
                    secondary: const PicosSvgIcon(
                      assetName: 'assets/Schritte.svg',
                      height: 25,
                      width: 25,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.walkDistance,
                      style: const TextStyle(
                        fontSize: PicosInfoCard.infoTextFontSize,
                      ),
                    ),
                    shape: const Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  SwitchListTile(
                    value: _sleepDurationEnabled &&
                        (_sleepDurationEnabledBackend ?? true),
                    onChanged: _sleepDurationEnabledBackend == false
                        ? null
                        : (bool value) {
                            setState(() {
                              _sleepDurationEnabled = value;
                            });
                            _savePreference('sleep_duration', value);
                          },
                    secondary: const PicosSvgIcon(
                      assetName: 'assets/Schlafdauer.svg',
                      height: 25,
                      width: 25,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.sleepDuration,
                      style: const TextStyle(
                        fontSize: PicosInfoCard.infoTextFontSize,
                      ),
                    ),
                    shape: const Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
