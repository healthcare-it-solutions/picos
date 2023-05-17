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

import 'dart:async';

import 'package:picos/api/backend_objects_api.dart';
import 'package:picos/models/abstract_database_object.dart';
import 'package:picos/models/daily_input.dart';
import 'package:picos/models/phq4.dart';
import 'package:picos/models/weekly.dart';

import '../models/daily.dart';
import '../util/backend.dart';

/// API for calling [DailyInput] at the backend.
class BackendDailyInputsApi extends BackendObjectsApi {
  @override
  Future<Stream<List<AbstractDatabaseObject>>> getObjects() async {
    try {
      Map<String, dynamic> response = (await Backend.callEndpoint(
        'getPatientsDailyInput',
        <String, int>{'days': 14},
      )).first['result'];

      int day = 0;

      response.forEach((String key, dynamic value) {
        Daily? daily;
        Weekly? weekly;
        PHQ4? phq4;

        if (value['daily']['objectId'] != null) {
          daily = Daily(
            date: DateTime.parse(value['daily']['datetime']['iso']),
            heartFrequency: value['daily']['HeartRate'],
            bloodSugar: value['daily']['BloodSugar'],
            bloodSystolic: value['daily']['BloodPSystolic'],
            bloodDiastolic: value['daily']['BloodPDiastolic'],
            sleepDuration: value['daily']['SleepDuration'],
            pain: value['daily']['Pain'],
            objectId: value['daily']['objectId'],
            createdAt: DateTime.parse(value['daily']['createdAt']),
            updatedAt: DateTime.parse(value['daily']['updatedAt']),
          );
        }

        if (value['weekly']['objectId'] != null) {
          weekly = Weekly(
            date: DateTime.parse(value['weekly']['datetime']['iso']),
            bmi: value['weekly']['BMI']?.toDouble(),
            bodyWeight: value['weekly']['BodyWeight']?.toDouble(),
            sleepQuality: value['weekly']['SISQS'],
            walkingDistance: value['weekly']['WalkingDistance'],
            objectId: value['weekly']['objectId'],
            createdAt: DateTime.parse(value['weekly']['createdAt']),
            updatedAt: DateTime.parse(value['weekly']['updatedAt']),
          );
        }

        if (value['phq4']['objectId'] != null) {
          phq4 = PHQ4(
            date: DateTime.parse(value['phq4']['datetime']['iso']),
            a: value['phq4']['a'],
            b: value['phq4']['b'],
            c: value['phq4']['c'],
            d: value['phq4']['d'],
            objectId: value['phq4']['objectId'],
            createdAt: DateTime.parse(value['phq4']['createdAt']),
            updatedAt: DateTime.parse(value['phq4']['updatedAt']),
          );
        }

        objectList.add(
            DailyInput(
              day: day,
              daily: daily,
              weekly: weekly,
              phq4: phq4,
            ),
        );

        day++;
      });

      return getObjectsStream();
    } catch (e) {
      return Stream<List<DailyInput>>.error(e);
    }
  }
}
