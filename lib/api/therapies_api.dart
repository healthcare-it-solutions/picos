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

import '../models/therapy.dart';

/// The interface for an API that provides access to a list of therapies.
abstract class TherapiesApi {
  /// Medications API constructor.
  const TherapiesApi();

  /// Provides a [Stream] of all medications.
  Future<Stream<List<Therapy>>> getTherapies();

  /// Saves or replaces a [therapy].
  Future<void> saveTherapy(Therapy therapy);

  /// Removes the given [therapy].
  Future<void> removeTherapy(Therapy therapy);
}
