import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/questionaire_page.dart';
import '../widgets/text_field_card.dart';

/// Questionnaire Weight page.
class Weight extends StatelessWidget {
  /// Weight constructor.
  const Weight({
    required this.previousPage,
    required this.nextPage,
    required this.onChangedBodyWeight,
    required this.onChangedBmi,
    Key? key,
  }) : super(key: key);

  /// Previous page button function.
  final void Function() previousPage;

  /// Next page button function.
  final void Function() nextPage;

  /// Callback for body weight.
  final dynamic Function(String value) onChangedBodyWeight;

  /// Callback for bmi.
  final dynamic Function(String value) onChangedBmi;

  @override
  Widget build(BuildContext context) {
    String bodyWeight = AppLocalizations.of(context)!.bodyWeight;
    String autoCalc = AppLocalizations.of(context)!.autoCalc;

    return QuestionairePage(
      backFunction: previousPage,
      nextFunction: nextPage,
      child: Column(
        children: <TextFieldCard>[
          TextFieldCard(
            label: bodyWeight,
            hint: 'kg',
            onChanged: onChangedBodyWeight,
          ),
          TextFieldCard(
            label: 'BMI',
            hint: 'kg/m² $autoCalc',
            onChanged: onChangedBmi,
          ),
        ],
      ),
    );
  }
}
