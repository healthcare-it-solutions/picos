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
import 'package:picos/models/patient.dart';
import 'package:picos/models/patient_data.dart';
import 'package:picos/models/patient_profile.dart';

/// Class with patient list information.
class PatientsListElement extends AbstractDatabaseObject {
  /// Creates a patient list object.
  const PatientsListElement({
    required this.patient,
    required this.patientData,
    required this.patientProfile,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = '';

  /// Stores patient object;
  final Patient patient;

  /// Stores patient datat object.
  final PatientData patientData;

  /// Stores patient profile object.
  final PatientProfile patientProfile;

  @override
  PatientsListElement copyWith({
    Patient? patient,
    PatientData? patientData,
    PatientProfile? patientProfile,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PatientsListElement(
      patient: patient ?? this.patient,
      patientData: patientData ?? this.patientData,
      patientProfile: patientProfile ?? this.patientProfile,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{};

  @override
  List<Object> get props => <Object>[patient, patientData, patientProfile];

  @override
  String get table => databaseTable;
}
