import 'package:flutter/foundation.dart';

import '../models/daily.dart';
import '../models/daily_input.dart';
import '../models/weekly.dart';
import '../util/backend.dart';

/// API for storing values at the backend.
class BackendValuesApi {
  ///
  static bool checkDay(dynamic value, String key) {
    if (value[key] != null) {
      return true;
    }

    return false;
  }

  /// Ret
  static Future<List<DailyInput>?> getMyValues() async {
    try {
      Map<String, dynamic> response = (await Backend.callEndpoint(
        'getPatientsDailyInput',
        <String, int>{'days': 90},
      ))
          .first['result'];

      List<DailyInput> results = <DailyInput>[];
      int day = 0;

      response.forEach((String key, dynamic value) {
        Daily? daily;
        Weekly? weekly;
        bool weeklyDay = checkDay(value, 'weekly');

        if (value['daily']['objectId'] != null) {
          daily = Daily(
            date: DateTime.parse(value['daily']['datetime']['iso']),
            heartFrequency: value['daily']['HeartRate'],
            bloodSugar: value['daily']['BloodSugar'],
            bloodSystolic: value['daily']['BloodPSystolic'],
            bloodDiastolic: value['daily']['BloodPDiastolic'],
            sleepDuration: value['daily']['SleepDuration']?.toDouble(),
            pain: value['daily']['Pain'],
            bloodSugarMol: value['daily']['BloodSugarMol']?.toDouble(),
            objectId: value['daily']['objectId'],
            createdAt: DateTime.parse(value['daily']['createdAt']),
            updatedAt: DateTime.parse(value['daily']['updatedAt']),
          );
        }

        if (weeklyDay && value['weekly']?['objectId'] != null) {
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

        results.add(
          DailyInput(
            day: day,
            daily: daily,
            weekly: weekly,
            weeklyDay: weeklyDay,
          ),
        );

        day++;
      });
      return results;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
