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

/// Class with follow up investigation.
class FollowUp extends AbstractDatabaseObject {
  /// Creates a follow up data object.
  const FollowUp({
    required this.patientObjectId,
    required this.doctorObjectId,
    this.distance,
    this.bloodDiastolic,
    this.bloodSystolic,
    this.rhythm,
    this.rhythmTyp,
    this.testResult,
    this.healthState,
    this.locationType,
    this.heartRate,
    this.healthScore,
    this.number,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// denotes the distance.
  final int? distance;

  /// denotes the bloodDiastolic.
  final int? bloodDiastolic;

  /// denotes the bloodSystolic.
  final int? bloodSystolic;

  /// denotes the rythmus.
  final String? rhythm;

 /// denotes the rythmusTyp.
  final String? rhythmTyp;

  /// denotes the testResult.
  final int? testResult;

  /// denotes the healthState.
  final List<dynamic>? healthState;

  /// denotes the locationType.
  final String? locationType;

  /// denotes the heartRate.
  final int? heartRate;

  /// denotes the healthScore.
  final int? healthScore;

  /// denotes the number.
  final int? number;

  /// denotes the doctor's object ID.
  final String doctorObjectId;

  /// denotes the patient's object ID.
  final String patientObjectId;

  /// The database table the objects are stored in.
  static const String databaseTable = 'followUP';

  @override
  get table {
    return databaseTable;
  }

  /// Returns a copy of this follow up with the given values updated.
  @override
  FollowUp copyWith({
    int? distance,
    int? bloodDiastolic,
    int? bloodSystolic,
    String? rythmus,
    String? rythmusTyp,
    int? testResult,
    List<dynamic>? healthState,
    String? locationType,
    int? heartRate,
    int? healthScore,
    int? number,
    String? patientObjectId,
    String? doctorObjectId,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FollowUp(
      distance: distance ?? this.distance,
      bloodDiastolic: bloodDiastolic ?? this.bloodDiastolic,
      bloodSystolic: bloodSystolic ?? this.bloodSystolic,
      rhythm: rythmus ?? this.rhythm,
      rhythmTyp: rythmusTyp ?? this.rhythmTyp,
      testResult: testResult ?? this.testResult,
      healthState: healthState ?? this.healthState,
      locationType: locationType ?? this.locationType,
      heartRate: heartRate ?? this.heartRate,
      healthScore: healthScore ?? this.healthScore,
      number: number ?? this.number,
      patientObjectId: patientObjectId ?? this.patientObjectId,
      doctorObjectId: doctorObjectId ?? this.doctorObjectId,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[
        patientObjectId,
        doctorObjectId,
      ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        if (distance != null) 'Strecke': distance,
        if (bloodDiastolic != null) 'BD_Diastolisch': bloodDiastolic,
        if (bloodSystolic != null) 'BD_Systolisch': bloodSystolic,
        if (rhythm != null) 'Rythmus': rhythm,
        if (rhythmTyp != null) 'RythmusTyp': rhythmTyp,
        if (testResult != null) 'Testergebnis': testResult,
        if (healthState != null) 'HealthState': healthState,
        if (locationType != null) 'Lagetyp': locationType,
        if (heartRate != null) 'Herzfrequenz': heartRate,
        if (healthScore != null) 'Gesundheitsscore': healthScore,
        if (number != null) 'number': number,
        'Patient': <String, String>{
          'objectId': patientObjectId,
          '__type': 'Pointer',
          'className': '_User',
        },
        'Doctor': <String, String>{
          'objectId': doctorObjectId,
          '__type': 'Pointer',
          'className': '_User',
        },
      };
}
