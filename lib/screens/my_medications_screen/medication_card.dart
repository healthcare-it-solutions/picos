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
import 'package:picos/state/medications_list_bloc.dart';
import 'package:picos/widgets/picos_list_card.dart';

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

    EdgeInsetsGeometry padding = const EdgeInsets.only(right: 13);

    if (topTime == AppLocalizations.of(context)!.noon) {
      padding = const EdgeInsets.only(left: 13);
    }

    return Expanded(
      child: Padding(
        padding: padding,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: MedicationCardTile(topTime, topAmount),
            ),
            const Divider(
              thickness: dividerThickness,
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
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
    return PicosListCard(
      title: _medication.compound,
      edit: () {
        Navigator.of(context)
            .pushNamed('/add-medication', arguments: _medication);
      },
      delete: () {
        context.read<MedicationsListBloc>().add(RemoveMedication(_medication));
      },
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
    );
  }
}
