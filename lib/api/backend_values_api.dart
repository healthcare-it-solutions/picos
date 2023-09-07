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

import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:picos/models/values.dart';

import '../models/daily.dart';
import '../models/weekly.dart';

/// API for storing values at the backend.
class BackendValuesApi {
  /// Ret
  static Future<Values?> getMyValues() async {
    try {
      DateTime now = DateTime.now();

      //Weekly.
      DateTime last7Weeks = now.subtract(const Duration(days: 49));

      QueryBuilder<ParseObject> weeklyQueryBuilder =
          QueryBuilder<ParseObject>(ParseObject(Weekly.databaseTable));
      weeklyQueryBuilder.whereGreaterThanOrEqualsTo('datetime', last7Weeks);
      ParseResponse responseLast7Weeks = await weeklyQueryBuilder.query();
      List<Weekly> resultsLast7Weeks = <Weekly>[];
      for (dynamic element in responseLast7Weeks.results!) {
        resultsLast7Weeks.add(
          Weekly(
            date: element['datetime'],
            bmi: element['BMI']?.toDouble(),
            bodyWeight: element['BodyWeight']?.toDouble(),
            sleepQuality: element['SISQS'],
            walkingDistance: element['WalkingDistance'],
            objectId: element['objectId'],
            createdAt: element['createdAt'],
            updatedAt: element['updatedAt'],
          ),
        );
      }

      //Daily.
      DateTime last7Days = now.subtract(const Duration(days: 7));
      QueryBuilder<ParseObject> dailyQueryBuilder =
          QueryBuilder<ParseObject>(ParseObject(Daily.databaseTable));
      dailyQueryBuilder.whereGreaterThanOrEqualsTo('datetime', last7Days);
      dynamic responseLast7Days = await dailyQueryBuilder.query();
      List<Daily> resultsLast7Days = <Daily>[];
      for (dynamic element in responseLast7Days.results!) {
        resultsLast7Days.add(
          Daily(
            date: element['datetime'],
            heartFrequency: element['HeartRate'],
            bloodSugar: element['BloodSugar'],
            bloodSystolic: element['BloodPSystolic'],
            bloodDiastolic: element['BloodPDiastolic'],
            sleepDuration: element['SleepDuration']?.toDouble(),
            pain: element['Pain'],
            bloodSugarMol: element['BloodSugarMol']?.toDouble(),
            objectId: element['objectId'],
            createdAt: element['createdAt'],
            updatedAt: element['updatedAt'],
          ),
        );
      }

      return Values(
        dailyList: resultsLast7Days,
        weeklyList: resultsLast7Weeks,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
