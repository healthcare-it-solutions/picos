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

/// Provides an interface for an API that handles database objects.
/// This includes methods for fetching, saving, and removing
/// objects from a persistent store.
abstract class DatabaseObjectApi {
  /// DatabaseObjectApi constructor.
  DatabaseObjectApi();

  /// Retrieves a list of all objects. This method should handle any necessary
  /// conversions from the database format to the model format.
  Future<List<AbstractDatabaseObject>> getObjects();

  /// Saves a given object to the database. If the object already exists,
  /// it should be updated.
  Future<void> saveObject(AbstractDatabaseObject object);

  /// Removes a given object from the database.
  Future<void> removeObject(AbstractDatabaseObject object);

  /// Clears all cached objects in memory. Does not affect objects stored
  /// in the database. Use this method to release memory or reset state
  /// within the API without impacting stored data.
  void clearObjects();

  /// Indicates whether there are any objects currently held in memory.
  /// It may be used to check if objects need to be fetched before
  /// performing certain operations.
  bool? hasObjects;
}
