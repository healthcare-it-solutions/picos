/*   This file is part of Picos, a health trcking mobile app
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
import 'package:intl/intl.dart';

class MiniCalendar extends StatelessWidget {
  MiniCalendar({Key? key}) : super(key: key);

  final DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 30,
          //color: Colors.blue,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)
            )
          ),
          child: Center(
            child: Text(
              DateFormat
                .EEEE(
                  Localizations
                  .localeOf(context)
                  .toString())
                .format(_dateTime)
            )
          )
        ),
        Container(
          width: 100,
          height: 70,
          //color: Colors.white,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
            ),
            border: Border.all()
          ),
          child: Center(
            child: Text(
                _dateTime.day.toString(),
                textScaleFactor: 4,
              )
            )
        ),
      ],
    );
  }
}
