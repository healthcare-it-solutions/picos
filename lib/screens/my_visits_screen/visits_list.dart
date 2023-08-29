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
import 'package:picos/api/backend_stays_api.dart';
import 'package:picos/models/stay.dart';
import 'package:picos/screens/my_visits_screen/visit_item.dart';
import '../../state/objects_list_bloc.dart';

/// A List with all visits.
class VisitsList extends StatefulWidget {
  /// Creates VisitsList.
  const VisitsList({Key? key}) : super(key: key);

  @override
  State<VisitsList> createState() => _VisitsListState();
}

class _VisitsListState extends State<VisitsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObjectsListBloc<BackendStaysApi>, ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        if (state.status == ObjectsListStatus.initial ||
            state.status == ObjectsListStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == ObjectsListStatus.failure) {
          return const Center(
            child: Text('Error'),
          );
        }

        return ListView.separated(
          itemCount: state.objectsList.length,
          itemBuilder: (BuildContext context, int index) {
            return VisitItem(state.objectsList[index] as Stay);
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
