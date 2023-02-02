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
import 'package:picos/screens/questionaire_screen/pages/blood_pressure.dart';
import 'package:picos/screens/questionaire_screen/pages/body_and_mind.dart';
import 'package:picos/screens/questionaire_screen/pages/weight.dart';
import 'package:picos/screens/questionaire_screen/widgets/cover.dart';
import 'package:picos/screens/questionaire_screen/widgets/doctor_card.dart';
import 'package:picos/screens/questionaire_screen/widgets/questionaire_page.dart';
import 'package:picos/screens/questionaire_screen/widgets/radio_select_card.dart';
import 'package:picos/screens/questionaire_screen/widgets/sleep_quality_card.dart';
import 'package:picos/screens/questionaire_screen/widgets/text_field_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Manages the state of the questionaire pages.
class QuestionairePageState {
  /// Constructs QuestionairePageState.
  QuestionairePageState(
    void Function() previousPage,
    void Function() nextPage,
    BuildContext context,
  ) {
    _initStrings(context);
    _initTitles();

    pages = <String, Widget>{
      'vitalCover': Cover(
        title: _vitalValues!,
        image: 'assets/Vitalwerte_neg.png',
        nextFunction: nextPage,
      ),
      'weightPage': Weight(
        previousPage: previousPage,
        nextPage: nextPage,
        onChangedBodyWeight: (String value) {
          selectedBodyWeight = int.tryParse(value);
        },
        onChangedBmi: (String value) {
          selectedBMI = int.tryParse(value);
        },
      ),
      'heartPage': QuestionairePage(
        backFunction: previousPage,
        nextFunction: nextPage,
        child: TextFieldCard(
          label: _heartFrequency!,
          hint: 'bpm',
          onChanged: (String value) {
            selectedHeartFrequency = int.tryParse(value);
          },
        ),
      ),
      'bloodPressurePage': BloodPressure(
        previousPage: previousPage,
        nextPage: nextPage,
        onChangedSyst: (String value) {
          selectedSyst = int.tryParse(value);
        },
        onChangedDias: (String value) {
          selectedDias = int.tryParse(value);
        },
      ),
      'bloodSugarPage': QuestionairePage(
        backFunction: previousPage,
        nextFunction: nextPage,
        child: TextFieldCard(
          label: _bloodSugar!,
          hint: 'mg/dL',
          onChanged: (String value) {
            selectedBloodSugar = int.tryParse(value);
          },
        ),
      ),
      'activityCover': Cover(
        title: _activityAndRest!,
        image: 'assets/Aktivitaet+Ruhe_neg.png',
        backFunction: previousPage,
        nextFunction: nextPage,
      ),
      'walkPage': QuestionairePage(
        backFunction: previousPage,
        nextFunction: nextPage,
        child: TextFieldCard(
          label: _possibleWalkDistance!,
          hint: 'Meter',
          onChanged: (String value) {
            selectedWalkDistance = int.tryParse(value);
          },
        ),
      ),
      'sleepDurationPage': QuestionairePage(
        backFunction: previousPage,
        nextFunction: nextPage,
        child: TextFieldCard(
          label: _sleepDuration!,
          hint: _hrs!,
          onChanged: (String value) {
            selectedSleepDuration = int.tryParse(value);
          },
        ),
      ),
      'sleepQualityPage': QuestionairePage(
        backFunction: previousPage,
        nextFunction: nextPage,
        child: SleepQualityCard(
          callBack: (dynamic value) {
            selectedSleepQuality = value;
          },
          label: _sleepQuality7Days!,
        ),
      ),
      'bodyCover': Cover(
        title: _bodyAndMind!,
        image: 'assets/Koerper+Psyche_neg.png',
        backFunction: previousPage,
        nextFunction: nextPage,
      ),
      'painPage': QuestionairePage(
        backFunction: previousPage,
        nextFunction: nextPage,
        child: RadioSelectCard(
          callback: (dynamic value) {
            selectedPain = value as int;
          },
          label: _pain!,
          options: _painValues!,
        ),
      ),
      'interestPage': BodyAndMind(
        previousPage: previousPage,
        nextPage: nextPage,
        onChangedInterest: (dynamic value) {
          selectedQuestionA = value as int;
        },
        questionType: _lowInterest!,
      ),
      'dejectionPage': BodyAndMind(
        previousPage: previousPage,
        nextPage: nextPage,
        onChangedInterest: (dynamic value) {
          selectedQuestionB = value as int;
        },
        questionType: _dejection!,
      ),
      'nervousnessPage': BodyAndMind(
        previousPage: previousPage,
        nextPage: nextPage,
        onChangedInterest: (dynamic value) {
          selectedQuestionC = value as int;
        },
        questionType: _nervousness!,
      ),
      'worriesPage': BodyAndMind(
        previousPage: previousPage,
        nextPage: nextPage,
        onChangedInterest: (dynamic value) {
          selectedQuestionD = value as int;
        },
        questionType: _worries!,
      ),
      'medicationCover': Cover(
        title: _medicationAndTherapy!,
        image: 'assets/Medikation+Therapie_neg.png',
        backFunction: previousPage,
        nextFunction: nextPage,
      ),
      'medicationPage': QuestionairePage(
        backFunction: previousPage,
        nextFunction: nextPage,
        child: RadioSelectCard(
          callback: (dynamic value) {
            medicationChanged = value;
            medicationUpdated = false;
          },
          label: _changedMedication!,
          options: _medicationAndTherapyValues!,
        ),
      ),
      'therapyPage': QuestionairePage(
        backFunction: previousPage,
        nextFunction: nextPage,
        child: RadioSelectCard(
          callback: (dynamic value) {
            therapyChanged = value;
            therapyUpdated = false;
          },
          label: _changedTherapy!,
          options: _medicationAndTherapyValues!,
        ),
      ),
      'doctorPage': QuestionairePage(
        backFunction: previousPage,
        nextFunction: nextPage,
        child: DoctorCard(
          callback: (dynamic value) {
            doctorVisited = value;
            doctorVisitedUpdated = false;
          },
          radioOptions: _medicationAndTherapyValues!,
        ),
      ),
      'readyCover': Cover(
        title: _ready!,
        image: 'assets/Fertig_Smiley_neg.png',
        infoText: <TextSpan>[
          TextSpan(
            text: '${AppLocalizations.of(context)!.tips}\n',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.drinkEnough,
          ),
        ],
      ),
    };
  }

