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

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:picos/models/abstract_database_object.dart';

import '../../api/backend_therapies_api.dart';
import '../../models/therapy.dart';
import '../objects_list_event.dart';

part 'therapies_list_state.dart';

/// BloC for gluing ObjectsListEvent and TherapiesListState together.
class TherapiesListBloc
    extends Bloc<ObjectsListEvent, TherapiesListState> {
  /// Creates the TherapiesListBloc.
  TherapiesListBloc({required BackendTherapiesApi therapiesRepository})
      : _therapiesRepository = therapiesRepository,
        super(const TherapiesListState()) {
    on<ObjectsListSubscriptionRequested>(_onSubscriptionRequested);
    on<SaveObject>(_onSaveObject);
    on<RemoveObject>(_onRemoveObject);
  }

  final BackendTherapiesApi _therapiesRepository;

  Future<void> _onSubscriptionRequested(
      ObjectsListSubscriptionRequested event,
    Emitter<TherapiesListState> emit,
  ) async {
    emit(state.copyWith(status: TherapiesListStatus.loading));

    await emit.forEach<List<AbstractDatabaseObject>>(
      await _therapiesRepository.getObjects(),
      onData: (List<AbstractDatabaseObject> therapies) {
        return state.copyWith(
          status: TherapiesListStatus.success,
          therapiesList: therapies,
        );
      },
      onError: (_, __) {
        return state.copyWith(
          status: TherapiesListStatus.failure,
        );
      },
    );
  }

  Future<void> _onSaveObject(
    SaveObject event,
    Emitter<TherapiesListState> emit,
  ) async {
    emit(state.copyWith(status: TherapiesListStatus.loading));
    await _therapiesRepository
        .saveObject(
          event.object,
        )
        .onError(
          (_, __) => emit(
            state.copyWith(
              status: TherapiesListStatus.failure,
            ),
          ),
        )
        .whenComplete(
          () => emit(
            state.copyWith(
              status: TherapiesListStatus.success,
            ),
          ),
        );
  }

  Future<void> _onRemoveObject(
    RemoveObject event,
    Emitter<TherapiesListState> emit,
  ) async {
    emit(state.copyWith(status: TherapiesListStatus.loading));
    await _therapiesRepository
        .removeObject(
          event.object,
        )
        .onError(
          (_, __) => emit(
            state.copyWith(
              status: TherapiesListStatus.failure,
            ),
          ),
        )
        .whenComplete(
          () => emit(
            state.copyWith(
              status: TherapiesListStatus.success,
            ),
          ),
        );
  }
}
