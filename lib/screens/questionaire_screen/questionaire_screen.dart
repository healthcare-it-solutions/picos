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

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:picos/models/phq4.dart';
import 'package:picos/models/weekly.dart';
import 'package:picos/screens/questionaire_screen/questionaire_page_storage.dart';
import 'package:picos/widgets/picos_screen_frame.dart';

import '../../models/daily.dart';
import '../../util/backend.dart';

/// This is the screen a user should see when prompted to provide some
/// information about their health status.
class QuestionaireScreen extends StatefulWidget {
  /// QuestionaireScreen constructor
  const QuestionaireScreen({Key? key}) : super(key: key);

  @override
  State<QuestionaireScreen> createState() => _QuestionaireScreenState();
}

class _QuestionaireScreenState extends State<QuestionaireScreen> {
  QuestionairePageStorage? _pageStorage;
  late Future<bool> _init;
  static final PageController _controller = PageController();
  static const Duration _controllerDuration = Duration(milliseconds: 300);
  static const Curve _controllerCurve = Curves.ease;

  // State
  String? _title;
  Weekly? _weekly;
  Daily? _daily;
  PHQ4? _phq4;
  final DateTime _now = DateTime.now();

  void _previousPage() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_controller.page == 0 ||
        _controller.page == _pageStorage!.pages.length - 1) {
      Navigator.of(context).pop();
      return;
    }

    _controller.previousPage(
      duration: _controllerDuration,
      curve: _controllerCurve,
    );
  }

  void _nextPage() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_controller.page == _pageStorage!.pages.length - 1) {
      Navigator.of(context).pop();
      return;
    }

    if (_controller.page == _pageStorage!.redirectingPages['medicationPage'] &&
        _pageStorage!.medicationChanged == true &&
        _pageStorage!.medicationUpdated == false) {
      _pageStorage!.medicationUpdated = true;
      Navigator.of(context).pushNamed('/my-medications-screen/my-medications');
    }

    if (_controller.page == _pageStorage!.redirectingPages['therapyPage'] &&
        _pageStorage!.therapyChanged == true &&
        _pageStorage!.therapyUpdated == false) {
      _pageStorage!.therapyUpdated = true;
      Navigator.of(context).pushNamed('/my-therapy-screen/my-therapy');
    }

    if (_controller.page == _pageStorage!.redirectingPages['doctorPage'] &&
        _pageStorage!.doctorVisited == true &&
        _pageStorage!.doctorVisitedUpdated == false) {
      _pageStorage!.doctorVisitedUpdated = true;
      Navigator.of(context).pushNamed('/visits-screen/visits');
    }

    _controller.nextPage(
      duration: _controllerDuration,
      curve: _controllerCurve,
    );
  }

  dynamic _filterCurrentObject(List<dynamic> objects) {
    objects.sort(
      (dynamic a, dynamic b) {
        return DateTime.parse(a['datetime']['iso'])
            .compareTo(DateTime.parse(b['datetime']['iso']));
      },
    );

    return objects.last;
  }

  Daily? _createDaily(List<dynamic> dailies) {
    dynamic currentDaily = _filterCurrentObject(dailies);

    Daily daily = Daily(
      heartFrequency: currentDaily['HeartRate']?['estimateNumber'],
      bloodSugar: currentDaily['BloodSugar']?['estimateNumber'],
      bloodSystolic: currentDaily['BloodPSystolic']?['estimateNumber'],
      bloodDiastolic: currentDaily['BloodPDiastolic']?['estimateNumber'],
      sleepDuration: currentDaily['SleepDuration']?['estimateNumber'],
      date: DateTime.parse(currentDaily['datetime']['iso']),
      pain: currentDaily['Pain']?['estimateNumber'],
      objectId: currentDaily['objectId'],
      createdAt: DateTime.parse(currentDaily['createdAt']),
      updatedAt: DateTime.parse(currentDaily['updatedAt']),
    );

    if (!daily.date.isBefore(
      DateTime(
        _now.year,
        _now.month,
        _now.day,
      ),
    )) {
      return daily;
    }

    return null;
  }

  Weekly? _createWeekly(List<dynamic> weeklies) {
    dynamic currentWeekly = _filterCurrentObject(weeklies);

    Weekly weekly = Weekly(
      bmi: currentWeekly['BMI']?['estimateNumber']?.toDouble(),
      bodyWeight: currentWeekly['BodyWeight']?['estimateNumber']?.toDouble(),
      sleepQuality: currentWeekly['SISQS']?['estimateNumber'],
      walkingDistance: currentWeekly['WalkingDistance']?['estimateNumber'],
      date: DateTime.parse(currentWeekly['datetime']['iso']),
      objectId: currentWeekly['objectId'],
      createdAt: DateTime.parse(currentWeekly['createdAt']),
      updatedAt: DateTime.parse(currentWeekly['updatedAt']),
    );

    if (!weekly.date.isBefore(
      DateTime(
        _now.year,
        _now.month,
        _now.day,
      ).subtract(const Duration(days: 7)),
    )) {
      return weekly;
    }

    return null;
  }

  PHQ4? _createPHQ4(List<dynamic> phq4s) {
    dynamic currentPhq4 = _filterCurrentObject(phq4s);

    PHQ4 phq4 = PHQ4(
      a: currentPhq4['a']?['estimateNumber'],
      b: currentPhq4['b']?['estimateNumber'],
      c: currentPhq4['c']?['estimateNumber'],
      d: currentPhq4['d']?['estimateNumber'],
      date: DateTime.parse(currentPhq4['datetime']['iso']),
      objectId: currentPhq4['objectId'],
      createdAt: DateTime.parse(currentPhq4['createdAt']),
      updatedAt: DateTime.parse(currentPhq4['updatedAt']),
    );

    if (!phq4.date.isBefore(
      DateTime(
        _now.year,
        _now.month,
        _now.day,
      ).subtract(const Duration(days: 14)),
    )) {
      return phq4;
    }

    return null;
  }

  // Class init.
  Future<bool> _classInit(BuildContext context) async {
    if (_pageStorage != null) {
      return true;
    }

    List<dynamic> dailyData = await Backend.getAll(Daily.databaseTable);
    List<dynamic> weeklyData = await Backend.getAll(Weekly.databaseTable);
    List<dynamic> phq4Data = await Backend.getAll(PHQ4.databaseTable);

    if (!mounted) {
      return false;
    }

    if (dailyData.isNotEmpty) {
      _daily = _createDaily(dailyData);
    }

    if (weeklyData.isNotEmpty) {
      _weekly = _createWeekly(weeklyData);
    }

    if (phq4Data.isNotEmpty) {
      _phq4 = _createPHQ4(phq4Data);
    }

    _pageStorage = await QuestionairePageStorage.create(
      _previousPage,
      _nextPage,
      context,
      _daily,
      _weekly,
      _phq4,
    );

    return true;
  }

  @override
  void initState() {
    super.initState();
    _init = _classInit(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _init,
      builder: (
        BuildContext context,
        AsyncSnapshot<bool> snapshot,
      ) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const CircularProgressIndicator();
        }

        // Instance init.
        _title ??= _pageStorage!.titles[0];

        return PicosScreenFrame(
          appBarElevation: 0.0,
          title: _title,
          body: PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int value) async {
              if (_title != _pageStorage!.titles[value]) {
                setState(() {
                  _title = _pageStorage!.titles[value];
                });
              }

              if (value == _pageStorage!.pages.length - 1) {
                DateTime date = DateTime.now();

                Daily daily = _daily == null
                    ? Daily(
                  date: date,
                  bloodDiastolic: _pageStorage!.selectedDias,
                  bloodSugar: _pageStorage!.selectedBloodSugar,
                  bloodSystolic: _pageStorage!.selectedSyst,
                  pain: _pageStorage!.selectedPain,
                  sleepDuration: _pageStorage!.selectedSleepDuration,
                  heartFrequency: _pageStorage!.selectedHeartFrequency,
                )
                    : _daily!.copyWith(
                  bloodDiastolic: _pageStorage!.selectedDias,
                  bloodSugar: _pageStorage!.selectedBloodSugar,
                  bloodSystolic: _pageStorage!.selectedSyst,
                  pain: _pageStorage!.selectedPain,
                  sleepDuration: _pageStorage!.selectedSleepDuration,
                  heartFrequency: _pageStorage!.selectedHeartFrequency,
                );

                Weekly weekly = _weekly == null
                    ? Weekly(
                  date: date,
                  bodyWeight: _pageStorage!.selectedBodyWeight,
                  bmi: _pageStorage!.selectedBMI,
                  sleepQuality: _pageStorage!.selectedSleepQuality,
                  walkingDistance: _pageStorage!.selectedWalkDistance,
                )
                    : _weekly!.copyWith(
                  bodyWeight: _pageStorage!.selectedBodyWeight,
                  bmi: _pageStorage!.selectedBMI,
                  sleepQuality: _pageStorage!.selectedSleepQuality,
                  walkingDistance: _pageStorage!.selectedWalkDistance,
                );

                PHQ4 phq4 = _phq4 == null
                    ? PHQ4(
                  date: date,
                  a: _pageStorage!.selectedQuestionA,
                  b: _pageStorage!.selectedQuestionB,
                  c: _pageStorage!.selectedQuestionC,
                  d: _pageStorage!.selectedQuestionD,
                )
                    : _phq4!.copyWith(
                  a: _pageStorage!.selectedQuestionA,
                  b: _pageStorage!.selectedQuestionB,
                  c: _pageStorage!.selectedQuestionC,
                  d: _pageStorage!.selectedQuestionD,
                );

                await Backend.saveObject(daily);
                await Backend.saveObject(weekly);
                await Backend.saveObject(phq4);
              }
            },
            children: _pageStorage!.pages,
          ),
        );
      },
    );
  }
}
