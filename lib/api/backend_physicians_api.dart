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

import 'package:picos/models/physician.dart';

import '../models/abstract_database_object.dart';
import '../util/backend.dart';
import 'backend_objects_api.dart';

/// API for storing physicians at the backend.
class BackendPhysiciansApi extends BackendObjectsApi {
  @override
  Future<Stream<List<AbstractDatabaseObject>>> getObjects() async {
    try {
      List<dynamic> response = await Backend.getAll(Physician.databaseTable);

      for (dynamic element in response) {
        objectList.add(
          Physician(
            subjectArea: element['SubjectArea'],
            practice: element['Name'],
            lastName: element['Lastname'],
            mail: element['Mail'],
            phone: element['Tele'],
            address: element['Address'],
            city:  element['City'],
            homepage:  element['Homepage'],
            firstName: element['Firstname'],
            objectId: element['objectId'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
          ),
        );
      }

      return getObjectsStream();
    } catch (e) {
      return Stream<List<Physician>>.error(e);
    }
  }
}
