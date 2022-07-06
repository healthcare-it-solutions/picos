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
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Text(
                    _medication.compound,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
