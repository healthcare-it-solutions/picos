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

part of 'therapies_list_bloc.dart';

/// Possible states for the list can contain.
enum TherapiesListStatus {
  /// The initial state on creation.
  initial,

  /// State for loading or processing.
  loading,

  /// State when loading was successful.
  success,

  /// State when loading failed.
  failure
}

/// Handles the TherapiesListState.
class TherapiesListState extends Equatable {
  /// TherapiesListState constructor.
  const TherapiesListState({
    this.therapiesList = const <Therapy>[],
    this.status = TherapiesListStatus.initial,
  });

  /// The current [TherapiesListStatus].
  final TherapiesListStatus status;

  /// The current [therapiesList] containing all therapies.
  final List<Therapy> therapiesList;

  /// Creates a copy with updated values.
  TherapiesListState copyWith({
    List<Therapy>? therapiesList,
    TherapiesListStatus? status,
    bool? hasReachedMax,
  }) {
    return TherapiesListState(
      status: status ?? this.status,
      therapiesList: therapiesList ?? this.therapiesList,
    );
  }

  @override
  List<Object> get props => <Object>[status, therapiesList];
}
