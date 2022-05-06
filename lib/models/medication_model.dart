///Class with medication information.
class MedicationModel {
  ///Creates a medication object.
  MedicationModel();

  ///The amount to take in the morning.
  String morning = '0';
  ///The amount to take in the noon.
  String noon = '0';
  ///The amount to take in the evening.
  String evening = '0';
  ///The amount to take before night.
  String night = '0';

  ///The compound to be taken.
  String? compound;

  ///All possible amount values.
  static const List<String> selection = <String>['0', '1/2', '1', '2', '3'];
}
