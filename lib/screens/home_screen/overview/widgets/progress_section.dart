/*
*  This file is part of Picos, a health tracking mobile app
*  Copyright (C) 2022 Healthcare IT Solutions GmbH
*
*  This program is free software: you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation, either version 3 of the License, or
*  (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  You should have received a copy of the GNU General Public License
*  along with this program. If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/screens/home_screen/overview/widgets/progress_tile.dart';
import 'package:picos/state/objects_list_bloc.dart';

import '../../../../models/daily_input.dart';
import '../../../../themes/global_theme.dart';

/// Widget which is used for displaying
/// the progress bar in the corresponding section on the "overview"-screen
class ProgressSection extends StatelessWidget {
  /// ProgressSection constructor
  const ProgressSection({required this.state, Key? key}) : super(key: key);

  ///State of the required objects request;
  final ObjectsListState state;

  Widget _buildContent(BuildContext context) {
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
      scrollDirection: Axis.horizontal,
      itemCount: state.objectsList.length,
      itemBuilder: (BuildContext context, int index) {
        return ProgressTile(
          dailyInput: state.objectsList[index] as DailyInput,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.submittedValues,
                style: TextStyle(
                  color: theme.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                color: theme.white,
                height: 5,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context)!.completeTheDays,
                style: TextStyle(
                  color: theme.white,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 150, child: _buildContent(context)),
      ],
    );
  }
}
