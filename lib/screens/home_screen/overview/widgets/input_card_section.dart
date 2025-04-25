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
import 'package:picos/models/daily_input.dart';
import 'package:picos/widgets/picos_ink_well_button.dart';
import 'package:picos/widgets/picos_overflow_text.dart';

import '../../../../state/objects_list_bloc.dart';
import '../../../../themes/global_theme.dart';
import '../../../../util/backend.dart';
import 'mini_calendar.dart';

/// This class implements the top section of the 'overview'.
class InputCardSection extends StatelessWidget {
  /// InputCardSection constructor
  const InputCardSection({required this.state, Key? key}) : super(key: key);

  ///State of the required objects request;
  final ObjectsListState state;

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    const EdgeInsets inset = EdgeInsets.all(15);

    DailyInput? dailyInput;
    if (state.status == ObjectsListStatus.success) {
      dailyInput = state.objectsList[0] as DailyInput;
      if (Backend.userRole == UserRoles.testPatient) {
        dailyInput = DailyInput(
          day: -1,
          hasDemoPurposes: true,
          patientProfile: dailyInput.patientProfile,
        );
      }
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: inset,
      child: Padding(
        padding: inset,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                PicosOverflowText(
                  text: AppLocalizations.of(context)!.myEntries,
                  style: TextStyle(
                    fontSize: 23,
                    color: theme.darkGreen1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(
              height: 1,
              color: theme.darkGreen1,
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                Image.asset('assets/Eingabe_Start.png'),
                Align(
                  heightFactor: 1,
                  widthFactor: 3,
                  alignment: Alignment.topLeft,
                  child: MiniCalendar(),
                ),
              ],
            ),
            const SizedBox(height: 10),
            PicosInkWellButton(
              disabled:
                  state.status == ObjectsListStatus.success ? false : true,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              text: state.status == ObjectsListStatus.failure
                  ? AppLocalizations.of(context)!.loadingFailed
                  : AppLocalizations.of(context)!.howFeel,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/questionnaire-screen/questionnaire-screen',
                  arguments: dailyInput,
                );
              },
              fontSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
