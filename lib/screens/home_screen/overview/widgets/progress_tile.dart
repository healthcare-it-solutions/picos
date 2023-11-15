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

import 'package:picos/models/patient_profile.dart';
import 'package:picos/util/backend.dart';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:picos/models/daily_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../themes/global_theme.dart';

/// A list tile for showing the questionnaire progress.
class ProgressTile extends StatefulWidget {
  /// Creates ProgressTile.
  const ProgressTile({required this.dailyInput, Key? key}) : super(key: key);

  /// The [DailyInput] used to create the tile.
  final DailyInput dailyInput;

  @override
  State<ProgressTile> createState() => _ProgressTileState();
}

class _ProgressTileState extends State<ProgressTile> {
  PatientProfile? _patientProfile;

  String _getDateTitle(DateTime date) {
    return '${date.day}.${date.month}.';
  }

  String _getWeekDay(DateTime date) {
    return DateFormat.E(Platform.localeName).format(date);
  }

  Color _getTileColor(GlobalTheme theme, ProgressTileState state) {
    switch (state) {
      case ProgressTileState.filled:
        return theme.green1!;
      case ProgressTileState.partiallyFilled:
        return const Color(0xFFf29100);
      case ProgressTileState.empty:
        return const Color(0xFFe63329);
    }
  }

  Future<int> _countPatientProfileValues() async {
    int counterEnabledValues = 0;
    if (Backend.user.objectId != null) {
      dynamic responsePatient = await Backend.getEntry(
        PatientProfile.databaseTable,
        'Patient',
        Backend.user.objectId!,
      );
      dynamic element = await responsePatient.results?.first;
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

      //if (_patientProfile!.weightBMIEnabled) counterEnabledValues++;
      if (_patientProfile!.heartFrequencyEnabled) counterEnabledValues++;
      if (_patientProfile!.bloodPressureEnabled) {
        counterEnabledValues = counterEnabledValues + 2;
      }
      if (_patientProfile!.bloodSugarLevelsEnabled) counterEnabledValues++;
      //if (_patientProfile!.walkDistanceEnabled) counterEnabledValues++;
      if (_patientProfile!.sleepDurationEnabled) counterEnabledValues++;
      if (_patientProfile!.sleepQualityEnabled) counterEnabledValues++;
      //if (_patientProfile!.painEnabled) counterEnabledValues++;
      if (_patientProfile!.phq4Enabled) counterEnabledValues++;
      /*if (_patientProfile!.medicationEnabled) counterEnabledValues++;
      if (_patientProfile!.therapyEnabled) counterEnabledValues++;
      if (_patientProfile!.doctorsVisitEnabled) counterEnabledValues++;*/
    }

    return counterEnabledValues;
  }

  Future<int> _countPHQ4PatientProfileValues() async {
    int counterEnabledValues = 0;
    if (Backend.user.objectId != null) {
      dynamic responsePatient = await Backend.getEntry(
        PatientProfile.databaseTable,
        'Patient',
        Backend.user.objectId!,
      );
      dynamic element = await responsePatient.results?.first;
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

      if (_patientProfile!.phq4Enabled) counterEnabledValues = 4;
    }

    return counterEnabledValues;
  }

  Future<int> _countWeeklyPatientProfileValues() async {
    int counterEnabledValues = 0;
    if (Backend.user.objectId != null) {
      dynamic responsePatient = await Backend.getEntry(
        PatientProfile.databaseTable,
        'Patient',
        Backend.user.objectId!,
      );
      dynamic element = await responsePatient.results?.first;
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

      if (_patientProfile!.weightBMIEnabled) counterEnabledValues++;
      if (_patientProfile!.weightBMIEnabled) counterEnabledValues++;
      if (_patientProfile!.sleepQualityEnabled) counterEnabledValues++;
      if (_patientProfile!.walkDistanceEnabled) counterEnabledValues++;
    }

    return counterEnabledValues;
  }

  Future<ProgressTileState>? _progressTileState;

  Future<ProgressTileState> _createProgressTileState() async {
    if ((widget.dailyInput.daily != null &&
                !widget.dailyInput.daily!.hasNullValues &&
                await _countPatientProfileValues() ==
                    widget.dailyInput.daily!.countDailyValues) &&
            !widget.dailyInput.weeklyDay ||
        (widget.dailyInput.weekly != null &&
                !widget.dailyInput.weekly!.hasNullValues &&
                await _countWeeklyPatientProfileValues() ==
                    widget.dailyInput.weekly!.countWeeklyValues) &&
            !widget.dailyInput.phq4Day ||
        (widget.dailyInput.phq4 != null &&
            !widget.dailyInput.phq4!.hasNullValues &&
            await _countPHQ4PatientProfileValues() ==
                widget.dailyInput.phq4!.countPHQ4Values)) {
      return ProgressTileState.filled;
    }

    if ((widget.dailyInput.daily != null &&
            widget.dailyInput.daily!.hasAnyValue &&
            await _countPatientProfileValues() !=
                widget.dailyInput.daily!.countDailyValues) ||
        (widget.dailyInput.weeklyDay &&
            widget.dailyInput.weekly != null &&
            widget.dailyInput.weekly!.hasAnyValue &&
            await _countWeeklyPatientProfileValues() !=
                widget.dailyInput.weekly!.countWeeklyValues) ||
        (widget.dailyInput.phq4Day &&
            widget.dailyInput.phq4 != null &&
            widget.dailyInput.phq4!.hasAnyValue &&
            await _countPHQ4PatientProfileValues() !=
                widget.dailyInput.phq4!.countPHQ4Values)) {
      return ProgressTileState.partiallyFilled;
    }

    return ProgressTileState.empty;
  }

  @override
  void initState() {
    super.initState();
    _countPatientProfileValues();
    _progressTileState = _createProgressTileState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProgressTileState>(
      future: _progressTileState,
      builder: (BuildContext ctx, AsyncSnapshot<ProgressTileState> snapshot) {
        if (snapshot.hasData) {
          final ProgressTileState state = snapshot.data!;
          final DateTime date =
              DateTime.now().subtract(Duration(days: widget.dailyInput.day));
          final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
          final double size = ProgressTileState.filled == state ? 80 : 50;
          String title;

          switch (widget.dailyInput.day) {
            case 0:
              title = AppLocalizations.of(context)!.today;
              break;
            case 1:
              title = AppLocalizations.of(context)!.yesterday;
              break;
            case 2:
              if (Platform.localeName == 'de_DE' ||
                  Platform.localeName == 'de-DE' ||
                  Platform.localeName == 'de') {
                title = 'Vorgestern';
                break;
              }
              title = _getDateTitle(date);
              break;
            default:
              title = _getDateTitle(date);
          }

          return Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 95,
                  child: SizedBox(
                    height: size,
                    width: size + 20,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/questionnaire-screen/questionnaire-screen',
                          arguments: widget.dailyInput,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: _getTileColor(theme, state),
                        foregroundColor: theme.white,
                      ),
                      child: Text(
                        _getWeekDay(date),
                        style: const TextStyle(fontSize: 25),
                        overflow: TextOverflow.visible,
                        softWrap: false,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: theme.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('Error');
        }
        // TODO: Omit it!
        return const Text('Irgendetwas');
      },
    );
  }
}

/// An comparable state for the [ProgressTile].
enum ProgressTileState {
  /// If [DailyInput] has no values.
  empty,

  /// If [DailyInput] has at least one partially filled value.
  partiallyFilled,

  /// If all [DailyInput] values has been filled.
  filled,
}
