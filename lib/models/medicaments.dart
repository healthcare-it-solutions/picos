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

/// Class with Medicaments.
class Medicaments extends AbstractDatabaseObject {
  /// Creates a Medicaments object.
  const Medicaments({
    required this.patientObjectId,
    required this.doctorObjectId,
    this.morning,
    this.noon,
    this.evening,
    this.atNight,
    this.unit,
    this.medicalProduct,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = 'medication';

  /// The amount to take in the morning.
  final double? morning;

  /// The amount to take in the noon.
  final double? noon;

  /// The amount to take in the evening.
  final double? evening;

  /// The amount to take before night.
  final double? atNight;

  /// Patient ObjectId.
  final String patientObjectId;

  /// Doctor ObjectId.
  final String doctorObjectId;

  /// Unit
  final String? unit;

  /// Medical Product
  final String? medicalProduct;

  @override
  get table {
    return databaseTable;
  }

  @override
  Medicaments copyWith({
    double? morning,
    double? noon,
    double? evening,
    double? atNight,
    String? unit,
    String? medicalProduct,
    String? patientObjectId,
    String? doctorObjectId,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Medicaments(
      morning: morning ?? this.morning,
      noon: noon ?? this.noon,
      evening: evening ?? this.evening,
      atNight: atNight ?? this.atNight,
      unit: unit ?? this.unit,
      medicalProduct: medicalProduct ?? this.medicalProduct,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      patientObjectId: patientObjectId ?? this.patientObjectId,
      doctorObjectId: doctorObjectId ?? this.doctorObjectId,
    );
  }

  @override
  List<Object> get props => <Object>[
        doctorObjectId,
        patientObjectId,
      ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        if (morning != null) 'Morning': morning,
        if (noon != null) 'Noon': noon,
        if (evening != null) 'Evening': evening,
        if (atNight != null) 'AtNight': atNight,
        if (unit != null) 'Unit': unit,
        if (medicalProduct != null) 'MedicalProduct': medicalProduct,
        'Patient': <String, String>{
          'objectId': patientObjectId,
          '__type': 'Pointer',
          'className': '_User',
        },
        'Doctor': <String, String>{
          'objectId': doctorObjectId,
          '__type': 'Pointer',
          'className': '_User',
        },
      };
}
