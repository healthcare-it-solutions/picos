import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/picos_label.dart';
import '../widgets/questionaire_page.dart';
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
  }) : super(key: key);

  /// Previous page button function.
  final void Function() previousPage;

  /// Next page button function.
  final void Function() nextPage;

  /// Callback for interest.
  final dynamic Function(dynamic value) onChangedInterest;

  /// Question type for body and mind.
  final String questionType;

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

    return QuestionairePage(
      backFunction: previousPage,
      nextFunction: nextPage,
      child: RadioSelectCard(
        callback: onChangedInterest,
        label: PicosLabel(label: _howOftenAffected!),
        description: questionType,
        options: _bodyAndMindValues!,
      ),
    );
  }
}
