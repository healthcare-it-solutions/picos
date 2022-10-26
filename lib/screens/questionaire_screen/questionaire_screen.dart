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
import 'package:picos/screens/questionaire_screen/widgets/text_field_card.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:picos/widgets/picos_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/picos_label.dart';

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

      _pageViews = <PicosBody>[
        PicosBody(child: Cover(title: _vitalValues!)),
        PicosBody(
          child: TextFieldCard(
            label: _bodyWeight!,
            hint: 'kg',
          ),
        ),
        PicosBody(
          child: TextFieldCard(
            label: 'BMI',
            hint: 'kg/m² ${_autoCalc!}',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PicosLabel(label: _bloodPressure!),
                const SizedBox(height: 15),
                Row(
                  children: const <Widget>[
                    Expanded(
                      child: PicosTextField(
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
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
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
        PicosBody(child: Text(_activityAndRest!)),
        PicosBody(child: Cover(title: _bodyAndMind!)),
        PicosBody(child: Text(_bodyAndMind!)),
        PicosBody(child: Text(_bodyAndMind!)),
        PicosBody(child: Text(_bodyAndMind!)),
        PicosBody(child: Text(_bodyAndMind!)),
        PicosBody(child: Text(_bodyAndMind!)),
        PicosBody(child: Cover(title: _medicationAndTherapy!)),
        PicosBody(child: Text(_medicationAndTherapy!)),
        PicosBody(child: Text(_medicationAndTherapy!)),
        PicosBody(child: Text(_medicationAndTherapy!)),
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
