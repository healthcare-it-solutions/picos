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
import 'package:picos/repository/therapies_repository.dart';

import '../../models/therapy.dart';

part 'therapies_list_event.dart';

part 'therapies_list_state.dart';

/// BloC for gluing TherapiesListEvent and TherapiesListState together.
class TherapiesListBloc
    extends Bloc<TherapiesListEvent, TherapiesListState> {
  /// Creates the TherapiesListBloc.
  TherapiesListBloc({required TherapiesRepository therapiesRepository})
      : _therapiesRepository = therapiesRepository,
        super(const TherapiesListState()) {
    on<TherapiesListSubscriptionRequested>(_onSubscriptionRequested);
    on<SaveTherapy>(_onSaveTherapy);
    on<RemoveTherapy>(_onRemoveTherapy);
  }

  final TherapiesRepository _therapiesRepository;

  Future<void> _onSubscriptionRequested(
      TherapiesListSubscriptionRequested event,
    Emitter<TherapiesListState> emit,
  ) async {
    emit(state.copyWith(status: TherapiesListStatus.loading));

    await emit.forEach<List<Therapy>>(
      await _therapiesRepository.getTherapies(),
      onData: (List<Therapy> therapies) {
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

  Future<void> _onSaveTherapy(
    SaveTherapy event,
    Emitter<TherapiesListState> emit,
  ) async {
    emit(state.copyWith(status: TherapiesListStatus.loading));
    await _therapiesRepository
        .saveTherapy(
          event.therapy,
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

  Future<void> _onRemoveTherapy(
    RemoveTherapy event,
    Emitter<TherapiesListState> emit,
  ) async {
    emit(state.copyWith(status: TherapiesListStatus.loading));
    await _therapiesRepository
        .removeTherapy(
          event.therapy,
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
