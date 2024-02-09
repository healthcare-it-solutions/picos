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
import '../widgets/questionnaire_page.dart';
import '../widgets/radio_select_card.dart';

/// Questionnaire body and mind page.
class BodyAndMind extends StatelessWidget {
  /// BodyAndMind constructor.
  const BodyAndMind({
    required this.previousPage,
    required this.nextPage,
    required this.onChangedInterest,
    required this.questionType,
    Key? key,
    this.initialValue,
  }) : super(key: key);

  /// Previous page button function.
  final void Function() previousPage;

  /// Next page button function.
  final void Function() nextPage;

  /// Callback for interest.
  final dynamic Function(dynamic value) onChangedInterest;

  /// Question type for body and mind.
  final String questionType;

  /// Initial body and mind value.
  final dynamic initialValue;

  static String? _howOftenAffected;
  static Map<String, dynamic>? _bodyAndMindValues;

  @override
  Widget build(BuildContext context) {
    if (_howOftenAffected == null) {
      _howOftenAffected = AppLocalizations.of(context)!.howOftenAffected;
      _bodyAndMindValues = <String, dynamic>{
        AppLocalizations.of(context)!.notAtAll: 0,
        AppLocalizations.of(context)!.onIndividualDays: 1,
        AppLocalizations.of(context)!.onMoreThanHalfDays: 2,
        AppLocalizations.of(context)!.almostEveryDays: 3,
      };
    }

    return QuestionnairePage(
      backFunction: previousPage,
      nextFunction: nextPage,
      child: RadioSelectCard(
        initialValue: initialValue,
        callback: onChangedInterest,
        label: PicosLabel(_howOftenAffected!),
        description: questionType,
        options: _bodyAndMindValues!,
      ),
    );
  }
}
