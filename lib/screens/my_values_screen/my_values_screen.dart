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
import '../../widgets/picos_switch.dart';

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
  final Map<String, bool> _preferences = <String, bool>{
    'weight_bmi': false,
    'heart_frequency': false,
    'blood_pressure': false,
    'blood_sugar': false,
    'walk_distance': false,
    'sleep_duration': false,
  };

  final Map<String, bool> _preferencesBackend = <String, bool>{
    'weight_bmi': false,
    'heart_frequency': false,
    'blood_pressure': false,
    'blood_sugar': false,
    'walk_distance': false,
    'sleep_duration': false,
  };

  PatientProfile? _patientProfile;

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (String key in _preferences.keys) {
        _preferences[key] = prefs.getBool(key) ?? false;
      }
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

        setState(() {
          _preferencesBackend['weight_bmi'] = _patientProfile!.weightBMIEnabled;
          _preferencesBackend['heart_frequency'] =
              _patientProfile!.heartFrequencyEnabled;
          _preferencesBackend['blood_pressure'] =
              _patientProfile!.bloodPressureEnabled;
          _preferencesBackend['blood_sugar'] =
              _patientProfile!.bloodSugarLevelsEnabled;
          _preferencesBackend['walk_distance'] =
              _patientProfile!.walkDistanceEnabled;
          _preferencesBackend['sleep_duration'] =
              _patientProfile!.sleepDurationEnabled;
        });
      }
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
                  ..._buildPreferenceSwitches(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPreferenceSwitches() {
    final Map<String, String> icons = <String, String>{
      'weight_bmi': 'assets/Gewicht.svg',
      'heart_frequency': 'assets/Herzfrequenz.svg',
      'blood_pressure': 'assets/Blutdruck.svg',
      'blood_sugar': 'assets/Blutzucker.svg',
      'walk_distance': 'assets/Schritte.svg',
      'sleep_duration': 'assets/Schlafdauer.svg',
    };

    final Map<String, String> titles = <String, String>{
      'weight_bmi': AppLocalizations.of(context)!.weightBMI,
      'heart_frequency': AppLocalizations.of(context)!.heartFrequency,
      'blood_pressure': AppLocalizations.of(context)!.bloodPressure,
      'blood_sugar': AppLocalizations.of(context)!.bloodSugar,
      'walk_distance': AppLocalizations.of(context)!.walkDistance,
      'sleep_duration': AppLocalizations.of(context)!.sleepDuration,
    };

    return _preferences.keys.map((String key) {
      return PicosSwitch(
        initialValue: _preferences[key]!,
        onChanged: _preferencesBackend[key] == false
            ? null
            : (bool value) {
                setState(() {
                  _preferences[key] = value;
                });
                _savePreference(key, value);
              },
        secondary: PicosSvgIcon(
          assetName: icons[key]!,
          height: 25,
          width: 25,
        ),
        title: titles[key]!,
        textStyle: const TextStyle(
          fontSize: PicosInfoCard.infoTextFontSize,
        ),
      );
    }).toList();
  }
}
