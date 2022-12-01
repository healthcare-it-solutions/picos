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

import 'package:picos/api/therapies_api.dart';

import '../models/therapy.dart';

/// A repository that handles therapy related requests.
class TherapiesRepository {
  /// TherapiesRepository constructor.
  const TherapiesRepository({
    required TherapiesApi therapiesApi,
  }) : _therapiesApi = therapiesApi;

  final TherapiesApi _therapiesApi;

  /// Provides a [Stream] of all therapies.
  Future<Stream<List<Therapy>>> getTherapies() {
    return _therapiesApi.getTherapies();
  }

  /// Saves or replaces a [therapy].
  Future<void> saveTherapy(Therapy therapy) {
    return _therapiesApi.saveTherapy(therapy);
  }

  /// Removes a given [therapy].
  Future<void> removeTherapy(Therapy therapy) {
    return _therapiesApi.removeTherapy(therapy);
  }
}
