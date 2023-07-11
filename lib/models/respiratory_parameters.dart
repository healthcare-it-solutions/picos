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

/// Class with Respiratory Parameters.
class RespiratoryParameters extends AbstractDatabaseObject {
  /// Creates a Respiratory Parameters object.
  const RespiratoryParameters({
    this.tidalVolume,
    this.respiratoryRate,
    this.oxygenSaturation,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = 'RespiratoryParas_obj';

  /// Tidal Volume.
  final double? tidalVolume;

  /// Respiratory Rate.
  final double? respiratoryRate;
  
  /// Oxygen SAturation.
  final double? oxygenSaturation;

  @override
  get table {
    return databaseTable;
  }

  @override
  RespiratoryParameters copyWith({
    double? tidalVolume,
    double? respiratoryRate,
    double? oxygenSaturation,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RespiratoryParameters(
      tidalVolume: tidalVolume ?? this.tidalVolume,
      respiratoryRate: respiratoryRate ?? this.respiratoryRate,
      oxygenSaturation: oxygenSaturation ?? this.oxygenSaturation,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[
        tidalVolume!,
        respiratoryRate!,
        oxygenSaturation!,
      ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        'AF': respiratoryRate,
        'VT': tidalVolume,
        'SpO2': oxygenSaturation,
      };
}
