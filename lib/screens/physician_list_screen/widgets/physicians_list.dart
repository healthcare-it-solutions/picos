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
import 'package:picos/api/backend_physicians_api.dart';
import 'package:picos/gen_l10n/app_localizations.dart';
import 'package:picos/screens/physician_list_screen/widgets/physician_card.dart';

import '../../../models/physician.dart';
import '../../../state/objects_list_bloc.dart';

/// A list with all physicians.
class PhysiciansList extends StatefulWidget {
  /// Creates the PhysiciansList.
  const PhysiciansList({Key? key}) : super(key: key);

  @override
  State<PhysiciansList> createState() => _PhysiciansListState();
}

class _PhysiciansListState extends State<PhysiciansList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObjectsListBloc<BackendPhysiciansApi>, ObjectsListState>(
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
            return PhysicianCard(state.objectsList[index] as Physician);
          },
        );
      },
    );
  }
}
