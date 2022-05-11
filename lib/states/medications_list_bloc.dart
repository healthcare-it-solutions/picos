import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:picos/repository/medications_repository.dart';

import '../models/medication.dart';

part 'medications_list_event.dart';

part 'medications_list_state.dart';

/// Bloc for gluing MedicationsListEvents and MedicationsListState together.
class MedicationsListBloc
    extends Bloc<MedicationsListEvent, MedicationsListState> {
  /// Creates the MedicationsListBloc.
  MedicationsListBloc({required MedicationsRepository medicationsRepository})
      : _medicationsRepository = medicationsRepository,
        super(const MedicationsListState()) {
    on<MedicationsListSubscriptionRequested>(_onSubscriptionRequested);
    on<SaveMedication>(_onAddMedication);
  }

  final MedicationsRepository _medicationsRepository;

  Future<void> _onSubscriptionRequested(
      MedicationsListSubscriptionRequested event,
      Emitter<MedicationsListState> emit) async {
    emit(state.copyWith(status: MedicationsListStatus.loading));

    await emit.forEach<List<Medication>>(
      _medicationsRepository.getMedications(),
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

  Future<void> _onAddMedication(SaveMedication event,
      Emitter<MedicationsListState> emit) async {
    await _medicationsRepository.saveMedication(event.medication);
  }
}
