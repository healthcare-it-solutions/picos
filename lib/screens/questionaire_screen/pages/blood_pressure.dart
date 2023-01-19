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
  }) : super(key: key);

  /// Previous page button function.
  final void Function() previousPage;

  /// Next page button function.
  final void Function() nextPage;

  /// Callback for syst.
  final dynamic Function(String value) onChangedSyst;

  /// Callback for dias.
  final dynamic Function(String value) onChangedDias;

  static List<String> _createBloodPressureSelection() {
    int min = 40;
    int max = 250;
    int interval = 10;
    List<String> bloodPressureSelection = <String>[];

    int i = min;
    do {
      bloodPressureSelection.add(i.toString());

      i = i + interval;
    } while (i <= max);

    return bloodPressureSelection;
  }

  static String? _bloodPressure;
  static List<String>? _bloodPressureSelection;

  @override
  Widget build(BuildContext context) {
    if (_bloodPressure == null) {
      _bloodPressure = AppLocalizations.of(context)!.bloodPressure;
      _bloodPressureSelection = _createBloodPressureSelection();
    }

    return QuestionairePage(
      backFunction: previousPage,
      nextFunction: nextPage,
      child: QuestionaireCard(
        label: PicosLabel(label: _bloodPressure!),
        child: Row(
          children: <Widget>[
            Expanded(
              child: PicosSelect(
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
