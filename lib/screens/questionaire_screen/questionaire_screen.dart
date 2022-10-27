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
import 'package:picos/screens/questionaire_screen/widgets/cover.dart';
import 'package:picos/screens/questionaire_screen/widgets/questionaire_card.dart';
import 'package:picos/screens/questionaire_screen/widgets/radio_select_card.dart';
import 'package:picos/screens/questionaire_screen/widgets/text_field_card.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:picos/widgets/picos_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  static List<PicosBody>? _pageViews;

  @override
  Widget build(BuildContext context) {
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

      _pageViews = <PicosBody>[
        PicosBody(child: Cover(title: _vitalValues!)),
        PicosBody(
          child: Column(
            children: <TextFieldCard>[
              TextFieldCard(
                label: _bodyWeight!,
                hint: 'kg',
              ),
              TextFieldCard(
                label: 'BMI',
                hint: 'kg/m² ${_autoCalc!}',
              ),
            ],
          ),
        ),
        PicosBody(
          child: TextFieldCard(
            label: _heartFrequency!,
            hint: 'bpm',
          ),
        ),
        PicosBody(
          child: QuestionaireCard(
            label: _bloodPressure!,
            child: Row(
              children: const <Widget>[
                Expanded(
                  child: PicosTextField(
                    hint: 'Syst',
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  child: Text('/', style: TextStyle(fontSize: 20)),
                ),
                Expanded(
                  child: PicosTextField(
                    hint: 'Dias',
                    maxLength: 3,
                    keyboardType: TextInputType.number,
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
          ),
        ),
        PicosBody(child: Cover(title: _activityAndRest!)),
        PicosBody(
          child: TextFieldCard(
            label: _possibleWalkDistance!,
            hint: 'Meter',
          ),
        ),
        PicosBody(
          child: TextFieldCard(
            label: _sleepDuration!,
            hint: _hrs!,
          ),
        ),
        PicosBody(
          child: RadioSelectCard(
            callBackFunction: (dynamic value) {},
            label: _sleepQuality7Days!,
            options: _sleepQualityValues,
          ),
        ),
        PicosBody(child: Cover(title: _bodyAndMind!)),
        PicosBody(
          child: RadioSelectCard(
            callBackFunction: (dynamic value) {},
            label: _pain!,
            options: _painValues!,
          ),
        ),
        PicosBody(
          child: RadioSelectCard(
            callBackFunction: (dynamic value) {},
            label: _howOftenAffected!,
            description: _lowInterest!,
            options: _bodyAndMindValues!,
          ),
        ),
        PicosBody(
          child: RadioSelectCard(
            callBackFunction: (dynamic value) {},
            label: _howOftenAffected!,
            description: _dejection!,
            options: _bodyAndMindValues!,
          ),
        ),
        PicosBody(
          child: RadioSelectCard(
            callBackFunction: (dynamic value) {},
            label: _howOftenAffected!,
            description: _nervousness!,
            options: _bodyAndMindValues!,
          ),
        ),
        PicosBody(
          child: RadioSelectCard(
            callBackFunction: (dynamic value) {},
            label: _howOftenAffected!,
            description: _controlWorries!,
            options: _bodyAndMindValues!,
          ),
        ),
        PicosBody(child: Cover(title: _medicationAndTherapy!)),
        PicosBody(
          child: RadioSelectCard(
            callBackFunction: (dynamic value) {},
            label: _changedMedication!,
            options: _medicationAndTherapyValues!,
          ),
        ),
        PicosBody(
          child: RadioSelectCard(
            callBackFunction: (dynamic value) {},
            label: _changedTherapy!,
            options: _medicationAndTherapyValues!,
          ),
        ),
        PicosBody(child: Cover(title: _ready!)),
      ];
    }

    return PicosScreenFrame(
      title: _myEntries,
      body: PageView(
        children: _pageViews!,
      ),
    );
  }
}
