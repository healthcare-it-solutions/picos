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
import 'package:picos/util/backend.dart';

/// Class with documents.
class Document extends AbstractDatabaseObject {
  /// Creates document object.
  const Document({
    required this.filename,
    required this.important,
    required this.document,
    required this.date,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = 'PICOS_dokument';

  /// The file name date.
  final String filename;

  /// The importance of the file.
  final bool important;

  /// The document object.
  final BackendFile document;

  /// The document date.
  final DateTime date;

  @override
  get table {
    return databaseTable;
  }

  @override
  Document copyWith({
    String? filename,
    bool? important,
    BackendFile? document,
    DateTime? date,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Document(
      filename: filename ?? this.filename,
      important: important ?? this.important,
      document: document ?? this.document,
      date: date ?? this.date,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[
        filename,
        important,
        document,
        date,
      ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        'filename': filename,
        'prio': important,
        'document': document.file,
        'date': date,
      };
}
