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
import 'package:picos/models/abstract_database_object.dart';
import '../../../api/backend_therapies_api.dart';
import '../../../models/therapy.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../state/objects_list_bloc.dart';
import 'therapy_item.dart';

/// A List with all therapies.
class TherapiesList extends StatefulWidget {
  /// Creates TherapiesList.
  const TherapiesList({Key? key}) : super(key: key);

  @override
  State<TherapiesList> createState() => _TherapiesListState();
}

class _TherapiesListState extends State<TherapiesList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObjectsListBloc<BackendTherapiesApi>, ObjectsListState>(
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

        state.objectsList.sort(
          (AbstractDatabaseObject a, AbstractDatabaseObject b) =>
              (b as Therapy).date.compareTo((a as Therapy).date),
        );

        return ListView.separated(
          itemCount: state.objectsList.length,
          itemBuilder: (BuildContext context, int index) {
            return TherapyItem(state.objectsList[index] as Therapy);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                thickness: 1,
                height: 0,
              ),
            );
          },
        );
      },
    );
  }
}
