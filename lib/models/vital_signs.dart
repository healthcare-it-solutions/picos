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

/// Class with Vital Signs.
class VitalSigns extends AbstractDatabaseObject {
  /// Creates a Vital Sign object.
  const VitalSigns({
    this.heartRate,
    this.systolicArterialPressure,
    this.meanArterialPressure,
    this.diastolicArterialPressure,
    this.centralVenousPressure,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = 'VitalSigns_obj';

  /// Heart rate.
  final double? heartRate;

  /// Systolic arterial pressure.
  final double? systolicArterialPressure;

  /// Mean arterial pressure.
  final double? meanArterialPressure;

  /// Diastolic arterial pressure.
  final double? diastolicArterialPressure;

  /// Central venous pressure.
  final double? centralVenousPressure;

  @override
  get table {
    return databaseTable;
  }

  @override
  VitalSigns copyWith({
    double? heartRate,
    double? systolicArterialPressure,
    double? meanArterialPressure,
    double? diastolicArterialPressure,
    double? centralVenousPressure,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VitalSigns(
      heartRate: heartRate ?? this.heartRate,
      systolicArterialPressure:
          systolicArterialPressure ?? this.systolicArterialPressure,
      meanArterialPressure: meanArterialPressure ?? this.meanArterialPressure,
      diastolicArterialPressure:
          diastolicArterialPressure ?? this.diastolicArterialPressure,
      centralVenousPressure:
          centralVenousPressure ?? this.centralVenousPressure,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[
        heartRate!,
        systolicArterialPressure!,
        meanArterialPressure!,
        diastolicArterialPressure!,
        centralVenousPressure!,
      ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        'HeartRate': heartRate,
        'SAP': systolicArterialPressure,
        'ZVD': centralVenousPressure,
        'DAP': diastolicArterialPressure,
        'MAP': meanArterialPressure,
      };
}
