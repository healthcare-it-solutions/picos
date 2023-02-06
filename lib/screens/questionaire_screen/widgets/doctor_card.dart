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

/// The questionaire card for the question if the user visited a doctor.
class DoctorCard extends StatelessWidget {
  /// Creates DoctorCard.
  const DoctorCard({
    required this.callback,
    required this.radioOptions,
    Key? key,
  }) : super(key: key);

  /// The callback that is executed, when an item is selected.
  final Function(dynamic value) callback;

  /// The selectable options.
  final Map<String, dynamic> radioOptions;

  static Text? _label;

  static const TextStyle _labelStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 17);

  @override
  Widget build(BuildContext context) {
    // Class init.
    if (_label == null) {
      switch (Platform.localeName) {
        case 'de_DE':
          _label = Text.rich(
            TextSpan(
              style: _labelStyle,
              text: AppLocalizations.of(context)!.questionaireDoctorVisit1,
              children: <TextSpan>[
                TextSpan(
                  text: AppLocalizations.of(context)!
                      .questionaireDoctorVisitUnscheduled,
                  style: const TextStyle(decoration: TextDecoration.underline),
                ),
                TextSpan(
                  text: AppLocalizations.of(context)!.questionaireDoctorVisit2,
                ),
              ],
            ),
          );
          break;
        default:
          _label = Text.rich(
            TextSpan(
              style: _labelStyle,
              text: AppLocalizations.of(context)!.questionaireDoctorVisit1,
              children: <TextSpan>[
                TextSpan(
                  text: AppLocalizations.of(context)!.questionaireDoctorVisit2,
                ),
                TextSpan(
                  text: AppLocalizations.of(context)!
                      .questionaireDoctorVisitUnscheduled,
                  style: const TextStyle(decoration: TextDecoration.underline),
                ),
              ],
            ),
          );
      }
    }

    return RadioSelectCard(
      callback: callback,
      label: _label!,
      options: radioOptions,
    );
  }
}
