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

import '../models/abstract_database_object.dart';
import '../util/backend.dart';
import 'database_object_api.dart';

/// API for storing objects at the backend.
abstract class BackendObjectsApi extends DatabaseObjectApi {
  /// Contains all objects that are controlled by [_objectController].
  List<AbstractDatabaseObject> objectList = <AbstractDatabaseObject>[];

  /// The acl used, when creating a new object.
  BackendACL? acl;

  /// Controls the database objects.
  final StreamController<List<AbstractDatabaseObject>> _objectController =
      StreamController<List<AbstractDatabaseObject>>();

  @override
  Future<void> saveObject(AbstractDatabaseObject object) async {
    try {
      dynamic response = await Backend.saveObject(object, acl: acl);

      object = object.copyWith(
        objectId: response['objectId'],
        createdAt:
            DateTime.tryParse(response['createdAt'] ?? '') ?? object.createdAt,
        updatedAt:
            DateTime.tryParse(response['updatedAt'] ?? '') ?? object.updatedAt,
      );

      int objectIndex = getIndex(object);

      if (objectIndex >= 0) {
        objectList[objectIndex] = object;
        objectList = <AbstractDatabaseObject>[...objectList];
      }

      if (objectIndex < 0) {
        objectList = <AbstractDatabaseObject>[...objectList, object];
      }

      dispatch();
    } catch (e) {
      return;
    }
  }

  @override
  Future<void> removeObject(AbstractDatabaseObject object) async {
    try {
      await Backend.removeObject(object);

      int objectIndex = getIndex(object);

      objectList.removeAt(objectIndex);
      objectList = <AbstractDatabaseObject>[...objectList];

      dispatch();
    } catch (e) {
      return;
    }
  }

  /// Returns the [objectList] as a stream for the application to use.
  Stream<List<AbstractDatabaseObject>> getObjectsStream() {
    return _objectController.stream.asBroadcastStream(
      onListen:
          (StreamSubscription<List<AbstractDatabaseObject>> subscription) {
        dispatch();
      },
    );
  }

  /// Updates the objects.
  void dispatch() {
    _objectController.sink.add(objectList);
  }

  /// Returns the index of the object. 
  int getIndex(AbstractDatabaseObject object) {
    return objectList.indexWhere(
      (AbstractDatabaseObject element) => element.objectId == object.objectId,
    );
  }
}
