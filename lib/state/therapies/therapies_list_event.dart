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

/// Defines Events for TherapiesList.
abstract class TherapiesListEvent extends Equatable {
  /// Event constructor.
  const TherapiesListEvent();

  @override
  List<Object> get props => <Object>[];
}

/// Subscribes to TherapiesListUpdates.
class TherapiesListSubscriptionRequested extends TherapiesListEvent {
  /// TherapiesListSubscriptionRequested constructor.
  const TherapiesListSubscriptionRequested();
}

/// Adds or replaces a therapy.
class SaveTherapy extends TherapiesListEvent {
  /// SaveTherapy constructor.
  const SaveTherapy(this.therapy);

  /// The [therapy] to be saved.
  final Therapy therapy;

  @override
  List<Object> get props => <Object>[therapy];
}

/// Removes a therapy.
class RemoveTherapy extends TherapiesListEvent {
  /// RemoveTherapy constructor.
  const RemoveTherapy(this.therapy);

  /// The [therapy] to be removed.
  final Therapy therapy;

  @override
  List<Object> get props => <Object>[therapy];
}
