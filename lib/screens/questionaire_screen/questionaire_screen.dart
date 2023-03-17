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
  static final PageController _controller = PageController();
  static const Duration _controllerDuration = Duration(milliseconds: 300);
  static const Curve _controllerCurve = Curves.ease;

  // State
  final List<String> _titles = <String>[];
  String? _title;
  final List<Widget> _pages = <Widget>[];
  Weekly? _weekly;
  Daily? _daily;
  PHQ4? _phq4;
  final DateTime _now = DateTime.now();

  final Map<String, int> _redirectingPages = <String, int>{
    'medicationPage': 16,
    'therapyPage': 17,
    'doctorPage': 18,
  };

  void _previousPage() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_controller.page == 0 || _controller.page == _pages.length - 1) {
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

    if (_controller.page == _pages.length - 1) {
      Navigator.of(context).pop();
      return;
    }

    if (_controller.page == _redirectingPages['medicationPage'] &&
        _pageStorage!.medicationChanged == true &&
        _pageStorage!.medicationUpdated == false) {
      _pageStorage!.medicationUpdated = true;
      Navigator.of(context).pushNamed('/my-medications-screen/my-medications');
    }

    if (_controller.page == _redirectingPages['therapyPage'] &&
        _pageStorage!.therapyChanged == true &&
        _pageStorage!.therapyUpdated == false) {
      _pageStorage!.therapyUpdated = true;
      Navigator.of(context).pushNamed('/my-therapy-screen/my-therapy');
    }

    if (_controller.page == _redirectingPages['doctorPage'] &&
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

  bool _hasDailyNullValues(Daily daily) {
    if (daily.bloodDiastolic == null ||
        daily.bloodSugar == null ||
        daily.bloodSystolic == null ||
        daily.heartFrequency == null ||
        daily.pain == null ||
        daily.sleepDuration == null) {
      return true;
    }

    return false;
  }

  Daily? _createDaily(dynamic model) {
    Daily daily = Daily(
      heartFrequency: model['HeartRate'],
      bloodSugar: model['BloodSugar'],
      bloodSystolic: model['BloodPSystolic'],
      bloodDiastolic: model['BloodPDiastolic'],
      sleepDuration: model['SleepDuration'],
      date: DateTime.parse(model['datetime']['iso']),
      pain: model['Pain'],
      objectId: model['objectId'],
      createdAt: DateTime.parse(model['createdAt']),
      updatedAt: DateTime.parse(model['updatedAt']),
    );

    if (_hasDailyNullValues(daily) &&
        !daily.date.isBefore(
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

  bool _hasWeeklyNullValues(Weekly weekly) {
    if (weekly.bodyWeight == null ||
        weekly.bmi == null ||
        weekly.sleepQuality == null ||
        weekly.walkingDistance == null) {
      return true;
    }

    return false;
  }

  Weekly? _createWeekly(dynamic model) {
    Weekly weekly = Weekly(
      bmi: model['BMI']?.toDouble(),
      bodyWeight: model['BodyWeight']?.toDouble(),
      sleepQuality: model['SISQS'],
      walkingDistance: model['WalkingDistance'],
      date: DateTime.parse(model['datetime']['iso']),
      objectId: model['objectId'],
      createdAt: DateTime.parse(model['createdAt']),
      updatedAt: DateTime.parse(model['updatedAt']),
    );

    if (_hasWeeklyNullValues(weekly) &&
        !weekly.date.isBefore(
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

  bool _hasPhq4NullValues(PHQ4 phq4) {
    if (phq4.a == null || phq4.b == null || phq4.c == null || phq4.d == null) {
      return true;
    }

    return false;
  }

  PHQ4? _createPHQ4(dynamic model) {
    PHQ4 phq4 = PHQ4(
      a: model['a'],
      b: model['b'],
      c: model['c'],
      d: model['d'],
      date: DateTime.parse(model['datetime']['iso']),
      objectId: model['objectId'],
      createdAt: DateTime.parse(model['createdAt']),
      updatedAt: DateTime.parse(model['updatedAt']),
    );

    if (_hasPhq4NullValues(phq4) &&
        !phq4.date.isBefore(
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
    if (_daily != null || _weekly != null || _phq4 != null) {
      return true;
    }

    List<dynamic> dailyData = await Backend.getAll(Daily.databaseTable);
    List<dynamic> weeklyData = await Backend.getAll(Weekly.databaseTable);
    List<dynamic> phq4Data = await Backend.getAll(PHQ4.databaseTable);

    if (dailyData.isEmpty ||
        weeklyData.isEmpty ||
        phq4Data.isEmpty ||
        !mounted) {
      return false;
    }

    _daily = _createDaily(dailyData.last);
    _weekly = _createWeekly(weeklyData.last);
    _phq4 = _createPHQ4(phq4Data.last);

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
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _classInit(context),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData && !snapshot.hasError) {
          return const CircularProgressIndicator();
        }

        // Instance init.
        if (_pages.isEmpty) {
          _title = _pageStorage!.titleMap!['vitalCover'];

          // Add all required pages to the list.
          _pages.add(_pageStorage!.pages!['vitalCover']!);
          _titles.add(_pageStorage!.titleMap!['vitalCover']!);
          _pages.add(_pageStorage!.pages!['weightPage']!);
          _titles.add(_pageStorage!.titleMap!['weightPage']!);
          _pages.add(_pageStorage!.pages!['heartPage']!);
          _titles.add(_pageStorage!.titleMap!['heartPage']!);
          _pages.add(_pageStorage!.pages!['bloodPressurePage']!);
          _titles.add(_pageStorage!.titleMap!['bloodPressurePage']!);
          _pages.add(_pageStorage!.pages!['bloodSugarPage']!);
          _titles.add(_pageStorage!.titleMap!['bloodSugarPage']!);
          _pages.add(_pageStorage!.pages!['activityCover']!);
          _titles.add(_pageStorage!.titleMap!['activityCover']!);
          _pages.add(_pageStorage!.pages!['walkPage']!);
          _titles.add(_pageStorage!.titleMap!['walkPage']!);
          _pages.add(_pageStorage!.pages!['sleepDurationPage']!);
          _titles.add(_pageStorage!.titleMap!['sleepDurationPage']!);
          _pages.add(_pageStorage!.pages!['sleepQualityPage']!);
          _titles.add(_pageStorage!.titleMap!['sleepQualityPage']!);
          _pages.add(_pageStorage!.pages!['bodyCover']!);
          _titles.add(_pageStorage!.titleMap!['bodyCover']!);
          _pages.add(_pageStorage!.pages!['painPage']!);
          _titles.add(_pageStorage!.titleMap!['painPage']!);
          _pages.add(_pageStorage!.pages!['interestPage']!);
          _titles.add(_pageStorage!.titleMap!['interestPage']!);
          _pages.add(_pageStorage!.pages!['dejectionPage']!);
          _titles.add(_pageStorage!.titleMap!['dejectionPage']!);
          _pages.add(_pageStorage!.pages!['nervousnessPage']!);
          _titles.add(_pageStorage!.titleMap!['nervousnessPage']!);
          _pages.add(_pageStorage!.pages!['worriesPage']!);
          _titles.add(_pageStorage!.titleMap!['worriesPage']!);
          _pages.add(_pageStorage!.pages!['medicationCover']!);
          _titles.add(_pageStorage!.titleMap!['medicationCover']!);
          _pages.add(_pageStorage!.pages!['medicationPage']!);
          _titles.add(_pageStorage!.titleMap!['medicationPage']!);
          _pages.add(_pageStorage!.pages!['therapyPage']!);
          _titles.add(_pageStorage!.titleMap!['therapyPage']!);
          _pages.add(_pageStorage!.pages!['doctorPage']!);
          _titles.add(_pageStorage!.titleMap!['doctorPage']!);
          _pages.add(_pageStorage!.pages!['readyCover']!);
          _titles.add(_pageStorage!.titleMap!['readyCover']!);
        }

        return PicosScreenFrame(
          appBarElevation: 0.0,
          title: _title,
          body: PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int value) async {
              if (_title != _titles[value]) {
                setState(() {
                  _title = _titles[value];
                });
              }

              if (value == _pages.length - 1) {
                DateTime date = DateTime.now();

                Daily daily = Daily(
                  date: date,
                  bloodDiastolic: _pageStorage!.selectedDias,
                  bloodSugar: _pageStorage!.selectedBloodSugar,
                  bloodSystolic: _pageStorage!.selectedSyst,
                  pain: _pageStorage!.selectedPain,
                  sleepDuration: _pageStorage!.selectedSleepDuration,
                  heartFrequency: _pageStorage!.selectedHeartFrequency,
                );

                Weekly weekly = Weekly(
                  date: date,
                  bodyWeight: _pageStorage!.selectedBodyWeight,
                  bmi: _pageStorage!.selectedBMI,
                  sleepQuality: _pageStorage!.selectedSleepQuality,
                  walkingDistance: _pageStorage!.selectedWalkDistance,
                );

                PHQ4 phq4 = PHQ4(
                  date: date,
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
            children: _pages,
          ),
        );
      },
    );
  }
}
