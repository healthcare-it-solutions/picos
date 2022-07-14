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

/// Widget which is used for displaying
/// the progress bar in the corresponding section on the "overview"-screen
class ProgressSection extends StatelessWidget {
  /// ProgressSection constructor
  const ProgressSection({Key? key}) : super(key: key);

  /// Declaration of the value (percentage) which is shown on the progress bar
  final double progressPercentage = 0.95;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.achievedValues,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              ConstrainedBox(
                constraints:
                    const BoxConstraints(minHeight: 20, maxHeight: 100),
              ),
              ElevatedButton(
                child: Text(AppLocalizations.of(context)!.proceed),
                onPressed: () {
                  return;
                },
              )
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              const SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  color: Colors.green,
                  value: 0.96,
                ),
              ),
              Text(
                '${(progressPercentage * 100).round()} %',
                style: const TextStyle(color: Colors.white),
                textScaleFactor: 2,
              )
            ],
          ),
        ],
      ),
    );
  }
}
