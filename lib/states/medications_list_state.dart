part of 'medications_list_bloc.dart';

/// Possible states for the list can contain.
enum MedicationsListStatus {
  /// The initial state on creation.
  initial,
  /// State for loading or processing.
  loading,
  /// State when loading was successful.
  success,
  /// State when loading failed.
  failure
}

/// Handles the MedicationsListState.
class MedicationsListState extends Equatable {
  /// MedicationsListState constructor.
  const MedicationsListState(
      {this.medicationsList = const <Medication>[],
      this.status = MedicationsListStatus.initial,
      });

  /// The current [MedicationsListStatus].
  final MedicationsListStatus status;
  /// The current [medicationsList] containing all medications.
  final List<Medication> medicationsList;

  /// Creates a copy with updated values.
  MedicationsListState copyWith(
      {List<Medication>? medicationsList,
      MedicationsListStatus? status,
      bool? hasReachedMax}) {
    return MedicationsListState(
        status: status ?? this.status,
        medicationsList: medicationsList ?? this.medicationsList,
    );
  }

  @override
  List<Object> get props => <Object>[status, medicationsList];
}
