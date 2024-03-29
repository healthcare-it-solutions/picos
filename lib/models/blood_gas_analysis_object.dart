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

import 'package:picos/models/abstract_database_object.dart';

/// Class with Blood Gas Analysis information.
class BloodGasAnalysisObject extends AbstractDatabaseObject {
  /// Creates a Blood Gas Analysis object.
  const BloodGasAnalysisObject({
    this.arterialOxygenSaturation,
    this.centralVenousOxygenSaturation,
    this.partialPressureOfOxygen,
    this.partialPressureOfCarbonDioxide,
    this.arterialBaseExcess,
    this.arterialPH,
    this.arterialSerumBicarbonateConcentration,
    this.arterialLactate,
    this.bloodGlucoseLevel,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = 'BloodGasAnalysis_obj';

  /// Arterial Oxygen Saturation.
  final double? arterialOxygenSaturation;

  /// Central Venous Oxygen Saturation.
  final double? centralVenousOxygenSaturation;

  /// Partial Pressure of Oxygen.
  final double? partialPressureOfOxygen;

  /// Partial Pressure of Carbon Dioxide.
  final double? partialPressureOfCarbonDioxide;

  /// Arterial Base Excess.
  final double? arterialBaseExcess;

  /// Arterial PH.
  final double? arterialPH;

  /// Arterial Serum Bicarbonate Concentration.
  final double? arterialSerumBicarbonateConcentration;

  /// Arterial Lactate.
  final double? arterialLactate;

  /// Blood Glucose Level.
  final double? bloodGlucoseLevel;

  @override
  get table {
    return databaseTable;
  }

  @override
  BloodGasAnalysisObject copyWith({
    double? arterialOxygenSaturation,
    double? centralVenousOxygenSaturation,
    double? partialPressureOfOxygen,
    double? partialPressureOfCarbonDioxide,
    double? arterialBaseExcess,
    double? arterialPH,
    double? arterialSerumBicarbonateConcentration,
    double? arterialLactate,
    double? bloodGlucoseLevel,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BloodGasAnalysisObject(
      arterialOxygenSaturation:
          arterialOxygenSaturation ?? this.arterialOxygenSaturation,
      centralVenousOxygenSaturation:
          centralVenousOxygenSaturation ?? this.centralVenousOxygenSaturation,
      partialPressureOfOxygen:
          partialPressureOfOxygen ?? this.partialPressureOfOxygen,
      partialPressureOfCarbonDioxide:
          partialPressureOfCarbonDioxide ?? this.partialPressureOfCarbonDioxide,
      arterialBaseExcess: arterialBaseExcess ?? this.arterialBaseExcess,
      arterialPH: arterialPH ?? this.arterialPH,
      arterialSerumBicarbonateConcentration:
          arterialSerumBicarbonateConcentration ??
              this.arterialSerumBicarbonateConcentration,
      arterialLactate: arterialLactate ?? this.arterialLactate,
      bloodGlucoseLevel: bloodGlucoseLevel ?? this.bloodGlucoseLevel,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        if (arterialBaseExcess != null) 'BE': arterialBaseExcess,
        if (arterialSerumBicarbonateConcentration != null)
          'Bicarbonat': arterialSerumBicarbonateConcentration,
        if (arterialOxygenSaturation != null) 'SaO2': arterialOxygenSaturation,
        if (arterialLactate != null) 'Laktat': arterialLactate,
        if (centralVenousOxygenSaturation != null)
          'SzVO2': centralVenousOxygenSaturation,
        if (partialPressureOfCarbonDioxide != null)
          'PaCO2_woTemp': partialPressureOfCarbonDioxide,
        if (partialPressureOfOxygen != null)
          'PaO2_woTemp': partialPressureOfOxygen,
        if (arterialPH != null) 'pH': arterialPH,
        if (bloodGlucoseLevel != null) 'BloodSugar': bloodGlucoseLevel,
      };
}
