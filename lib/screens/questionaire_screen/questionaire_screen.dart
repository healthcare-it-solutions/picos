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
import 'package:picos/screens/questionaire_screen/pages/blood_pressure.dart';
import 'package:picos/screens/questionaire_screen/pages/body_and_mind.dart';
import 'package:picos/screens/questionaire_screen/pages/weight.dart';
import 'package:picos/screens/questionaire_screen/widgets/cover.dart';
import 'package:picos/screens/questionaire_screen/widgets/questionaire_page.dart';
import 'package:picos/screens/questionaire_screen/widgets/radio_select_card.dart';
import 'package:picos/screens/questionaire_screen/widgets/sleep_quality_card.dart';
import 'package:picos/screens/questionaire_screen/widgets/text_field_card.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  //Static Strings
  static String? _myEntries;
  static String? _vitalValues;
  static String? _activityAndRest;
  static String? _bodyAndMind;
  static String? _medicationAndTherapy;
  static String? _ready;
  static String? _heartFrequency;
  static String? _bloodSugar;
  static String? _possibleWalkDistance;
  static String? _sleepDuration;
  static String? _hrs;
  static String? _sleepQuality7Days;
  static String? _pain;
  static String? _lowInterest;
  static String? _dejection;
  static String? _nervousness;
  static String? _worries;
  static String? _changedMedication;
  static String? _changedTherapy;
  static Map<String, dynamic>? _painValues;
  static Map<String, dynamic>? _medicationAndTherapyValues;

  /// Holds the pages to generate the PageView from.
  static Map<String, Widget>? _pages;
  static final PageController _controller = PageController();

  /// Maps the pageViews to according titles.
  static Map<String, String>? _titleMap;
  static const Duration _controllerDuration = Duration(milliseconds: 300);
  static const Curve _controllerCurve = Curves.ease;

  // Value store for the user
  int? _selectedBodyWeight;
  int? _selectedBMI;
  int? _selectedHeartFrequency;
  int? _selectedSyst;
  int? _selectedDias;
  int? _selectedBloodSugar;
  int? _selectedWalkDistance;
  int? _selectedSleepDuration;
  int? _selectedSleepQuality;
  int? _selectedPain;
  int? _selectedQuestionA;
  int? _selectedQuestionB;
  int? _selectedQuestionC;
  int? _selectedQuestionD;

  // State
  final List<String> _titles = <String>[];
  String? _title;
  final List<Widget> _pageViews = <Widget>[];

  void _initStrings(BuildContext context) {
    _myEntries = AppLocalizations.of(context)!.myEntries;
    _vitalValues = AppLocalizations.of(context)!.vitalValues;
    _activityAndRest = AppLocalizations.of(context)!.activityAndRest;
    _bodyAndMind = AppLocalizations.of(context)!.bodyAndMind;
    _medicationAndTherapy = AppLocalizations.of(context)!.medicationAndTherapy;
    _heartFrequency = AppLocalizations.of(context)!.heartFrequency;
    _bloodSugar = AppLocalizations.of(context)!.bloodSugar;
    _possibleWalkDistance = AppLocalizations.of(context)!.possibleWalkDistance;
    _sleepDuration = AppLocalizations.of(context)!.sleepDuration;
    _hrs = AppLocalizations.of(context)!.hrs;
    _ready = AppLocalizations.of(context)!.questionnaireFinished;
    _sleepQuality7Days = AppLocalizations.of(context)!.sleepQuality7Days;
    _pain = AppLocalizations.of(context)!.pain;
    _lowInterest = AppLocalizations.of(context)!.lowInterest;
    _dejection = AppLocalizations.of(context)!.dejection;
    _nervousness = AppLocalizations.of(context)!.nervousness;
    _worries = AppLocalizations.of(context)!.controlWorries;
    _changedTherapy = AppLocalizations.of(context)!.changedTherapy;
    _changedMedication = AppLocalizations.of(context)!.changedMedication;
    _painValues = <String, dynamic>{
      '0 ${AppLocalizations.of(context)!.painless}': 0,
      '1 ${AppLocalizations.of(context)!.veryMild}': 1,
      '2 ${AppLocalizations.of(context)!.unpleasant}': 2,
      '3 ${AppLocalizations.of(context)!.tolerable}': 3,
      '4 ${AppLocalizations.of(context)!.disturbing}': 4,
      '5 ${AppLocalizations.of(context)!.veryDisturbing}': 5,
      '6 ${AppLocalizations.of(context)!.severe}': 6,
      '7 ${AppLocalizations.of(context)!.verySevere}': 7,
      '8 ${AppLocalizations.of(context)!.veryTerrible}': 8,
      '9 ${AppLocalizations.of(context)!.agonizingUnbearable}': 9,
      '10 ${AppLocalizations.of(context)!.strongestImaginable}': 10,
    };
    _medicationAndTherapyValues = <String, dynamic>{
      AppLocalizations.of(context)!.yes: true,
      AppLocalizations.of(context)!.no: false,
    };
  }

  void _initTitles(BuildContext context) {
    _titleMap = <String, String>{
      'vitalCover': _myEntries!,
      'weightPage': _vitalValues!,
      'hearthPage': _vitalValues!,
      'bloodPressurePage': _vitalValues!,
      'bloodSugarPage': _vitalValues!,
      'activityCover': _myEntries!,
      'walkPage': _activityAndRest!,
      'sleepDurationPage': _activityAndRest!,
      'sleepQualityPage': _activityAndRest!,
      'bodyCover': _myEntries!,
      'painPage': _bodyAndMind!,
      'interestPage': _bodyAndMind!,
      'dejectionPage': _bodyAndMind!,
      'nervousnessPage': _bodyAndMind!,
      'worriesPage': _bodyAndMind!,
      'medicationCover': _myEntries!,
      'medicationPage': _medicationAndTherapy!,
      'therapyPage': _medicationAndTherapy!,
      'readyCover': _myEntries!,
    };
  }

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

    _controller.nextPage(
      duration: _controllerDuration,
      curve: _controllerCurve,
    );
  }

  void _initPages(BuildContext context) {
    _pages = <String, Widget>{
      'vitalCover': Cover(
        title: _vitalValues!,
        image: 'assets/Vitalwerte_neg.png',
        nextFunction: _nextPage,
      ),
      'weightPage': Weight(
        previousPage: _previousPage,
        nextPage: _nextPage,
        onChangedBodyWeight: (String value) {
          _selectedBodyWeight = int.tryParse(value);
        },
        onChangedBmi: (String value) {
          _selectedBMI = int.tryParse(value);
        },
      ),
      'hearthPage': QuestionairePage(
        backFunction: _previousPage,
        nextFunction: _nextPage,
        child: TextFieldCard(
          label: _heartFrequency!,
          hint: 'bpm',
          onChanged: (String value) {
            _selectedHeartFrequency = int.tryParse(value);
          },
        ),
      ),
      'bloodPressurePage': BloodPressure(
        previousPage: _previousPage,
        nextPage: _nextPage,
        onChangedSyst: (String value) {
          _selectedSyst = int.tryParse(value);
        },
        onChangedDias: (String value) {
          _selectedDias = int.tryParse(value);
        },
      ),
      'bloodSugarPage': QuestionairePage(
        backFunction: _previousPage,
        nextFunction: _nextPage,
        child: TextFieldCard(
          label: _bloodSugar!,
          hint: 'mg/dL',
          onChanged: (String value) {
            _selectedBloodSugar = int.tryParse(value);
          },
        ),
      ),
      'activityCover': Cover(
        title: _activityAndRest!,
        image: 'assets/Aktivitaet+Ruhe_neg.png',
        backFunction: _previousPage,
        nextFunction: _nextPage,
      ),
      'walkPage': QuestionairePage(
        backFunction: _previousPage,
        nextFunction: _nextPage,
        child: TextFieldCard(
          label: _possibleWalkDistance!,
          hint: 'Meter',
          onChanged: (String value) {
            _selectedWalkDistance = int.tryParse(value);
          },
        ),
      ),
      'sleepDurationPage': QuestionairePage(
        backFunction: _previousPage,
        nextFunction: _nextPage,
        child: TextFieldCard(
          label: _sleepDuration!,
          hint: _hrs!,
          onChanged: (String value) {
            _selectedSleepDuration = int.tryParse(value);
          },
        ),
      ),
      'sleepQualityPage': QuestionairePage(
        backFunction: _previousPage,
        nextFunction: _nextPage,
        child: SleepQualityCard(
          callBack: (dynamic value) {
            _selectedSleepQuality = value;
          },
          label: _sleepQuality7Days!,
        ),
      ),
      'bodyCover': Cover(
        title: _bodyAndMind!,
        image: 'assets/Koerper+Psyche_neg.png',
        backFunction: _previousPage,
        nextFunction: _nextPage,
      ),
      'painPage': QuestionairePage(
        backFunction: _previousPage,
        nextFunction: _nextPage,
        child: RadioSelectCard(
          callBack: (dynamic value) {
            _selectedPain = value as int;
          },
          label: _pain!,
          options: _painValues!,
        ),
      ),
      'interestPage': BodyAndMind(
        previousPage: _previousPage,
        nextPage: _nextPage,
        onChangedInterest: (dynamic value) {_selectedQuestionA = value as int;},
        questionType: _lowInterest!,
      ),
      'dejectionPage': BodyAndMind(
        previousPage: _previousPage,
        nextPage: _nextPage,
        onChangedInterest: (dynamic value) {_selectedQuestionB = value as int;},
        questionType: _dejection!,
      ),
      'nervousnessPage': BodyAndMind(
        previousPage: _previousPage,
        nextPage: _nextPage,
        onChangedInterest: (dynamic value) {_selectedQuestionC = value as int;},
        questionType: _nervousness!,
      ),
      'worriesPage': BodyAndMind(
        previousPage: _previousPage,
        nextPage: _nextPage,
        onChangedInterest: (dynamic value) {_selectedQuestionD = value as int;},
        questionType: _worries!,
      ),
      'medicationCover': Cover(
        title: _medicationAndTherapy!,
        image: 'assets/Medikation+Therapie_neg.png',
        backFunction: _previousPage,
        nextFunction: _nextPage,
      ),
      'medicationPage': QuestionairePage(
        backFunction: _previousPage,
        nextFunction: _nextPage,
        child: RadioSelectCard(
          callBack: (dynamic value) {},
          label: _changedMedication!,
          options: _medicationAndTherapyValues!,
        ),
      ),
      'therapyPage': QuestionairePage(
        backFunction: _previousPage,
        nextFunction: _nextPage,
        child: RadioSelectCard(
          callBack: (dynamic value) {},
          label: _changedTherapy!,
          options: _medicationAndTherapyValues!,
        ),
      ),
      'readyCover': Cover(
        title: _ready!,
        image: 'assets/Fertig_Smiley.png',
        backFunction: _previousPage,
        nextFunction: _nextPage,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    // Class init.
    if (_myEntries == null) {
      _initStrings(context);
      _initTitles(context);
    }

    // Instance init.
    if (_pageViews.isEmpty) {
      _initPages(context);

      _title = _myEntries!;

      // Add all required pages to the list.
      _pageViews.add(_pages!['vitalCover']!);
      _titles.add(_titleMap!['vitalCover']!);
      _pageViews.add(_pages!['weightPage']!);
      _titles.add(_titleMap!['weightPage']!);
      _pageViews.add(_pages!['hearthPage']!);
      _titles.add(_titleMap!['hearthPage']!);
      _pageViews.add(_pages!['bloodPressurePage']!);
      _titles.add(_titleMap!['bloodPressurePage']!);
      _pageViews.add(_pages!['bloodSugarPage']!);
      _titles.add(_titleMap!['bloodSugarPage']!);
      _pageViews.add(_pages!['activityCover']!);
      _titles.add(_titleMap!['activityCover']!);
      _pageViews.add(_pages!['walkPage']!);
      _titles.add(_titleMap!['walkPage']!);
      _pageViews.add(_pages!['sleepDurationPage']!);
      _titles.add(_titleMap!['sleepDurationPage']!);
      _pageViews.add(_pages!['sleepQualityPage']!);
      _titles.add(_titleMap!['sleepQualityPage']!);
      _pageViews.add(_pages!['bodyCover']!);
      _titles.add(_titleMap!['bodyCover']!);
      _pageViews.add(_pages!['painPage']!);
      _titles.add(_titleMap!['painPage']!);
      _pageViews.add(_pages!['interestPage']!);
      _titles.add(_titleMap!['interestPage']!);
      _pageViews.add(_pages!['dejectionPage']!);
      _titles.add(_titleMap!['dejectionPage']!);
      _pageViews.add(_pages!['nervousnessPage']!);
      _titles.add(_titleMap!['nervousnessPage']!);
      _pageViews.add(_pages!['worriesPage']!);
      _titles.add(_titleMap!['worriesPage']!);
      _pageViews.add(_pages!['medicationCover']!);
      _titles.add(_titleMap!['medicationCover']!);
      _pageViews.add(_pages!['medicationPage']!);
      _titles.add(_titleMap!['medicationPage']!);
      _pageViews.add(_pages!['therapyPage']!);
      _titles.add(_titleMap!['therapyPage']!);
      _pageViews.add(_pages!['readyCover']!);
      _titles.add(_titleMap!['readyCover']!);
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
              bloodDiastolic: _selectedDias,
              bloodSugar: _selectedBloodSugar,
              bloodSystolic: _selectedSyst,
              pain: _selectedPain,
              sleepDuration: _selectedSleepDuration,
              heartFrequency: _selectedHeartFrequency,
            );

            Weekly weekly = Weekly(
              date: date,
              bodyWeight: _selectedBodyWeight,
              bmi: _selectedBMI,
              sleepQuality: _selectedSleepQuality,
              walkingDistance: _selectedWalkDistance,
            );

            PHQ4 phq4 = PHQ4(
              date: date,
              a: _selectedQuestionA,
              b: _selectedQuestionB,
              c: _selectedQuestionC,
              d: _selectedQuestionD,
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
