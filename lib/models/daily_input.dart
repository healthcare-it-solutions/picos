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
import 'package:picos/models/patient_profile.dart';
import 'package:picos/models/phq4.dart';
import 'package:picos/models/weekly.dart';

import 'daily.dart';

/// Class with daily inputs. A [DailyInput] represents one tile within the
/// progress section in [Overview].
class DailyInput extends AbstractDatabaseObject {
  /// Creates a Daily object.
  const DailyInput({
    required this.day,
    this.daily,
    this.weekly,
    this.phq4,
    bool weeklyDay = false,
    bool phq4Day = false,
    this.hasDemoPurposes = false,
    this.patientProfile,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : weeklyDay = hasDemoPurposes || weeklyDay,
        phq4Day = hasDemoPurposes || phq4Day;

  /// The database table the objects are stored in.
  static const String databaseTable = '';

  /// The day in the past counted down from today.
  final int day;

  /// [Daily]
  final Daily? daily;

  /// [Weekly]
  final Weekly? weekly;

  /// [PHQ4]
  final PHQ4? phq4;

  /// Tells if a new [Weekly] has to be created.
  final bool weeklyDay;

  /// Tells if a new [PHQ4] has to be created.
  final bool phq4Day;

  /// Tells if the [DailyInput] has demo purposes.
  final bool hasDemoPurposes;

  /// Contains the data for PatientProfile.
  final PatientProfile? patientProfile;

  @override
  get table {
    return databaseTable;
  }

  @override
  DailyInput copyWith({
    int? day,
    Daily? daily,
    Weekly? weekly,
    PHQ4? phq4,
    bool? weeklyDay,
    bool? phq4Day,
    PatientProfile? patientProfile,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DailyInput(
      day: day ?? this.day,
      daily: daily ?? this.daily,
      weekly: weekly ?? this.weekly,
      phq4: phq4 ?? this.phq4,
      weeklyDay: weeklyDay ?? this.weeklyDay,
      phq4Day: phq4Day ?? this.phq4Day,
      patientProfile: patientProfile ?? this.patientProfile,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{};
}
