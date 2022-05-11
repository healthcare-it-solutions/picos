import '../models/medication.dart';

/// The interface for an API that provides access to a list of medications.
abstract class MedicationsApi {
  /// Medications API constructor.
  const MedicationsApi();

  /// Provides a [Stream] of all medications.
  Stream<List<Medication>> getMedications();

  /// Saves or replaces a [medication].
  Future<void> saveMedication(Medication medication);
}
