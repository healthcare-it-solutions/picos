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

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picos/api/database_object_api.dart';
import 'package:picos/models/abstract_database_object.dart';

part 'objects_list_event.dart';

part 'objects_list_state.dart';

/// BloC for gluing ObjectsListEvents and ObjectsListState together.
class ObjectsListBloc<T extends DatabaseObjectApi>
    extends Bloc<ObjectsListEvent, ObjectsListState> {
  /// Creates the ObjectsListBloc.
  ObjectsListBloc(this._objectApi) : super(const ObjectsListState()) {
    on<ObjectsListSubscriptionRequested>(_onSubscriptionRequested);
    on<ObjectsListLoad>(_onObjectsListLoad);
    on<SaveObject>(_onSaveObject);
    on<RemoveObject>(_onRemoveObject);
  }

  final T _objectApi;
  Future<void> _onObjectsListLoad(
      ObjectsListLoad event,
      Emitter<ObjectsListState> emit,
      ) async {
    emit(state.copyWith(status: ObjectsListStatus.loading));
    try {
      List<AbstractDatabaseObject> objects = await _objectApi.getObjects();
      emit(
        state.copyWith(
          status: ObjectsListStatus.success,
          objectsList: objects,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ObjectsListStatus.failure));
    }
  }

  Future<void> _onSubscriptionRequested(
    ObjectsListSubscriptionRequested event,
    Emitter<ObjectsListState> emit,
  ) async {
    emit(state.copyWith(status: ObjectsListStatus.loading));
    try {
      List<AbstractDatabaseObject> objects = await _objectApi.getObjects();
      emit(
        state.copyWith(
          status: ObjectsListStatus.success,
          objectsList: objects,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ObjectsListStatus.failure));
    }
  }

  Future<void> _onSaveObject(
    SaveObject event,
    Emitter<ObjectsListState> emit,
  ) async {
    emit(state.copyWith(status: ObjectsListStatus.loading));
    await _objectApi
        .saveObject(
          event.object,
        )
        .onError(
          (_, __) => emit(
            state.copyWith(
              status: ObjectsListStatus.failure,
            ),
          ),
        )
        .whenComplete(
          () => emit(
            state.copyWith(
              status: ObjectsListStatus.success,
            ),
          ),
        );
  }

  Future<void> _onRemoveObject(
    RemoveObject event,
    Emitter<ObjectsListState> emit,
  ) async {
    emit(state.copyWith(status: ObjectsListStatus.loading));
    await _objectApi
        .removeObject(
          event.object,
        )
        .onError(
          (_, __) => emit(
            state.copyWith(
              status: ObjectsListStatus.failure,
            ),
          ),
        )
        .whenComplete(
          () => emit(
            state.copyWith(
              status: ObjectsListStatus.success,
            ),
          ),
        );
  }
}
