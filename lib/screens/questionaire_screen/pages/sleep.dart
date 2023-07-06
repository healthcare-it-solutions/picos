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

/// Questionnaire Sleep page.
class Sleep extends StatefulWidget {
  /// Sleep constructor.
  const Sleep({
    required this.previousPage,
    required this.nextPage,
    required this.onChangedSleepDuration,
    this.sleepDuration,
    Key? key,
    this.initialValue,
  }) : super(key: key);

  /// Previous page button function.
  final void Function() previousPage;

  /// Next page button function.
  final void Function() nextPage;

  /// Callback for sleep duration.
  final dynamic Function(double? duration) onChangedSleepDuration;

  /// The sleep duration.
  final double? sleepDuration;

  /// Populates the field with an initial value.
  final double? initialValue;

  @override
  State<Sleep> createState() => _SleepState();
}

class _SleepState extends State<Sleep> {
  static String? _sleepDuration;
  static String? _isInvalid;

  bool _error = false;

  @override
  Widget build(BuildContext context) {
    if (_sleepDuration == null) {
      _sleepDuration = AppLocalizations.of(context)!.sleepDuration;
      _isInvalid = AppLocalizations.of(context)!.isInvalid;
    }

    String label = _sleepDuration!;

    if (_error) {
      label = '${_sleepDuration!} ${_isInvalid!}';
    }

    return QuestionairePage(
      backFunction: widget.previousPage,
      nextFunction: widget.nextPage,
      child: TextFieldCard(
        decimalValue: true,
        initialValue: widget.initialValue,
        label: label,
        hint: AppLocalizations.of(context)!.hrs,
        onChanged: (String durationString) {
          if (durationString.isEmpty) {
            widget.onChangedSleepDuration(null);
            setState(() {
              _error = false;
            });
            return;
          }

          double? duration = double.tryParse(durationString);

          if (duration == null) {
            widget.onChangedSleepDuration(null);
            setState(() {
              _error = true;
            });
            return;
          }

          setState(() {
            _error = false;
          });

          widget.onChangedSleepDuration(duration);
        },
      ),
    );
  }
}
