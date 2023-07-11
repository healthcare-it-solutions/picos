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

/// Class with Respiratory Parameters object.
class RespiratoryParameters extends AbstractDatabaseObject {
  /// Creates a Respiratory Parameters object.
  const RespiratoryParameters({
    required this.doctorObjectId,
    required this.value1,
    required this.value2,
    required this.patientObjectId,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = 'RespiratoryParas';

  /// Doctor Object Id.
  final String doctorObjectId;

  /// Last value.
  final String value1;

  /// Pre-last value.
  final String value2;

  /// Patient Object Id.
  final String patientObjectId;

  @override
  get table {
    return databaseTable;
  }

  @override
  RespiratoryParameters copyWith({
    String? doctorObjectId,
    String? value1,
    String? value2,
    String? patientObjectId,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RespiratoryParameters(
      doctorObjectId: doctorObjectId ?? this.doctorObjectId,
      value1: value1 ?? this.value1,
      value2: value2 ?? this.value2,
      patientObjectId: patientObjectId ?? this.patientObjectId,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[
        doctorObjectId,
        value1,
        value2,
        patientObjectId,
      ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        'Doctor': <String, String>{
          'objectId': doctorObjectId,
          '__type': 'Pointer',
          'className': '_User'
        },
        'value1': <String, String>{
          'objectId': value1,
          '__type': 'Pointer',
          'className': 'RespiratoryParas_obj'
        },
        'value2': <String, String>{
          'objectId': value2,
          '__type': 'Pointer',
          'className': 'RespiratoryParas_obj'
        },
        'Patient': <String, String>{
          'objectId': patientObjectId,
          '__type': 'Pointer',
          'className': '_User'
        },
      };
}
