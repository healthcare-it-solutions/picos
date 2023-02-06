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

/// Class with weekly questionaire information.
class Weekly extends AbstractDatabaseObject {
  /// Creates a Daily object.
  const Weekly({
    required this.date,
    this.bodyWeight,
    this.bmi,
    this.sleepQuality,
    this.walkingDistance,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = 'PICOS_weekly';

  /// The patients body weight.
  final double? bodyWeight;

  /// The patients BMI.
  final double? bmi;

  /// The patients sleep quality assessment.
  final int? sleepQuality;

  /// The patients walking distance.
  final int? walkingDistance;

  /// The assessment date.
  final DateTime date;

  @override
  get table {
    return databaseTable;
  }

  @override
  Weekly copyWith({
    DateTime? date,
    double? bodyWeight,
    double? bmi,
    int? sleepQuality,
    int? walkingDistance,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Weekly(
      date: date ?? this.date,
      bodyWeight: bodyWeight ?? this.bodyWeight,
      bmi: bmi ?? this.bmi,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      walkingDistance: walkingDistance ?? this.walkingDistance,
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
    'BodyWeight': bodyWeight,
    'BMI': bmi,
    'SISQS': sleepQuality,
    'WalkingDistance': walkingDistance,
    'datetime': date,
  };
}
