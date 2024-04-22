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

import 'package:rxdart/rxdart.dart';

import '../models/abstract_database_object.dart';
import '../util/backend.dart';
import 'abstract_data_api.dart';

/// API for storing objects at the backend.
abstract class BackendObjectsApi extends AbstractDataApi {
  /// Contains all objects that are controlled by [_objectController].
  List<AbstractDatabaseObject> objectList = <AbstractDatabaseObject>[];

  /// The acl used, when creating a new object.
  BackendACL? acl;

  /// Controls the database objects.
  final BehaviorSubject<List<AbstractDatabaseObject>> _objectController =
      BehaviorSubject<List<AbstractDatabaseObject>>();

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

      updateObjectList(object);
      dispatch();
    } catch (e) {
      return Future<void>.error(e);
    }
  }

  @override
  Future<void> removeObject(AbstractDatabaseObject object) async {
    try {
      await Backend.removeObject(object);
      objectList.removeWhere(
        (AbstractDatabaseObject elem) => elem.objectId == object.objectId,
      );
      dispatch();
    } catch (e) {
      return Future<void>.error(e);
    }
  }

  @override
  bool get hasObjects => objectList.isNotEmpty;

  @override
  void clearObjects() {
    objectList.clear();
  }

  /// Notifies all subscribers with the latest list of objects.
  void dispatch() {
    _objectController.sink
        .add(List<AbstractDatabaseObject>.unmodifiable(objectList));
  }

  /// Updates the [objectList].
  void updateObjectList(AbstractDatabaseObject object) {
    int index = objectList.indexWhere(
      (AbstractDatabaseObject elem) => elem.objectId == object.objectId,
    );
    if (index >= 0) {
      objectList[index] = object;
    } else {
      objectList.add(object);
    }
  }
}
