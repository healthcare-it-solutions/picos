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

  /// Removes a given [medication].
  Future<void> removeMedication(Medication medication) {
    return _medicationsApi.removeMedication(medication);
  }

  /// Converts a Medication amount Double to String.
  static String amountToString(double value) {
    List<String> values = value.toString().split('.');
    String intValue = values[0];
    String half = values[1];

    if (intValue == '0' && half != '0') {
      return '1/2';
    }

    if (intValue != '0' && half != '0') {
      return '$intValue 1/2';
    }

    return intValue;
  }

  /// Converts a Medication amount String to Double.
  static double amountToDouble(String value) {
    if (value.length == 3 && value.substring(value.length - 3) == '1/2') {
      return 0.5;
    }

    if (value.length >= 4 && value.substring(value.length - 4) == ' 1/2') {
      return double.parse(value.split(' ')[0]) + 0.5;
    }

    return double.parse(value);
  }
}
