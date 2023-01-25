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
import 'package:picos/screens/questionaire_screen/questionaire_page_state.dart';
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
  QuestionairePageState? _pages;
  static final PageController _controller = PageController();
  static const Duration _controllerDuration = Duration(milliseconds: 300);
  static const Curve _controllerCurve = Curves.ease;

  bool? _medicationChanged;
  bool? _therapyChanged;

  // State
  final List<String> _titles = <String>[];
  String? _title;
  final List<Widget> _pageViews = <Widget>[];
  bool _medicationUpdated = false;
  bool _therapyUpdated = false;

  final Map<String, int> _redirectingPages = <String, int>{
    'medicationPage': 16,
    'therapyPage': 17,
  };

  void _previousPage() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_controller.page == 0 || _controller.page == _pageViews.length - 1) {
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

    if (_controller.page == _pageViews.length - 1) {
      Navigator.of(context).pop();
      return;
    }

    if (_controller.page == _redirectingPages['medicationPage'] &&
        _medicationChanged == true &&
        _medicationUpdated == false) {
      _medicationUpdated = true;
      Navigator.of(context).pushNamed('/my-medications-screen/my-medications');
    }

    if (_controller.page == _redirectingPages['therapyPage'] &&
        _therapyChanged == true &&
        _therapyUpdated == false) {
      _therapyUpdated = true;
      Navigator.of(context).pushNamed('/my-therapy-screen/my-therapy');
    }

    _controller.nextPage(
      duration: _controllerDuration,
      curve: _controllerCurve,
    );
  }

  // 'medicationPage': QuestionairePage(
  // backFunction: _previousPage,
  // nextFunction: _nextPage,
  // child: RadioSelectCard(
  // callBack: (dynamic value) {
  // _medicationChanged = value;
  // _medicationUpdated = false;
  // },
  // label: _changedMedication!,
  // options: _medicationAndTherapyValues!,
  // ),
  // ),
  // 'therapyPage': QuestionairePage(
  // backFunction: _previousPage,
  // nextFunction: _nextPage,
  // child: RadioSelectCard(
  // callBack: (dynamic value) {
  // _therapyChanged = value;
  // _therapyUpdated = false;
  // },
  // label: _changedTherapy!,
  // options: _medicationAndTherapyValues!,
  // ),
  // ),

  @override
  Widget build(BuildContext context) {
    // Class init.
    _pages ??= QuestionairePageState(_previousPage, _nextPage, context);

    // Instance init.
    if (_pageViews.isEmpty) {
      _title = _pages!.titleMap!['vitalCover'];

      // Add all required pages to the list.
      _pageViews.add(_pages!.pages!['vitalCover']!);
      _titles.add(_pages!.titleMap!['vitalCover']!);
      _pageViews.add(_pages!.pages!['weightPage']!);
      _titles.add(_pages!.titleMap!['weightPage']!);
      _pageViews.add(_pages!.pages!['hearthPage']!);
      _titles.add(_pages!.titleMap!['hearthPage']!);
      _pageViews.add(_pages!.pages!['bloodPressurePage']!);
      _titles.add(_pages!.titleMap!['bloodPressurePage']!);
      _pageViews.add(_pages!.pages!['bloodSugarPage']!);
      _titles.add(_pages!.titleMap!['bloodSugarPage']!);
      _pageViews.add(_pages!.pages!['activityCover']!);
      _titles.add(_pages!.titleMap!['activityCover']!);
      _pageViews.add(_pages!.pages!['walkPage']!);
      _titles.add(_pages!.titleMap!['walkPage']!);
      _pageViews.add(_pages!.pages!['sleepDurationPage']!);
      _titles.add(_pages!.titleMap!['sleepDurationPage']!);
      _pageViews.add(_pages!.pages!['sleepQualityPage']!);
      _titles.add(_pages!.titleMap!['sleepQualityPage']!);
      _pageViews.add(_pages!.pages!['bodyCover']!);
      _titles.add(_pages!.titleMap!['bodyCover']!);
      _pageViews.add(_pages!.pages!['painPage']!);
      _titles.add(_pages!.titleMap!['painPage']!);
      _pageViews.add(_pages!.pages!['interestPage']!);
      _titles.add(_pages!.titleMap!['interestPage']!);
      _pageViews.add(_pages!.pages!['dejectionPage']!);
      _titles.add(_pages!.titleMap!['dejectionPage']!);
      _pageViews.add(_pages!.pages!['nervousnessPage']!);
      _titles.add(_pages!.titleMap!['nervousnessPage']!);
      _pageViews.add(_pages!.pages!['worriesPage']!);
      _titles.add(_pages!.titleMap!['worriesPage']!);
      _pageViews.add(_pages!.pages!['medicationCover']!);
      _titles.add(_pages!.titleMap!['medicationCover']!);
      _pageViews.add(_pages!.pages!['medicationPage']!);
      _titles.add(_pages!.titleMap!['medicationPage']!);
      _pageViews.add(_pages!.pages!['therapyPage']!);
      _titles.add(_pages!.titleMap!['therapyPage']!);
      _pageViews.add(_pages!.pages!['readyCover']!);
      _titles.add(_pages!.titleMap!['readyCover']!);
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

          if (value == _pageViews.length - 1) {
            DateTime date = DateTime.now();

            Daily daily = Daily(
              date: date,
              bloodDiastolic: _pages!.selectedDias,
              bloodSugar: _pages!.selectedBloodSugar,
              bloodSystolic: _pages!.selectedSyst,
              pain: _pages!.selectedPain,
              sleepDuration: _pages!.selectedSleepDuration,
              heartFrequency: _pages!.selectedHeartFrequency,
            );

            Weekly weekly = Weekly(
              date: date,
              bodyWeight: _pages!.selectedBodyWeight,
              bmi: _pages!.selectedBMI,
              sleepQuality: _pages!.selectedSleepQuality,
              walkingDistance: _pages!.selectedWalkDistance,
            );

            PHQ4 phq4 = PHQ4(
              date: date,
              a: _pages!.selectedQuestionA,
              b: _pages!.selectedQuestionB,
              c: _pages!.selectedQuestionC,
              d: _pages!.selectedQuestionD,
            );

            await Backend.saveObject(daily);
            await Backend.saveObject(weekly);
            await Backend.saveObject(phq4);
          }
        },
        children: _pageViews,
      ),
    );
  }
}
