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

import '../widgets/questionaire_page.dart';
import '../widgets/text_field_card.dart';

/// Questionnaire blood sugar page.
class BloodSugar extends StatefulWidget {
  /// BloodSugar constructor.
  const BloodSugar({
    required this.previousPage,
    required this.nextPage,
    required this.onChanged,
    Key? key,
    this.initialValue,
  }) : super(key: key);

  /// Previous page button function.
  final void Function() previousPage;

  /// Next page button function.
  final void Function() nextPage;

  /// Callback for syst.
  final dynamic Function(String value) onChanged;

  /// Initial value.
  final int? initialValue;

  @override
  State<BloodSugar> createState() => _BloodSugarState();
}

class _BloodSugarState extends State<BloodSugar> {
  static String? _bloodSugar;
  static String? _checkValue;
  int? _value;

  bool _setDisabledNext() {
    if (_value == null) {
      return false;
    }

    if (_value! < 50 || _value! > 300) {
      return true;
    }

    return false;
  }

  String _setLabel() {
    if (_value == null) {
      return _bloodSugar!;
    }

    if (_value! < 70 || _value! > 120) {
      return _checkValue!;
    }

    return _bloodSugar!;
  }

  @override void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_bloodSugar == null) {
      _bloodSugar = AppLocalizations.of(context)!.bloodSugar;
      _checkValue = AppLocalizations.of(context)!.checkValue;
    }

    final bool disabledNext = _setDisabledNext();
    final String label = _setLabel();

    return QuestionairePage(
      disabledNext: disabledNext,
      backFunction: widget.previousPage,
      nextFunction: widget.nextPage,
      child: TextFieldCard(
        initialValue: widget.initialValue,
        label: label,
        hint: 'mg/dL',
        onChanged: (String value) {
          widget.onChanged(value);
          setState(() {
            _value = int.tryParse(value);
          });
        },
      ),
    );
  }
}
