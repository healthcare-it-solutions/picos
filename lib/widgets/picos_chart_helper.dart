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

/// Helper class for common chart properties and methods.
class PicosChartHelper {
  ///
  static const double width = 1.0;

  ///
  static const Color colorBlack = Colors.black;

  /// Compare if two given [DateTime] objects fall on the same day.
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Returns the last seven days of the week.
  static Map<String, DateTime> getLastSevenDaysWithDates() {
    int today = DateTime.now().weekday - 1;
    List<String> weekDays = <String>['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];

    Map<String, DateTime> weekDaysWithDates = <String, DateTime>{};

    for (int i = 6; i >= 0; i--) {
      int dayIndex = (today - i + 7) % 7;
      DateTime dateForDay = DateTime.now().subtract(Duration(days: i));

      weekDaysWithDates[weekDays[dayIndex]] = dateForDay;
    }

    return weekDaysWithDates;
  }

  /// Returns the dates for the last seven weeks starting from today.
  static Map<String, DateTime> getLastSevenWeeksFromToday() {
    DateTime today = DateTime.now();
    int currentWeek = ((dayOfYear(today) - today.weekday + 10) / 7).floor();

    Map<String, DateTime> weeksFromToday = <String, DateTime>{};

    for (int i = 6; i >= 0; i--) {
      int weekNumber = currentWeek - i;
      weeksFromToday['KW$weekNumber'] = today.subtract(Duration(days: 7 * i));
    }

    return weeksFromToday;
  }

  /// Returns the day of the year for the given [date].
  static int dayOfYear(DateTime date) {
    return date.difference(DateTime(date.year, 1, 1)).inDays + 1;
  }

  /// Checks if a given date, [dateToCheck], falls within the same week as
  /// another reference date, [referenceDate].
  static bool isWithinWeek(DateTime dateToCheck, DateTime referenceDate) {
    DateTime startOfWeek = referenceDate
        .subtract(Duration(days: referenceDate.weekday - 1))
        .subtract(
          Duration(
            hours: referenceDate.hour,
            minutes: referenceDate.minute,
            seconds: referenceDate.second,
            milliseconds: referenceDate.millisecond,
          ),
        );
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6)).add(
          const Duration(
            hours: 23,
            minutes: 59,
            seconds: 59,
            milliseconds: 999,
          ),
        );

    return dateToCheck.isAtSameMomentAs(startOfWeek) ||
        dateToCheck.isAfter(startOfWeek) &&
            (dateToCheck.isAtSameMomentAs(endOfWeek) ||
                dateToCheck.isBefore(endOfWeek));
  }
}
