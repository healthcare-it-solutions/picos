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

  final Map<String, int> _redirectingPages = <String, int>{
    'medicationPage': 16,
    'therapyPage': 17,
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

    _controller.nextPage(
      duration: _controllerDuration,
      curve: _controllerCurve,
    );
  }

  // Class init.
  Future<bool> _classInit(BuildContext context) async {
    _pageStorage ??=
        await QuestionairePageStorage.create(_previousPage, _nextPage, context);

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
