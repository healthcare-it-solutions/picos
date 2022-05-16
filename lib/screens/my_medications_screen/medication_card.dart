import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/models/medication.dart';
import 'package:picos/screens/my_medications_screen/medication_card_tile.dart';

/// The card displaying a medication plan.
class MedicationCard extends StatelessWidget {
  /// Creates the card with the medication plan.
  const MedicationCard(
    this._medication, {
    Key? key,
  }) : super(key: key);

  final Medication _medication;

  _createCardColumn(BuildContext context, String topTime, String bottomTime,
      String topAmount, String bottomAmount) {
    const double dividerThickness = 1.5;
    const EdgeInsets symmetricPadding = EdgeInsets.symmetric(horizontal: 10);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Padding(
              padding: symmetricPadding,
              child: MedicationCardTile(topTime, topAmount),
            ),
            const Divider(
              thickness: dividerThickness,
            ),
            Padding(
              padding: symmetricPadding,
              child: MedicationCardTile(bottomTime, bottomAmount),
            ),
            const Divider(
              thickness: dividerThickness,
            ),
          ],
        ),
      ),
    );
  }

  String _convertMedicationAmountType(double value) {
    List<String> values = value.toString().split('.');
    String intValue = values[0];
    String half = values[1];

    if (intValue == '0' && half != '0') {
      return '1/2';
    }

    if (intValue != '0' && half != '0') {
      return intValue + ' 1/2';
    }

    return intValue;
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(10);

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        elevation: 5,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () {},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Ink(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.medication),
                    Container(
                      child: Text(_medication.compound),
                      padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: <Expanded>[
                    _createCardColumn(
                      context,
                      AppLocalizations.of(context)!.inTheMorning,
                      AppLocalizations.of(context)!.inTheEvening,
                      _convertMedicationAmountType(_medication.morning),
                      _convertMedicationAmountType(_medication.evening),
                    ),
                    _createCardColumn(
                      context,
                      AppLocalizations.of(context)!.noon,
                      AppLocalizations.of(context)!.toTheNight,
                      _convertMedicationAmountType(_medication.noon),
                      _convertMedicationAmountType(_medication.night),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
