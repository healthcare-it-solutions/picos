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

import 'dart:async';

import 'package:picos/api/backend_objects_api.dart';
import 'package:picos/models/abstract_database_object.dart';
import 'package:picos/models/document.dart';

import '../util/backend.dart';

/// API for storing documents at the backend.
class BackendDocumentsApi extends BackendObjectsApi {
  @override
  Future<void> saveObject(AbstractDatabaseObject object) async {
    await super.saveObject(object);
  }

  @override
  Future<List<AbstractDatabaseObject>> getObjects() async {
    try {
      List<dynamic> response = await Backend.getAll(Document.databaseTable);

      for (dynamic element in response) {
        objectList.add(
          Document(
            filename: element['filename'],
            important: element['prio'],
            document: BackendFile.byUrl(
              element['document']['name'],
              element['document']['url'],
            ),
            date: DateTime.parse(element['date']['iso']),
            objectId: element['objectId'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
          ),
        );
      }
      dispatch();
      return objectList;
    } catch (e) {
      return Future<List<AbstractDatabaseObject>>.error(e);
    }
  }
}
