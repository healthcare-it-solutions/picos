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
import 'package:picos/screens/overview_screen/widgets/mini_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/screens/questionaire_screen/questionaire_screen.dart';

/// This class implements the top section of the 'overview'.
class InputCardSection extends StatelessWidget {
  /// InputCardSection constructor
  const InputCardSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      //heightFactor: 1,
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.myEntries,
                  ),
                ],
              ),
              const Divider(
                height: 1,
                color: Colors.black,
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
              IntrinsicWidth(
                stepWidth: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext context) =>
                            const QuestionaireScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.startEntry,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
