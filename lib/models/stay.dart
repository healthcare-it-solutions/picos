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

/// Class with hospital visit information.
class Stay extends AbstractDatabaseObject {
  /// Creates a medication object.
  const Stay({
    required this.where,
    required this.record,
    required this.reason,
    this.discharge,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = 'PICOS_stays';

  /// If the patient visited a doctor or a hospital.
  final String where;

  /// The recorded date of the stay.
  final DateTime record;

  /// The discharge date of the patient (if applicable).
  final DateTime? discharge;

  /// The reason for the stay.
  final String reason;

  @override
  get table {
    return databaseTable;
  }

  @override
  Stay copyWith({
    String? where,
    DateTime? record,
    DateTime? discharge,
    String? reason,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Stay(
      where: where ?? this.where,
      record: record ?? this.record,
      discharge: discharge ?? this.discharge,
      reason: reason ?? this.reason,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[
        where,
        record,
        reason,
      ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        'where': where,
        'dateRecord': record,
        'dateDischarge': discharge,
        'reason': reason,
      };
}
