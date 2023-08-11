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
  Daily({
    required this.date,
    this.heartFrequency,
    this.bloodSugar,
    this.bloodSystolic,
    this.bloodDiastolic,
    this.sleepDuration,
    this.pain,
    this.bloodSugarMol,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt) {
    hasNullValues = _checkHasNullValues();
    hasAnyValue = _checkHasAnyValue();
  }

  /// The database table the objects are stored in.
  static const String databaseTable = 'PICOS_daily';

  /// The patients heart frequency.
  final int? heartFrequency;

  /// The patients blood sugar value.
  final int? bloodSugar;

  /// The patients blood sugar value (mmol/l).
  final double? bloodSugarMol;

  /// The patients blood pressure systolic value.
  final int? bloodSystolic;

  /// The patients blood pressure diastolic value.
  final int? bloodDiastolic;

  /// The patients sleep duration.
  final double? sleepDuration;

  /// The patients pain assessment.
  final int? pain;

  /// The assessment date.
  final DateTime date;

  /// The information if this objects has any null values.
  late final bool hasNullValues;

  /// The information if this objects has any non-null value.
  late final bool hasAnyValue;

  @override
  get table {
    return databaseTable;
  }

  @override
  Daily copyWith({
    DateTime? date,
    int? heartFrequency,
    int? bloodSugar,
    int? bloodSystolic,
    int? bloodDiastolic,
    double? sleepDuration,
    int? pain,
    double? bloodSugarMol,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Daily(
      bloodSugarMol: bloodSugarMol ?? this.bloodSugarMol,
      date: date ?? this.date,
      heartFrequency: heartFrequency ?? this.heartFrequency,
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
        date,
      ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        'HeartRate': heartFrequency,
        'BloodSugar': bloodSugar,
        'BloodPSystolic': bloodSystolic,
        'BloodPDiastolic': bloodDiastolic,
        'SleepDuration': sleepDuration,
        'Pain': pain,
        'datetime': date,
        'BloodSugarMol': bloodSugarMol,
      };

  bool _checkHasNullValues() {
    if (bloodDiastolic == null ||
        bloodSugar == null ||
        bloodSystolic == null ||
        heartFrequency == null ||
        pain == null ||
        sleepDuration == null ||
        bloodSugarMol == null) {
      return true;
    }

    return false;
  }

  bool _checkHasAnyValue() {
    if (bloodDiastolic != null ||
        bloodSugar != null ||
        bloodSystolic != null ||
        heartFrequency != null ||
        pain != null ||
        sleepDuration != null ||
        bloodSugarMol != null) {
      return true;
    }

    return false;
  }
}
