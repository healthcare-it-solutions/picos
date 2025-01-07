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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/screens/study_nurse_screen/menu_screen/widgets/patients_list_card.dart';
import 'package:picos/state/objects_list_bloc.dart';

/// A List with all patients.
class PatientsList extends StatelessWidget {
  /// Creates the patients list.
  const PatientsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObjectsListBloc<BackendPatientsListApi>,
        ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        if (state.objectsList.isEmpty &&
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
            return PatientsListCard(
              state.objectsList[index] as PatientsListElement,
            );
          },
        );
      },
    );
  }
}
