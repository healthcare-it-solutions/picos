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
import 'package:picos/repository/medications_repository.dart';

import '../models/medication.dart';

part 'medications_list_event.dart';

part 'medications_list_state.dart';

/// BloC for gluing MedicationsListEvents and MedicationsListState together.
class MedicationsListBloc
    extends Bloc<MedicationsListEvent, MedicationsListState> {
  /// Creates the MedicationsListBloc.
  MedicationsListBloc({required MedicationsRepository medicationsRepository})
      : _medicationsRepository = medicationsRepository,
        super(const MedicationsListState()) {
    on<MedicationsListSubscriptionRequested>(_onSubscriptionRequested);
    on<SaveMedication>(_onSaveMedication);
    on<RemoveMedication>(_onRemoveMedication);
  }

  final MedicationsRepository _medicationsRepository;

  Future<void> _onSubscriptionRequested(
    MedicationsListSubscriptionRequested event,
    Emitter<MedicationsListState> emit,
  ) async {
    emit(state.copyWith(status: MedicationsListStatus.loading));

    await emit.forEach<List<Medication>>(
      await _medicationsRepository.getMedications(),
      onData: (List<Medication> medications) {
        return state.copyWith(
          status: MedicationsListStatus.success,
          medicationsList: medications,
        );
      },
      onError: (_, __) {
        return state.copyWith(
          status: MedicationsListStatus.failure,
        );
      },
    );
  }

  Future<void> _onSaveMedication(
    SaveMedication event,
    Emitter<MedicationsListState> emit,
  ) async {
    emit(state.copyWith(status: MedicationsListStatus.loading));
    await _medicationsRepository
        .saveMedication(
          event.medication,
        )
        .onError(
          (_, __) => emit(
            state.copyWith(
              status: MedicationsListStatus.failure,
            ),
          ),
        )
        .whenComplete(
          () => emit(
            state.copyWith(
              status: MedicationsListStatus.success,
            ),
          ),
        );
  }

  Future<void> _onRemoveMedication(
    RemoveMedication event,
    Emitter<MedicationsListState> emit,
  ) async {
    emit(state.copyWith(status: MedicationsListStatus.loading));
    await _medicationsRepository
        .removeMedication(
          event.medication,
        )
        .onError(
          (_, __) => emit(
            state.copyWith(
              status: MedicationsListStatus.failure,
            ),
          ),
        )
        .whenComplete(
          () => emit(
            state.copyWith(
              status: MedicationsListStatus.success,
            ),
          ),
        );
  }
}
