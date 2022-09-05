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

import 'package:equatable/equatable.dart';

/// Class with database object information.
class GeneralDatabaseObject extends Equatable {
  /// Creates a object that is represented in the database.
  const GeneralDatabaseObject({
    this.objectId,
    this.createdAt,
    this.updatedAt,
  });

  /// The object ID in the database.
  final String? objectId;
  /// The time the object was created at.
  final DateTime? createdAt;
  /// The time the object was last time updated at.
  final DateTime? updatedAt;

  /// Returns a copy of this medication with the given values updated.
  GeneralDatabaseObject copyWith({
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GeneralDatabaseObject(
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[];
}
