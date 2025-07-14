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
class VitalSignsObject extends AbstractDatabaseObject {
  /// Creates a Vital Sign object.
  const VitalSignsObject({
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
  VitalSignsObject copyWith({
    double? heartRate,
    double? systolicArterialPressure,
    double? meanArterialPressure,
    double? diastolicArterialPressure,
    double? centralVenousPressure,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VitalSignsObject(
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

  // @override
  // List<Object> get props => <Object>[];

  @override
  List<Object> get props {
    final List<Object> list = <Object>[];
    if (heartRate != null) {
      list.add(heartRate!);
    }
    if (systolicArterialPressure != null) {
      list.add(systolicArterialPressure!);
    }
    if (centralVenousPressure != null) {
      list.add(centralVenousPressure!);
    }

    if (diastolicArterialPressure != null) {
      list.add(diastolicArterialPressure!);
    }

    if (meanArterialPressure != null) {
      list.add(meanArterialPressure!);
    }
    return list;
  }

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        if (heartRate != null) 'HeartRate': heartRate,
        if (systolicArterialPressure != null) 'SAP': systolicArterialPressure,
        if (centralVenousPressure != null) 'ZVD': centralVenousPressure,
        if (diastolicArterialPressure != null) 'DAP': diastolicArterialPressure,
        if (meanArterialPressure != null) 'MAP': meanArterialPressure,
      };
}
