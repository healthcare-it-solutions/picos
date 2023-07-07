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

import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:picos/models/daily_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../themes/global_theme.dart';

/// A list tile for showing the questionnaire progress.
class ProgressTile extends StatelessWidget {
  /// Creates ProgressTile.
  const ProgressTile({required this.dailyInput, Key? key}) : super(key: key);

  /// The [DailyInput] used to create the tile.
  final DailyInput dailyInput;

  String _getDateTitle(DateTime date) {
    return '${date.day}.${date.month}.';
  }

  String _getWeekDay(DateTime date) {
    return DateFormat.E(Platform.localeName).format(date);
  }

  Color _getTileColor(GlobalTheme theme, ProgressTileState state) {
    switch (state) {
      case ProgressTileState.filled:
        return theme.green1!;
      case ProgressTileState.partiallyFilled:
        return const Color(0xFFf29100);
      case ProgressTileState.empty:
        return const Color(0xFFe63329);
    }
  }

  ProgressTileState _createProgressTileState() {
    if ((dailyInput.daily != null && !dailyInput.daily!.hasNullValues) &&
            !dailyInput.weeklyDay ||
        (dailyInput.weekly != null && !dailyInput.weekly!.hasNullValues) &&
            !dailyInput.phq4Day ||
        (dailyInput.phq4 != null && !dailyInput.phq4!.hasNullValues)) {
      return ProgressTileState.filled;
    }

    if ((dailyInput.daily != null && dailyInput.daily!.hasAnyValue) ||
        (dailyInput.weeklyDay &&
            dailyInput.weekly != null &&
            dailyInput.weekly!.hasAnyValue) ||
        (dailyInput.phq4Day &&
            dailyInput.phq4 != null &&
            dailyInput.phq4!.hasAnyValue)) {
      return ProgressTileState.partiallyFilled;
    }

    return ProgressTileState.empty;
  }

  @override
  Widget build(BuildContext context) {
    final ProgressTileState state = _createProgressTileState();
    final DateTime date =
        DateTime.now().subtract(Duration(days: dailyInput.day));
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    final double size = ProgressTileState.filled == state ? 80 : 50;
    String title;

    switch (dailyInput.day) {
      case 0:
        title = AppLocalizations.of(context)!.today;
        break;
      case 1:
        title = AppLocalizations.of(context)!.yesterday;
        break;
      case 2:
        if (Platform.localeName == 'de_DE' ||
            Platform.localeName == 'de-DE' ||
            Platform.localeName == 'de') {
          title = 'Vorgestern';
          break;
        }
        title = _getDateTitle(date);
        break;
      default:
        title = _getDateTitle(date);
    }

    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 95,
            child: SizedBox(
              height: size,
              width: size + 20,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/questionnaire-screen/questionnaire-screen',
                    arguments: dailyInput,
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: _getTileColor(theme, state),
                  foregroundColor: theme.white,
                ),
                child: Text(
                  _getWeekDay(date),
                  style: const TextStyle(fontSize: 25),
                  overflow: TextOverflow.visible,
                  softWrap: false,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: TextStyle(
              color: theme.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

/// An comparable state for the [ProgressTile].
enum ProgressTileState {
  /// If [DailyInput] has no values.
  empty,

  /// If [DailyInput] has at least one partially filled value.
  partiallyFilled,

  /// If all [DailyInput] values has been filled.
  filled,
}
