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
import 'package:picos/api/backend_patients_list_api.dart';
import 'package:picos/models/patients_list_element.dart';
import 'package:picos/screens/study_nurse_screen/menu_screen/patients_list_card_tile.dart';
import 'package:picos/widgets/picos_list_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../state/objects_list_bloc.dart';

/// The card displaying patient information.
class PatientsListCard extends StatelessWidget {
  /// Creates the card with the patient.
  const PatientsListCard(
      this._patientsListElement, {
        Key? key,
      }) : super(key: key);

  final PatientsListElement _patientsListElement;

  _createCardColumn(
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

    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 15),
            child: PatientsListCardTile(firstDenotation, firstValue),
          ),
          const Divider(
            thickness: dividerThickness,
          ),
          Container(
            padding: const EdgeInsets.only(right: 15),
            child: PatientsListCardTile(secondDenotation, secondValue),
          ),
          const Divider(
            thickness: dividerThickness,
          ),
          Container(
            padding: const EdgeInsets.only(right: 15),
            child: PatientsListCardTile(thirdDenotation, thirdValue),
          ),
          const Divider(
            thickness: dividerThickness,
          ),
          Container(
            padding: const EdgeInsets.only(right: 15),
            child: PatientsListCardTile(fourthDenotation, fourthValue),
          ),
          const Divider(
            thickness: dividerThickness,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PicosListCard(
      title:
      '${_patientsListElement.patient.firstName} ${_patientsListElement.patient.familyName}',
      edit: () {
        Navigator.of(context).pushNamed(
          '/study-nurse-screen/menu-screen/add-patient',
          arguments: _patientsListElement,
        );
      },
      delete: () {
        context
            .read<ObjectsListBloc<BackendPatientsListApi>>()
            .add(RemoveObject(_patientsListElement));
      },
      child: Row(
        children: <Expanded>[
          _createCardColumn(
            AppLocalizations.of(context)!.email,
            _patientsListElement.patient.email,
            AppLocalizations.of(context)!.address,
            _patientsListElement.patient.address,
            AppLocalizations.of(context)!.patientID,
            _patientsListElement.patientData.patientID,
            AppLocalizations.of(context)!.caseNumber,
            _patientsListElement.patientData.caseNumber,
          ),
        ],
      ),
    );
  }
}