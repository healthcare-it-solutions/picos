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

import '../../api/backend_medications_api.dart';
import '../../models/medication.dart';
import '../objects_list_event.dart';

part 'medications_list_state.dart';

/// BloC for gluing ObjectsListEvents and MedicationsListState together.
class MedicationsListBloc
    extends Bloc<ObjectsListEvent, MedicationsListState> {
  /// Creates the MedicationsListBloc.
  MedicationsListBloc({required BackendMedicationsApi medicationsRepository})
      : _medicationsRepository = medicationsRepository,
        super(const MedicationsListState()) {
    on<ObjectsListSubscriptionRequested>(_onSubscriptionRequested);
    on<SaveObject>(_onSaveObject);
    on<RemoveObject>(_onRemoveObject);
  }

  final BackendMedicationsApi _medicationsRepository;

  Future<void> _onSubscriptionRequested(
    ObjectsListSubscriptionRequested event,
    Emitter<MedicationsListState> emit,
  ) async {
    emit(state.copyWith(status: ObjectsListStatus.loading));

    await emit.forEach<List<AbstractDatabaseObject>>(
      await _medicationsRepository.getObjects(),
      onData: (List<AbstractDatabaseObject> medications) {
        return state.copyWith(
          status: ObjectsListStatus.success,
          medicationsList: medications,
        );
      },
      onError: (_, __) {
        return state.copyWith(
          status: ObjectsListStatus.failure,
        );
      },
    );
  }

  Future<void> _onSaveObject(
    SaveObject event,
    Emitter<MedicationsListState> emit,
  ) async {
    emit(state.copyWith(status: ObjectsListStatus.loading));
    await _medicationsRepository
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
    Emitter<MedicationsListState> emit,
  ) async {
    emit(state.copyWith(status: ObjectsListStatus.loading));
    await _medicationsRepository
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
