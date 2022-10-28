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

import 'package:picos/models/abstract_database_object.dart';

/// Class with daily questionaire information.
class Daily extends AbstractDatabaseObject {
  /// Creates a Daily object.
  const Daily({
    required this.date,
    required this.heartRate,
    required this.bloodSugar,
    required this.bloodSystolic,
    required this.bloodDiastolic,
    required this.sleepDuration,
    required this.pain,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = 'PICOS_daily';

  /// The patients heart rate.
  final int heartRate;

  /// The patients blood sugar value.
  final int bloodSugar;

  /// The patients blood pressure systolic value.
  final int bloodSystolic;

  /// The patients blood pressure diastolic value.
  final int bloodDiastolic;

  /// The patients sleep duration.
  final int sleepDuration;

  /// The patients pain assessment.
  final int pain;

  /// The assessment date.
  final DateTime date;

  @override
  get table {
    return databaseTable;
  }

  @override
  Daily copyWith({
    DateTime? date,
    int? heartRate,
    int? bloodSugar,
    int? bloodSystolic,
    int? bloodDiastolic,
    int? sleepDuration,
    int? pain,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Daily(
      date: date ?? this.date,
      heartRate: heartRate ?? this.heartRate,
      bloodSugar: bloodSugar ?? this.bloodSugar,
      bloodSystolic: bloodSystolic ?? this.bloodSystolic,
      bloodDiastolic: bloodDiastolic ?? this.bloodDiastolic,
      sleepDuration: sleepDuration ?? this.sleepDuration,
      pain: pain ?? this.pain,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[
        heartRate,
        bloodSugar,
        bloodSystolic,
        bloodDiastolic,
        sleepDuration,
        pain,
        date,
      ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        'HeartRate': heartRate,
        'BloodSugar': bloodSugar,
        'BloodPSystolic': bloodSystolic,
        'BloodPDiastolic': bloodDiastolic,
        'SleepDuration': sleepDuration,
        'Pain': pain,
        'datetime': date,
      };
}
