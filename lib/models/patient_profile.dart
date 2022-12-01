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

/// Class with patient profile information.
class PatientProfile extends AbstractDatabaseObject {
  /// Creates a patient profile object.
  const PatientProfile({
    required this.weightBMIEnabled,
    required this.heartFrequencyEnabled,
    required this.bloodPressureEnabled,
    required this.bloodSugarLevelsEnabled,
    required this.walkDistanceEnabled,
    required this.sleepDurationEnabled,
    required this.sleepQualityEnabled,
    required this.painEnabled,
    required this.phq4Enabled,
    required this.medicationEnabled,
    required this.therapyEnabled,
    required this.doctorsVisitEnabled,
    required this.patientObjectId,
    required this.doctorObjectId,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = 'PICOS_Q_profile';

  /// Contains patient's weight.
  final bool weightBMIEnabled;

  /// Contains patient's heart frequency.
  final bool heartFrequencyEnabled;

  /// Contains patient's blood pressure.
  final bool bloodPressureEnabled;

  /// Contains patient's blood sugar level.
  final bool bloodSugarLevelsEnabled;

  /// Contains patient's walk distance.
  final bool walkDistanceEnabled;

  /// Contains patient's sleep duration.
  final bool sleepDurationEnabled;

  /// Contains patient's sleep quality.
  final bool sleepQualityEnabled;

  /// Contains patient's pain.
  final bool painEnabled;

  /// Contains patient's PHQ-4.
  final bool phq4Enabled;

  /// Contains patient's medication.
  final bool medicationEnabled;

  /// Contains patient's therapy.
  final bool therapyEnabled;

  /// Contains patient's doctor's visit.
  final bool doctorsVisitEnabled;

  /// Contains patient's object id.
  final String patientObjectId;

  /// Contains doctor's object id.
  final String doctorObjectId;

  @override
  get table {
    return databaseTable;
  }

  /// Returns a copy of this patient profile with the given values updated.
  @override
  PatientProfile copyWith({
    bool? weightBMIEnabled,
    bool? heartFrequencyEnabled,
    bool? bloodPressureEnabled,
    bool? bloodSugarLevelsEnabled,
    bool? walkDistanceEnabled,
    bool? sleepDurationEnabled,
    bool? sleepQualityEnabled,
    bool? painEnabled,
    bool? phq4Enabled,
    bool? medicationEnabled,
    bool? therapyEnabled,
    bool? doctorsVisitEnabled,
    String? patientObjectId,
    String? doctorObjectId,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PatientProfile(
      weightBMIEnabled: weightBMIEnabled ?? this.weightBMIEnabled,
      heartFrequencyEnabled:
          heartFrequencyEnabled ?? this.heartFrequencyEnabled,
      bloodPressureEnabled: bloodPressureEnabled ?? this.bloodPressureEnabled,
      bloodSugarLevelsEnabled:
          bloodSugarLevelsEnabled ?? this.bloodSugarLevelsEnabled,
      walkDistanceEnabled: walkDistanceEnabled ?? this.walkDistanceEnabled,
      sleepDurationEnabled: sleepDurationEnabled ?? this.sleepDurationEnabled,
      sleepQualityEnabled: sleepQualityEnabled ?? this.sleepQualityEnabled,
      painEnabled: painEnabled ?? this.painEnabled,
      phq4Enabled: phq4Enabled ?? this.phq4Enabled,
      medicationEnabled: medicationEnabled ?? this.medicationEnabled,
      therapyEnabled: therapyEnabled ?? this.therapyEnabled,
      doctorsVisitEnabled: doctorsVisitEnabled ?? this.doctorsVisitEnabled,
      patientObjectId: patientObjectId ?? this.patientObjectId,
      doctorObjectId: doctorObjectId ?? this.doctorObjectId,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[
    weightBMIEnabled,
    heartFrequencyEnabled,
    bloodPressureEnabled,
    bloodSugarLevelsEnabled,
    walkDistanceEnabled,
    sleepDurationEnabled,
    sleepQualityEnabled,
    painEnabled,
    phq4Enabled,
    medicationEnabled,
    therapyEnabled,
    doctorsVisitEnabled,
  ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
    'Weight_BMI': weightBMIEnabled,
    'HeartRate': heartFrequencyEnabled,
    'BloodPressure': bloodPressureEnabled,
    'BloodSugar': bloodSugarLevelsEnabled,
    'WalkingDistance': walkDistanceEnabled,
    'SleepDuration': sleepDurationEnabled,
    'SISQS': sleepQualityEnabled,
    'Pain': painEnabled,
    'PHQ4': phq4Enabled,
    'Medication': medicationEnabled,
    'Therapies': therapyEnabled,
    'Stays': doctorsVisitEnabled,
    'Patient': <String, String>{
      'objectId': patientObjectId,
      '__type': 'Pointer',
      'className': '_User'
    },
    'Doctor': <String, String>{
      'objectId': doctorObjectId,
      '__type': 'Pointer',
      'className': '_User'
    },
  };
}
