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
import 'package:picos/models/patient.dart';
import 'package:picos/models/patient_data.dart';
import 'package:picos/screens/study_nurse_screen/menu_screen/patient_card_tile.dart';
import 'package:picos/widgets/picos_list_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// The card displaying patient information.
class PatientCard extends StatelessWidget {
  /// Creates the card with the patient.
  const PatientCard(
    this._patient,
    this._patientData, {
    Key? key,
  }) : super(key: key);

  final Patient _patient;

  final PatientData _patientData;

  _createCardColumn(
    BuildContext context,
    String firstDenotation,
    String firstValue,
    String secondDenotation,
    String secondValue,
    String thirdDenotation,
    String thirdValue,
    String fourthDenotation,
    String fourthValue,
  ) {
    const double dividerThickness = 1.5;

    EdgeInsetsGeometry padding = const EdgeInsets.only(right: 13);

    return Expanded(
      child: Padding(
        padding: padding,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: PatientCardTile(firstDenotation, firstValue),
            ),
            const Divider(
              thickness: dividerThickness,
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: PatientCardTile(secondDenotation, secondValue),
            ),
            const Divider(
              thickness: dividerThickness,
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: PatientCardTile(thirdDenotation, thirdValue),
            ),
            const Divider(
              thickness: dividerThickness,
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: PatientCardTile(fourthDenotation, fourthValue),
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
      title: '${_patient.firstName} ${_patient.familyName}',
        edit: () {
          Navigator.of(context).pushNamed(
            '/study-nurse-screen/menu-screen/add-patient',
            arguments: _patient,
          );
        },
      child: Row(
        children: <Expanded>[
          _createCardColumn(
            context,
            AppLocalizations.of(context)!.email,
            _patient.email,
            AppLocalizations.of(context)!.address,
            _patient.address!,
            AppLocalizations.of(context)!.patientID,
            _patientData.patientID,
            AppLocalizations.of(context)!.caseNumber,
            _patientData.caseNumber,
          ),
        ],
      ),
    );
  }
}
