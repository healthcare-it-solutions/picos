part of 'medications_list_bloc.dart';

/// Defines Events for MedicationsList.
abstract class MedicationsListEvent extends Equatable {
  /// Event constructor.
  const MedicationsListEvent();

  @override
  List<Object> get props => <Object>[];
}

/// Subscribes to MedicationsListUpdates.
class MedicationsListSubscriptionRequested extends MedicationsListEvent {
  /// MedicationsListSubscriptionRequested constructor.
  const MedicationsListSubscriptionRequested();
}

/// Adds or replaces a medication.
class SaveMedication extends MedicationsListEvent {
  /// SaveMedication constructor.
  const SaveMedication(this.medication);

  /// The [medication] to be saved.
  final Medication medication;

  @override
  List<Object> get props => <Object>[medication];
}
