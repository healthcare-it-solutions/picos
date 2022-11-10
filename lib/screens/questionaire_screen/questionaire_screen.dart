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
import 'package:picos/screens/questionaire_screen/widgets/cover.dart';
import 'package:picos/screens/questionaire_screen/widgets/questionaire_card.dart';
import 'package:picos/screens/questionaire_screen/widgets/radio_select_card.dart';
import 'package:picos/screens/questionaire_screen/widgets/text_field_card.dart';
import 'package:picos/widgets/picos_add_button_bar.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:picos/widgets/picos_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/daily.dart';
import '../../themes/global_theme.dart';
import '../../util/backend.dart';
import '../../widgets/picos_ink_well_button.dart';

/// This is the screen a user should see when prompted to provide some
/// information about their health status.
class QuestionaireScreen extends StatelessWidget {
  /// QuestionaireScreen constructor
  const QuestionaireScreen({Key? key}) : super(key: key);

  //Static Strings
  static String? _myEntries;
  static String? _vitalValues;
  static String? _activityAndRest;
  static String? _bodyAndMind;
  static String? _medicationAndTherapy;
  static String? _ready;
  static String? _bodyWeight;
  static String? _autoCalc;
  static String? _heartFrequency;
  static String? _bloodPressure;
  static String? _bloodSugar;
  static String? _possibleWalkDistance;
  static String? _sleepDuration;
  static String? _hrs;
  static String? _sleepQuality7Days;
  static String? _pain;
  static String? _howOftenAffected;
  static String? _lowInterest;
  static String? _dejection;
  static String? _nervousness;
  static String? _controlWorries;
  static String? _changedMedication;
  static String? _changedTherapy;
  static String? _back;
  static String? _next;
  static const Map<String, dynamic> _sleepQualityValues = <String, dynamic>{
    '10': 10,
    '9': 9,
    '8': 8,
    '7': 7,
    '6': 6,
    '5': 5,
    '4': 4,
    '3': 3,
    '2': 2,
    '1': 1,
    '0': 0,
  };
  static Map<String, dynamic>? _painValues;
  static Map<String, dynamic>? _bodyAndMindValues;
  static Map<String, dynamic>? _medicationAndTherapyValues;

