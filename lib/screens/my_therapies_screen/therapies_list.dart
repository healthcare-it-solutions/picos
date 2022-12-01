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
import '../../state/therapies/therapies_list_bloc.dart';
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
    return BlocBuilder<TherapiesListBloc,TherapiesListState>(
      builder: (BuildContext context, TherapiesListState state) {
        if (state.therapiesList.isEmpty &&
            state.status == TherapiesListStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == TherapiesListStatus.failure) {
          return const Center(
            child: Text('Error'),
          );
        }

        return ListView.separated(
          itemCount: state.therapiesList.length,
          itemBuilder: (BuildContext context, int index) {
            return TherapyItem(state.therapiesList[index]);
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
