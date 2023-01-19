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

  static String? _bodyWeight;
  static String? _autoCalc;

  @override
  Widget build(BuildContext context) {

    if (_bodyWeight == null) {
      _bodyWeight = AppLocalizations.of(context)!.bodyWeight;
      _autoCalc = AppLocalizations.of(context)!.autoCalc;
    }

    return QuestionairePage(
      backFunction: previousPage,
      nextFunction: nextPage,
      child: Column(
        children: <TextFieldCard>[
          TextFieldCard(
            label: _bodyWeight!,
            hint: 'kg',
            onChanged: onChangedBodyWeight,
          ),
          TextFieldCard(
            label: 'BMI',
            hint: 'kg/m² $_autoCalc',
            onChanged: onChangedBmi,
          ),
        ],
      ),
    );
  }
}