  @override
  Widget build(BuildContext context) {
    List<Widget> pageViews;
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    final PageController controller = PageController();

    const Duration controllerDuration = Duration(milliseconds: 300);
    const Curve controllerCurve = Curves.ease;

    // Value store for the user
    int? selectedBodyWeight;
    int? selectedBMI;
    int? selectedHeartFrequency;
    int? selectedSyst;
    int? selectedDias;
    int? selectedBloodSugar;
    int? selectedWalkDistance;
    int? selectedSleepDuration;
    int? selectedSleepQuality;
    int? selectedPain;
    int? selectedQuestionA;
    int? selectedQuestionB;
    int? selectedQuestionC;
    int? selectedQuestionD;

    // Class init.
    if (_myEntries == null) {
      _myEntries = AppLocalizations.of(context)!.myEntries;
      _vitalValues = AppLocalizations.of(context)!.vitalValues;
      _activityAndRest = AppLocalizations.of(context)!.activityAndRest;
      _bodyAndMind = AppLocalizations.of(context)!.bodyAndMind;
      _medicationAndTherapy =
          AppLocalizations.of(context)!.medicationAndTherapy;
      _bodyWeight = AppLocalizations.of(context)!.bodyWeight;
      _autoCalc = AppLocalizations.of(context)!.autoCalc;
      _heartFrequency = AppLocalizations.of(context)!.heartFrequency;
      _bloodPressure = AppLocalizations.of(context)!.bloodPressure;
      _bloodSugar = AppLocalizations.of(context)!.bloodSugar;
      _possibleWalkDistance =
          AppLocalizations.of(context)!.possibleWalkDistance;
      _sleepDuration = AppLocalizations.of(context)!.sleepDuration;
      _hrs = AppLocalizations.of(context)!.hrs;
      _ready = AppLocalizations.of(context)!.questionnaireFinished;
      _sleepQuality7Days = AppLocalizations.of(context)!.sleepQuality7Days;
      _pain = AppLocalizations.of(context)!.pain;
      _howOftenAffected = AppLocalizations.of(context)!.howOftenAffected;
      _lowInterest = AppLocalizations.of(context)!.lowInterest;
      _dejection = AppLocalizations.of(context)!.dejection;
      _nervousness = AppLocalizations.of(context)!.nervousness;
      _controlWorries = AppLocalizations.of(context)!.controlWorries;
      _changedTherapy = AppLocalizations.of(context)!.changedTherapy;
      _changedMedication = AppLocalizations.of(context)!.changedMedication;
      _back = AppLocalizations.of(context)!.back;
      _next = AppLocalizations.of(context)!.next;
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
      _bodyAndMindValues = <String, dynamic>{
        AppLocalizations.of(context)!.notAtAll: 0,
        AppLocalizations.of(context)!.onIndividualDays: 1,
        AppLocalizations.of(context)!.onMoreThanHalfDays: 2,
        AppLocalizations.of(context)!.almostEveryDays: 3,
      };
      _medicationAndTherapyValues = <String, dynamic>{
        AppLocalizations.of(context)!.yes: true,
        AppLocalizations.of(context)!.no: false,
      };
    }

    pageViews = <Widget>[
      PicosBody(child: Cover(title: _vitalValues!)),
      PicosBody(
        child: Column(
          children: <TextFieldCard>[
            TextFieldCard(
              label: _bodyWeight!,
              hint: 'kg',
              onChanged: (String value) {
                selectedBodyWeight = int.tryParse(value);
              },
            ),
            TextFieldCard(
              label: 'BMI',
              hint: 'kg/m² ${_autoCalc!}',
              onChanged: (String value) {
                selectedBMI = int.tryParse(value);
              },
            ),
          ],
        ),
      ),
      PicosBody(
        child: TextFieldCard(
          label: _heartFrequency!,
          hint: 'bpm',
          onChanged: (String value) {
            selectedHeartFrequency = int.tryParse(value);
          },
        ),
      ),
      PicosBody(
        child: QuestionaireCard(
          label: _bloodPressure!,
          child: Row(
            children: <Widget>[
              Expanded(
                child: PicosTextField(
                  hint: 'Syst',
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  onChanged: (String value) {
                    selectedSyst = int.tryParse(value);
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                child: Text('/', style: TextStyle(fontSize: 20)),
              ),
              Expanded(
                child: PicosTextField(
                  hint: 'Dias',
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  onChanged: (String value) {
                    selectedDias = int.tryParse(value);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      PicosBody(
        child: TextFieldCard(
          label: _bloodSugar!,
          hint: 'mg/dL',
          onChanged: (String value) {
            selectedBloodSugar = int.tryParse(value);
          },
        ),
      ),
      PicosBody(child: Cover(title: _activityAndRest!)),
      PicosBody(
        child: TextFieldCard(
          label: _possibleWalkDistance!,
          hint: 'Meter',
          onChanged: (String value) {
            selectedWalkDistance = int.tryParse(value);
          },
        ),
      ),
      PicosBody(
        child: TextFieldCard(
          label: _sleepDuration!,
          hint: _hrs!,
          onChanged: (String value) {
            selectedSleepDuration = int.tryParse(value);
          },
        ),
      ),
      PicosBody(
        child: RadioSelectCard(
          callBack: (dynamic value) {
            selectedSleepQuality = value as int;
          },
          label: _sleepQuality7Days!,
          options: _sleepQualityValues,
        ),
      ),
      PicosBody(child: Cover(title: _bodyAndMind!)),
      PicosBody(
        child: RadioSelectCard(
          callBack: (dynamic value) {
            selectedPain = value as int;
          },
          label: _pain!,
          options: _painValues!,
        ),
      ),
      PicosBody(
        child: RadioSelectCard(
          callBack: (dynamic value) {
            selectedQuestionA = value as int;
          },
          label: _howOftenAffected!,
          description: _lowInterest!,
          options: _bodyAndMindValues!,
        ),
      ),
      PicosBody(
        child: RadioSelectCard(
          callBack: (dynamic value) {
            selectedQuestionB = value as int;
          },
          label: _howOftenAffected!,
          description: _dejection!,
          options: _bodyAndMindValues!,
        ),
      ),
      PicosBody(
        child: RadioSelectCard(
          callBack: (dynamic value) {
            selectedQuestionC = value as int;
          },
          label: _howOftenAffected!,
          description: _nervousness!,
          options: _bodyAndMindValues!,
        ),
      ),
      PicosBody(
        child: RadioSelectCard(
          callBack: (dynamic value) {
            selectedQuestionD = value as int;
          },
          label: _howOftenAffected!,
          description: _controlWorries!,
          options: _bodyAndMindValues!,
        ),
      ),
      PicosBody(child: Cover(title: _medicationAndTherapy!)),
      PicosBody(
        child: RadioSelectCard(
          callBack: (dynamic value) {},
          label: _changedMedication!,
          options: _medicationAndTherapyValues!,
        ),
      ),
      PicosBody(
        child: RadioSelectCard(
          callBack: (dynamic value) {},
          label: _changedTherapy!,
          options: _medicationAndTherapyValues!,
        ),
      ),
      PicosBody(
        child: Cover(title: _ready!),
      ),
    ];

    return PicosScreenFrame(
      bottomNavigationBar: PicosAddButtonBar(
        leftButton: PicosInkWellButton(
          padding: const EdgeInsets.only(
            left: 30,
            right: 13,
            top: 15,
            bottom: 10,
          ),
          text: _back!,
          onTap: () {
            if (controller.page == pageViews.length - 1 ||
                controller.page == 0) {
              Navigator.of(context).pop();
              return;
            }

            controller.previousPage(
              duration: controllerDuration,
              curve: controllerCurve,
            );
          },
          buttonColor1: theme.grey3,
          buttonColor2: theme.grey1,
        ),
        rightButton: PicosInkWellButton(
          padding: const EdgeInsets.only(
            right: 30,
            left: 13,
            top: 15,
            bottom: 10,
          ),
          text: _next!,
          onTap: () {
            if (controller.page == pageViews.length - 1) {
              Navigator.of(context).pop();
              return;
            }

            controller.nextPage(
              duration: controllerDuration,
              curve: controllerCurve,
            );
          },
        ),
      ),
      title: _myEntries,
      body: PageView(
        controller: controller,
        children: pageViews,
        onPageChanged: (int value) async {
          if (value == pageViews.length - 1) {
            DateTime date = DateTime.now();

            Daily daily = Daily(
              date: date,
              bloodDiastolic: selectedDias,
              bloodSugar: selectedBloodSugar,
              bloodSystolic: selectedSyst,
              pain: selectedPain,
              sleepDuration: selectedSleepDuration,
              heartFrequency: selectedHeartFrequency,
            );

            Weekly weekly = Weekly(
              date: date,
              bodyWeight: selectedBodyWeight,
              bmi: selectedBMI,
              sleepQuality: selectedSleepQuality,
              walkingDistance: selectedWalkDistance,
            );

            PHQ4 phq4 = PHQ4(
              date: date,
              a: selectedQuestionA,
              b: selectedQuestionB,
              c: selectedQuestionC,
              d: selectedQuestionD,
            );

            await Backend.saveObject(daily);
            await Backend.saveObject(weekly);
            await Backend.saveObject(phq4);
          }
        },
      ),
    );
  }
}
