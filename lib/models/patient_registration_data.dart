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

/// Class with patient information collected on registration.
///
/// The attributes within this model may be not complete.
class PatientRegistrationData extends AbstractDatabaseObject {
  /// Creates a patient registration data object.
  const PatientRegistrationData({
    required this.bodyHeight,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = 'patientData';

  /// The patients body height.
  final int bodyHeight;

  @override
  get table {
    return databaseTable;
  }

  /// Returns a copy of this patient registration data object
  /// with the given values updated.
  @override
  PatientRegistrationData copyWith({
    int? bodyHeight,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PatientRegistrationData(
      bodyHeight: bodyHeight ?? this.bodyHeight,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[
    bodyHeight,
  ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
    'BodyHeight': bodyHeight,
  };
}
