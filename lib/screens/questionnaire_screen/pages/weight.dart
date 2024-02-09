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

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/questionnaire_page.dart';
import '../widgets/text_field_card.dart';

/// Questionnaire Weight page.
class Weight extends StatefulWidget {
  /// Weight constructor.
  const Weight({
    required this.previousPage,
    required this.nextPage,
    required this.onChangedBodyWeight,
    this.bodyHeight,
    Key? key,
    this.initialValue,
    this.initialBmi,
  }) : super(key: key);

  /// Previous page button function.
  final void Function() previousPage;

  /// Next page button function.
  final void Function() nextPage;

  /// Callback for body weight.
  final dynamic Function(double? weight, double? bmi) onChangedBodyWeight;

  /// The body height.
  final int? bodyHeight;

  /// Populates the field with an initial value.
  final double? initialValue;

  /// Populates the BMI field with an initial value.
  final double? initialBmi;

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  static String? _bodyWeight;
  static String? _autoCalc;
  static String? _unknownHeight;
  static String? _isInvalid;

  double _bmi = 0;
  String _hint = '';
  bool _error = false;

  double _calculateBmi(int height, double bodyWeight) {
    return (bodyWeight / pow(height / 100, 2));
  }

  void _createHint() {
    if (widget.initialBmi != null && _hint.isEmpty) {
      _bmi = widget.initialBmi!;
      _hint = widget.initialBmi.toString();
      return;
    }

    if (widget.bodyHeight == null && _hint.isNotEmpty) {
      return;
    }

    if (widget.bodyHeight == null) {
      _hint = _unknownHeight!;
      return;
    }

    _hint = _bmi == 0 ? 'kg/m² $_autoCalc' : _bmi.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (_bodyWeight == null) {
      _bodyWeight = AppLocalizations.of(context)!.bodyWeight;
      _autoCalc = AppLocalizations.of(context)!.autoCalc;
      _unknownHeight = AppLocalizations.of(context)!.unknownHeight;
      _isInvalid = AppLocalizations.of(context)!.isInvalid;
    }

    String label = _bodyWeight!;

    if (_error) {
      label = '${_bodyWeight!} ${_isInvalid!}';
    }

    _createHint();

    return QuestionnairePage(
      backFunction: widget.previousPage,
      nextFunction: widget.nextPage,
      child: Column(
        children: <TextFieldCard>[
          TextFieldCard(
            decimalValue: true,
            initialValue: widget.initialValue,
            label: label,
            hint: 'kg',
            onChanged: (String weightString) {
              if (weightString.isEmpty) {
                widget.onChangedBodyWeight(null, null);
                setState(() {
                  _bmi = 0;
                  _error = false;
                });
                return;
              }

              double? weight = double.tryParse(weightString);

              if (weight == null) {
                widget.onChangedBodyWeight(null, null);
                setState(() {
                  _bmi = 0;
                  _error = true;
                });
                return;
              }

              _error = false;

              if (widget.bodyHeight == null) {
                widget.onChangedBodyWeight(weight, null);
                return;
              }

              setState(() {
                _bmi = _calculateBmi(widget.bodyHeight!, weight);
              });

              widget.onChangedBodyWeight(weight, _bmi);
            },
          ),
          TextFieldCard(
            decimalValue: true,
            label: 'BMI',
            hint: _hint,
            disabled: true,
          ),
        ],
      ),
    );
  }
}
