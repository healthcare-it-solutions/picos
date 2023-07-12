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
    this.plateletAggregation,
    this.noak,
    this.thrombosisProphylaxis,
    this.antihypertensives,
    this.antiarrhythmics,
    this.antidiabetics,
    this.antiInfectives,
    this.steroids,
    this.inhalatives,
    this.analgesics,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = 'medication';

  /// Platelet Aggregation.
  final String? plateletAggregation;

  /// NOAC.
  final String? noak;

  /// Thrombosis Prophylaxis.
  final String? thrombosisProphylaxis;

  /// Antihypertensives.
  final String? antihypertensives;

  /// Antiarrythmics.
  final String? antiarrhythmics;

  /// Antidiabetics.
  final String? antidiabetics;

  /// Antiinfectives.
  final String? antiInfectives;

  /// Steroids.
  final String? steroids;

  /// Inhalatives.
  final String? inhalatives;

  /// Analgesics.
  final String? analgesics;

  /// Patient ObjectId.
  final String patientObjectId;

  /// Doctor ObjectId.
  final String doctorObjectId;

  @override
  get table {
    return databaseTable;
  }

  @override
  Medicaments copyWith({
    String? plateletAggregation,
    String? noak,
    String? thrombosisProphylaxis,
    String? antihypertensives,
    String? antiarrhythmics,
    String? antidiabetics,
    String? antiInfectives,
    String? steroids,
    String? inhalatives,
    String? analgesics,
    String? patientObjectId,
    String? doctorObjectId,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Medicaments(
      plateletAggregation: plateletAggregation ?? this.plateletAggregation,
      noak: noak ?? this.noak,
      thrombosisProphylaxis:
          thrombosisProphylaxis ?? this.thrombosisProphylaxis,
      antihypertensives: antihypertensives ?? this.antihypertensives,
      antiarrhythmics: antiarrhythmics ?? this.antiarrhythmics,
      antidiabetics: antidiabetics ?? this.antidiabetics,
      antiInfectives: antiInfectives ?? this.antiInfectives,
      steroids: steroids ?? this.steroids,
      inhalatives: inhalatives ?? this.inhalatives,
      analgesics: analgesics ?? this.analgesics,
      patientObjectId: patientObjectId ?? this.patientObjectId,
      doctorObjectId: doctorObjectId ?? this.doctorObjectId,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[
        plateletAggregation!,
        noak!,
        thrombosisProphylaxis!,
        antihypertensives!,
        antiarrhythmics!,
        antidiabetics!,
        antiInfectives!,
        steroids!,
        inhalatives!,
        analgesics!,
      ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        'Antiarrythmika': antiarrhythmics,
        'Antiinfektiva': antiInfectives,
        'Antihypertensiva': antihypertensives,
        'Antidiabetika': antidiabetics,
        'Steroide': steroids,
        'NOAK': noak,
        'Thrombozytenaggregation': plateletAggregation,
        'Thromboseprophylaxe': thrombosisProphylaxis,
        'Inhalativa': inhalatives,
        'Analgetika': analgesics,
        'Patient': <String, String>{
          'objectId': patientObjectId,
          '__type': 'Pointer',
          'className': '_User'
        },
        'Doctor': <String, String>{
          'objectId': doctorObjectId,
          '__type': 'Pointer',
          'className': '_User'
        },
      };
}
