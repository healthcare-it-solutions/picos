import 'package:equatable/equatable.dart';

/// Class with medication information.
class Medication extends Equatable {
  /// Creates a medication object.
  const Medication({
    required this.compound,
    required this.morning,
    required this.noon,
    required this.evening,
    required this.night,
  });

  /// The amount to take in the morning.
  final double morning;

  /// The amount to take in the noon.
  final double noon;

  /// The amount to take in the evening.
  final double evening;

  /// The amount to take before night.
  final double night;

  /// The compound to be taken.
  final String compound;

  /// All possible amount values.
  static const List<String> selection = <String>['0', '1/2', '1', '2', '3'];

  /// Returns a copy of this medication with the given values updated.
  Medication copyWith({
    String? compound,
    double? morning,
    double? noon,
    double? evening,
    double? night,
  }) {
    return Medication(
      compound: compound ?? this.compound,
      morning: morning ?? this.morning,
      noon: noon ?? this.noon,
      evening: evening ?? this.evening,
      night: night ?? this.night,
    );
  }

  @override
  List<Object> get props => <Object>[compound, morning, noon, evening, night];
}
