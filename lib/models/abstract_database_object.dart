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
/// Every model, that represents data at the database should extend this class!
abstract class AbstractDatabaseObject extends Equatable {
  /// Creates a object that is represented in the database.
  const AbstractDatabaseObject({
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

  /// The database table the objects are stored in.
  String get table;

  /// Returns a copy of this object with the given values updated.
  AbstractDatabaseObject copyWith({
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  @override
  List<Object> get props;

  /// Maps the attributes of a model to it's database fields.
  /// [String] is the field name inside the table.
  /// [dynamic] is the attribute of the model.
  Map<String, dynamic> get databaseMapping;
}
