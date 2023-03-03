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

part of 'objects_list_bloc.dart';

/// Defines Events for ObjectsList.
abstract class ObjectsListEvent extends Equatable {
  /// Event constructor.
  const ObjectsListEvent();

  @override
  List<Object> get props => <Object>[];
}

/// Subscribes to ObjectsListUpdates.
class ObjectsListSubscriptionRequested extends ObjectsListEvent {
  /// ObjectsListSubscriptionRequested constructor.
  const ObjectsListSubscriptionRequested();
}

/// Adds or replaces an object.
class SaveObject extends ObjectsListEvent {
  /// SaveObject constructor.
  const SaveObject(this.object);

  /// The [object] to be saved.
  final AbstractDatabaseObject object;

  @override
  List<Object> get props => <Object>[object];
}

/// Removes an object.
class RemoveObject extends ObjectsListEvent {
  /// RemoveObject constructor.
  const RemoveObject(this.object);

  /// The [object] to be removed.
  final AbstractDatabaseObject object;

  @override
  List<Object> get props => <Object>[object];
}
