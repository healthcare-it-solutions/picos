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
import 'package:picos/models/vital_signs_object.dart';

/// Class with Vital Signs.
class VitalSigns extends AbstractDatabaseObject {
  /// Creates a Vital Signs object.
  VitalSigns({
    required this.doctorObjectId,
    required this.patientObjectId,
    this.value1,
    this.value2,
    this.valueObjectId1,
    this.valueObjectId2,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = 'VitalSigns';

  /// Doctor Object Id.
  final String doctorObjectId;

  /// Last value.
  late VitalSignsObject? value1;

  /// Pre-last value.
  late VitalSignsObject? value2;

  /// Last value objectId.
  final String? valueObjectId1;

  /// Pre-last value objectId.
  final String? valueObjectId2;

  /// Patient Object Id.
  final String patientObjectId;

  @override
  get table {
    return databaseTable;
  }

  @override
  VitalSigns copyWith({
    String? doctorObjectId,
    VitalSignsObject? value1,
    VitalSignsObject? value2,
    String? valueObjectId1,
    String? valueObjectId2,
    String? patientObjectId,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VitalSigns(
      doctorObjectId: doctorObjectId ?? this.doctorObjectId,
      value1: value1 ?? this.value1,
      value2: value2 ?? this.value2,
      valueObjectId1: valueObjectId1 ?? this.valueObjectId1,
      valueObjectId2: valueObjectId2 ?? this.valueObjectId2,
      patientObjectId: patientObjectId ?? this.patientObjectId,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[
        doctorObjectId,
        patientObjectId,
      ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
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
        if (value1 != null && value1?.objectId != null)
          'value1': <String, dynamic>{
            'objectId': value1?.objectId,
            '__type': 'Pointer',
            'className': 'VitalSigns_obj',
          },
        if (value2 != null && value2?.objectId != null)
          'value2': <String, dynamic>{
            'objectId': value2?.objectId,
            '__type': 'Pointer',
            'className': 'VitalSigns_obj',
          },
      };
}
