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

import 'package:equatable/equatable.dart';

/// Class with medication information.
class Medication extends Equatable {
  /// Creates a medication object.
  const Medication({
    required this.compound,
    required this.morning,
    required this.noon,
    required this.evening,
    required this.night,
  });

  /// The amount to take in the morning.
  final double morning;

  /// The amount to take in the noon.
  final double noon;

  /// The amount to take in the evening.
  final double evening;

  /// The amount to take before night.
  final double night;

  /// The compound to be taken.
  final String compound;

  /// All possible amount values.
  static const List<String> selection = <String>['0', '1/2', '1', '2', '3'];

  /// Returns a copy of this medication with the given values updated.
  Medication copyWith({
    String? compound,
    double? morning,
    double? noon,
    double? evening,
    double? night,
  }) {
    return Medication(
      compound: compound ?? this.compound,
      morning: morning ?? this.morning,
      noon: noon ?? this.noon,
      evening: evening ?? this.evening,
      night: night ?? this.night,
    );
  }

  @override
  List<Object> get props => <Object>[
        compound,
        morning,
        noon,
        evening,
        night,
      ];
}
