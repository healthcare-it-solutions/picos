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
import 'package:picos/api/backend_patient_api.dart';
import 'package:picos/models/patient.dart';
import 'package:picos/screens/study_nurse_screen/menu_screen/patient_card_tile.dart';
import 'package:picos/state/objects_list_bloc.dart';
import 'package:picos/widgets/picos_list_card.dart';

/// The card displaying patient information.
class PatientCard extends StatelessWidget {
  /// Creates the card with the patient.
  const PatientCard(
    this._patient, {
    Key? key,
  }) : super(key: key);

  final Patient _patient;

  _createCardColumn(
    BuildContext context,
    String denotationTop,
    String valueTop,
    String denotationBottom,
    String valueBottom,
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
              child: PatientCardTile(denotationTop, valueTop),
            ),
            const Divider(
              thickness: dividerThickness,
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: PatientCardTile(denotationBottom, valueBottom),
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
      delete: () {
        context
            .read<ObjectsListBloc<BackendPatientApi>>()
            .add(RemoveObject(_patient));
      },
      child: Row(
        children: <Expanded>[
          _createCardColumn(
            context,
            'Email Address',
            _patient.email,
            'Form',
            _patient.formOfAddress,
          ),
          _createCardColumn(
            context,
            'Phone Number',
            _patient.number,
            'Address',
            _patient.address,
          ),
        ],
      ),
    );
  }
}
