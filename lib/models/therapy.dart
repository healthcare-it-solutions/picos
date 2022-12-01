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

/// Class with therapy information.
class Therapy extends AbstractDatabaseObject {
  /// Creates a medication object.
  const Therapy({
    required this.date,
    required this.therapy,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = 'PICOS_therapies';

  /// The date for the therapy.
  final DateTime date;

  /// The therapy description.
  final String therapy;

  /// Returns the defined [date] as a [String].
  String get dateString {
    return '${date.day}.${date.month}.${date.year}';
  }

  @override
  get table {
    return databaseTable;
  }

  @override
  Therapy copyWith({
    DateTime? date,
    String? therapy,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Therapy(
      date: date ?? this.date,
      therapy: therapy ?? this.therapy,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[
        date,
        therapy,
      ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        'date': date,
        'therapieText': therapy,
      };
}
