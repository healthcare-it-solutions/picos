import 'package:picos/api/medications_api.dart';
import 'package:picos/models/medication.dart';

/// A repository that handles medication related requests.
class MedicationsRepository {
  /// MedicationsRepository constructor.
  const MedicationsRepository({
    required MedicationsApi medicationsApi,
  }) : _medicationsApi = medicationsApi;

  final MedicationsApi _medicationsApi;

  /// Provides a [Stream] of all medications.
  Stream<List<Medication>> getMedications() {
    return _medicationsApi.getMedications();
  }

  /// Saves or replaces a [medication].
  Future<void> saveMedication(Medication medication) {
    return _medicationsApi.saveMedication(medication);
  }
}
