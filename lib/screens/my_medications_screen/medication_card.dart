import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/models/medication.dart';
import 'package:picos/screens/my_medications_screen/medication_card_tile.dart';
import 'package:picos/states/medications_list_bloc.dart';
import 'package:picos/themes/global_theme.dart';

import '../../repository/medications_repository.dart';

/// The card displaying a medication plan.
class MedicationCard extends StatelessWidget {
  /// Creates the card with the medication plan.
  const MedicationCard(
    this._medication, {
    Key? key,
  }) : super(key: key);

  final Medication _medication;

  _createCardColumn(
    BuildContext context,
    String topTime,
    String bottomTime,
    String topAmount,
    String bottomAmount,
  ) {
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
          onTap: () {
            Navigator.of(context)
                .pushNamed('/add-medication', arguments: _medication);
          },
          onLongPress: () {
            context
                .read<MedicationsListBloc>()
                .add(RemoveMedication(_medication));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Ink(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  color: Theme.of(context).extension<GlobalTheme>()!.darkGreen2,
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
                      MedicationsRepository.amountToString(_medication.morning),
                      MedicationsRepository.amountToString(_medication.evening),
                    ),
                    _createCardColumn(
                      context,
                      AppLocalizations.of(context)!.noon,
                      AppLocalizations.of(context)!.toTheNight,
                      MedicationsRepository.amountToString(_medication.noon),
                      MedicationsRepository.amountToString(_medication.night),
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
