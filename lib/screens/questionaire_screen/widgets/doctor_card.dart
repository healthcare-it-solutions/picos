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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:picos/screens/questionaire_screen/widgets/radio_select_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/picos_label.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    required this.callback,
    required this.radioOptions,
    Key? key,
  }) : super(key: key);

  final Function(dynamic value) callback;

  final Map<String, dynamic> radioOptions;

  static String? _questionaireDoctorVisit1;
  static String? _questionaireDoctorVisit2;
  static String? _questionaireDoctorVisitUnscheduled;
  static String? _label;

  @override
  Widget build(BuildContext context) {
    // Class init.
    if (_questionaireDoctorVisit1 == null) {
      _questionaireDoctorVisit1 =
          AppLocalizations.of(context)!.questionaireDoctorVisit1;
      _questionaireDoctorVisit2 =
          AppLocalizations.of(context)!.questionaireDoctorVisit2;
      _questionaireDoctorVisitUnscheduled =
          AppLocalizations.of(context)!.questionaireDoctorVisitUnscheduled;

      switch (Platform.localeName) {
        case 'de_DE':
          _label = _questionaireDoctorVisit1! +
              _questionaireDoctorVisitUnscheduled! +
              _questionaireDoctorVisit2!;
          break;
        default:
          _label = _questionaireDoctorVisit1! +
              _questionaireDoctorVisit2! +
              _questionaireDoctorVisitUnscheduled!;
      }
    }

    return RadioSelectCard(
      callback: callback,
      label: PicosLabel(label: _label!),
      options: radioOptions,
    );
  }
}
