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

import 'package:picos/gen_l10n/app_localizations.dart';

import '../widgets/questionnaire_page.dart';
import '../widgets/text_field_card.dart';

/// Questionnaire heart frequency page.
class HeartFrequency extends StatefulWidget {
  /// HeartFrequency constructor.
  const HeartFrequency({
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
  State<HeartFrequency> createState() => _HeartFrequencyState();
}

class _HeartFrequencyState extends State<HeartFrequency> {
  static String? _heartFrequency;
  static String? _checkValue;
  int? _value;

  bool _setDisabledNext() {
    if (_value == null) {
      return false;
    }

    if (_value! < 30 || _value! > 180) {
      return true;
    }

    return false;
  }

  String _setLabel() {
    if (_value == null) {
      return _heartFrequency!;
    }

    if (_value! < 45 || _value! > 110) {
      return _checkValue!;
    }

    return _heartFrequency!;
  }

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_heartFrequency == null) {
      _heartFrequency = AppLocalizations.of(context)!.heartFrequency;
      _checkValue = AppLocalizations.of(context)!.checkValue;
    }

    final bool disabledNext = _setDisabledNext();
    final String label = _setLabel();

    return QuestionnairePage(
      disabledNext: disabledNext,
      backFunction: widget.previousPage,
      nextFunction: widget.nextPage,
      child: TextFieldCard(
        initialValue: widget.initialValue,
        label: label,
        hint: 'bpm',
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
