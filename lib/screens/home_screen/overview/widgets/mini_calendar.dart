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
import 'package:intl/intl.dart';

// TODO: add some configuration, maybe even hard coded
// TODO: make widget follow global theme setting
// TODO: document
// TODO: make it less ugly

/// Widget which displays a calendar on the "overview"-screen
class MiniCalendar extends StatelessWidget {
  /// MiniCalendar constructor
  MiniCalendar({Key? key}) : super(key: key);

  final DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          constraints: const BoxConstraints.expand(
            width: 100,
            height: 30,
          ),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(
              25,
              102,
              117,
              1.0,
            ),
            border: Border.all(color: const Color.fromARGB(255, 25, 120, 136)),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            
          ),
          child: Center(
            child: Text(
              DateFormat.E(
                Localizations.localeOf(context).toString(),
              ).format(_dateTime),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          width: 100,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            border: Border.all(color: const Color.fromARGB(255, 25, 120, 136)),
          ),
          child: Center(
            child: Text(
              _dateTime.day.toString(),
              textScaleFactor: 4,
            ),
          ),
        ),
      ],
    );
  }
}
