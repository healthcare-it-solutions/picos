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
import '../widgets/questionnaire_card.dart';
import '../widgets/questionnaire_page.dart';

/// Questionnaire blood pressure page.
class BloodPressure extends StatefulWidget {
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

  @override
  State<BloodPressure> createState() => _BloodPressureState();
}

class _BloodPressureState extends State<BloodPressure> {
  static Map<String, String> _createBloodPressureSelection(int min,
      int max, [
        int interval = 5,
      ]) {
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
  static String? _checkValue;
  static Map<String, String>? _systSelection;
  static Map<String, String>? _diasSelection;

  int? _valueSyst;
  int? _valueDias;
  String? _label;

  bool _checkValues() {
    if (_valueSyst == null && _valueDias == null) {
      _setLabel(_bloodPressure!);
      return false;
    }

    if (_valueSyst == null || _valueDias == null) {
      return true;
    }

    if (_valueSyst! <= _valueDias!) {
      _setLabel(_checkValue!);
      return true;
    }

    if (_valueSyst! < 90 || _valueSyst! > 160 || _valueDias! < 60 ||
        _valueDias! > 100) {
      _setLabel(_checkValue!);
      return false;
    }

    _setLabel(_bloodPressure!);
    return false;
  }

  void _setLabel(String label) {
    if (label == _label) {
      return;
    }

    _label = label;
  }

  @override
  void initState() {
    _valueDias = widget.initialDias;
    _valueSyst = widget.initialSyst;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? initialStringSyst;
    String? initialStringDias;

    if (widget.initialSyst != null) {
      initialStringSyst = widget.initialSyst.toString();
    }

    if (widget.initialDias != null) {
      initialStringDias = widget.initialDias.toString();
    }

    if (_bloodPressure == null) {
      _bloodPressure = AppLocalizations.of(context)!.bloodPressure;
      _checkValue = AppLocalizations.of(context)!.checkValue;
      _systSelection = _createBloodPressureSelection(70, 200);
      _diasSelection = _createBloodPressureSelection(35, 130);
    }

    final bool disabledNext = _checkValues();

    return QuestionairePage(
      disabledNext: disabledNext,
      backFunction: widget.previousPage,
      nextFunction: widget.nextPage,
      child: QuestionaireCard(
        label: PicosLabel(_label!),
        child: Row(
          children: <Widget>[
            Expanded(
              child: PicosSelect(
                initialValue: initialStringSyst,
                selection: _systSelection!,
                callBackFunction: (String value) {
                  widget.onChangedSyst(value);
                  setState(() {
                    _valueSyst = int.tryParse(value);
                  });
                },
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
                selection: _diasSelection!,
                callBackFunction: (String value) {
                  widget.onChangedDias(value);
                  setState(() {
                    _valueDias = int.tryParse(value);
                  });
                },
                hint: 'Dias',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
