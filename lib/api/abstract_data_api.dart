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

import '../models/abstract_database_object.dart';

/// Combines database operations and memory management functionalities.
/// This abstract class serves as a foundation for APIs that require both
/// persistent data handling and temporary state management.
abstract class AbstractDataApi extends DatabaseOperations
    with MemoryManagement {
  /// Constructor for AbstractDataApi.
  AbstractDataApi();
}

/// Provides an abstract base for operations on database objects.
/// It defines methods for managing the lifecycle
/// of data entities in a database.
abstract class DatabaseOperations {
  /// Retrieves all objects from the database. This method must handle
  /// any necessary transformations from the database format to the
  /// application-specific model format.
  Future<List<AbstractDatabaseObject>> getObjects();

  /// Saves a given object to the database. Updates the object if it
  /// already exists.
  Future<void> saveObject(AbstractDatabaseObject object);

  /// Removes a specified object from the database, aiding in data management
  /// and lifecycle operations.
  Future<void> removeObject(AbstractDatabaseObject object);
}

/// Provides an abstract base for memory management of data objects.
/// It includes methods for clearing and querying
/// the state of objects in memory.
abstract class MemoryManagement {
  /// Clears all objects currently held in memory. Useful for releasing memory
  /// and resetting state without affecting persistent data.
  void clearObjects();

  /// Returns a boolean indicating whether there are any objects currently
  /// held in memory. This can help avoid unnecessary data fetching.
  bool? hasObjects;
}
