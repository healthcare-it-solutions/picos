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
import '../../../api/backend_medications_api.dart';
import '../../../models/medication.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../state/objects_list_bloc.dart';
import 'medication_card.dart';

/// A List with all medications.
class MedicationsList extends StatefulWidget {
  /// Creates the medication list.
  const MedicationsList({Key? key}) : super(key: key);

  @override
  State<MedicationsList> createState() => _MedicationsListState();
}

class _MedicationsListState extends State<MedicationsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObjectsListBloc<BackendMedicationsApi>,
        ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        if (state.status == ObjectsListStatus.initial ||
            state.status == ObjectsListStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == ObjectsListStatus.failure) {
          return Center(
            child: Text(AppLocalizations.of(context)!.loadingFailed),
          );
        }

        return ListView.builder(
          itemCount: state.objectsList.length,
          itemBuilder: (BuildContext context, int index) {
            return MedicationCard(state.objectsList[index] as Medication);
          },
        );
      },
    );
  }
}
