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

import 'package:picos/models/stay.dart';

/// The interface for an API that provides access to a list of stays.
abstract class StaysApi {
  /// Stays API constructor.
  const StaysApi();

  /// Provides a [Stream] of all stays.
  Future<Stream<List<Stay>>> getStays();

  /// Saves or replaces a [stay].
  Future<void> saveStay(Stay stay);

  /// Removes the given [stay].
  Future<void> removeStay(Stay stay);
}