  /// The loaded pages.
  Map<String, Widget>? pages;

  /// Maps the pageViews to according titles.
  Map<String, String>? titleMap;

  // Value store for the user
  /// The selected body weight.
  int? selectedBodyWeight;

  /// The given bmi.
  int? selectedBMI;

  /// The selected heart frequency.
  int? selectedHeartFrequency;

  /// The selected syst value for blood pressure.
  int? selectedSyst;

  /// The selected dias value for blood pressure.
  int? selectedDias;

  /// The selected blood sugar value.
  int? selectedBloodSugar;

  /// The selected walk distance.
  int? selectedWalkDistance;

  /// The selected sleep duration.
  int? selectedSleepDuration;

  /// The selected sleep quality.
  int? selectedSleepQuality;

  /// The selected pain value.
  int? selectedPain;

  /// Answer to question A.
  int? selectedQuestionA;

  /// Answer to question B.
  int? selectedQuestionB;

  /// Answer to question C.
  int? selectedQuestionC;

  /// Answer to question D.
  int? selectedQuestionD;

  /// Tells if the medication got updated by the user.
  bool medicationUpdated = false;

  /// Tells if the therapy got updated by the user.
  bool therapyUpdated = false;

  /// Tells if the doctor visits got updated by the user.
  bool doctorVisitedUpdated = false;

  /// Tells if the medication got changed and should be updated (synced)
  /// by the user.
  bool? medicationChanged;

  /// Tells if the therapy got changed and should be updated (synced)
  /// by the user.
  bool? therapyChanged;

  /// Tells if the user visited a doctor or a hospital and should be updated
  /// (synced) by the user.
  bool? doctorVisited;

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

  void _initStrings(BuildContext context) {
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
    _myEntries = AppLocalizations.of(context)!.myEntries;
    _vitalValues = AppLocalizations.of(context)!.vitalValues;
    _activityAndRest = AppLocalizations.of(context)!.activityAndRest;
    _bodyAndMind = AppLocalizations.of(context)!.bodyAndMind;
    _medicationAndTherapy = AppLocalizations.of(context)!.medicationAndTherapy;
  }

  void _initTitles() {
    titleMap = <String, String>{
      'vitalCover': _myEntries!,
      'weightPage': _vitalValues!,
      'heartPage': _vitalValues!,
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
      'doctorPage': _medicationAndTherapy!,
      'readyCover': _myEntries!,
    };
  }
}
