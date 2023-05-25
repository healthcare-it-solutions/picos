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

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/picos_label.dart';
import '../../../widgets/picos_select.dart';
import '../widgets/questionaire_card.dart';
import '../widgets/questionaire_page.dart';

/// Questionnaire blood pressure page.
class BloodPressure extends StatelessWidget {
  /// BloodPressure constructor.
  const BloodPressure({
    required this.previousPage,
    required this.nextPage,
    required this.onChangedSyst,
    required this.onChangedDias,
    Key? key,
    this.initialSyst,
    this.initialDias,
  }) : super(key: key);

  /// Previous page button function.
  final void Function() previousPage;

  /// Next page button function.
  final void Function() nextPage;

  /// Callback for syst.
  final dynamic Function(String value) onChangedSyst;

  /// Callback for dias.
  final dynamic Function(String value) onChangedDias;

  /// Initial Syst Value.
  final int? initialSyst;

  /// Initial Dias Value.
  final int? initialDias;

  static Map<String, String> _createBloodPressureSelection() {
    int min = 40;
    int max = 250;
    int interval = 10;
    Map<String, String> bloodPressureSelection = <String, String>{};

    int i = min;
    do {
      String entry = i.toString();
      bloodPressureSelection.addAll(<String, String>{entry: entry});

      i = i + interval;
    } while (i <= max);

    return bloodPressureSelection;
  }

  static String? _bloodPressure;
  static Map<String, String>? _bloodPressureSelection;

  @override
  Widget build(BuildContext context) {
    String? initialStringSyst;
    String? initialStringDias;

    if (initialSyst != null) {
      initialStringSyst = initialSyst.toString();
    }

    if (initialDias != null) {
      initialStringDias = initialDias.toString();
    }

    if (_bloodPressure == null) {
      _bloodPressure = AppLocalizations.of(context)!.bloodPressure;
      _bloodPressureSelection = _createBloodPressureSelection();
    }

    return QuestionairePage(
      backFunction: previousPage,
      nextFunction: nextPage,
      child: QuestionaireCard(
        label: PicosLabel(_bloodPressure!),
        child: Row(
          children: <Widget>[
            Expanded(
              child: PicosSelect(
                initialValue: initialStringSyst,
                selection: _bloodPressureSelection!,
                callBackFunction: onChangedSyst,
                hint: 'Syst',
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('/', style: TextStyle(fontSize: 20)),
            ),
            Expanded(
              child: PicosSelect(
                initialValue: initialStringDias,
                selection: _bloodPressureSelection!,
                callBackFunction: onChangedDias,
                hint: 'Dias',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
