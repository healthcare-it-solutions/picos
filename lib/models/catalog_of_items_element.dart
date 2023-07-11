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
import 'package:picos/models/icu_diagnosis.dart';
import 'package:picos/models/labor_parameters.dart';
import 'package:picos/models/medicaments.dart';
import 'package:picos/models/patient_data.dart';
import 'package:picos/models/respiratory_parameters_object.dart';
import 'package:picos/models/vital_signs_object.dart';

import 'blood_gas_analysis_object.dart';

/// Class with Catalog of Items information.
class CatalogOfItemsElement extends AbstractDatabaseObject {
  /// Creates a Catalog of Items object.
  const CatalogOfItemsElement({
    required this.icuDiagnosis,
    required this.vitalSigns,
    required this.respiratoryParameters,
    required this.bloodGasAnalysis,
    required this.laborParameters,
    required this.medicaments,
    required this.movementData,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = '';

  final ICUDiagnosis icuDiagnosis;

  final VitalSignsObject vitalSigns;

  final RespiratoryParametersObject respiratoryParameters;

  final BloodGasAnalysisObject bloodGasAnalysis;

  final LaborParameters laborParameters;

  final Medicaments medicaments;

  final PatientData movementData;

  @override
  CatalogOfItemsElement copyWith({
    ICUDiagnosis? icuDiagnosis,
    VitalSignsObject? vitalSigns,
    RespiratoryParametersObject? respiratoryParameters,
    BloodGasAnalysisObject? bloodGasAnalysis,
    LaborParameters? laborParameters,
    Medicaments? medicaments,
    PatientData? movementData,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CatalogOfItemsElement(
      icuDiagnosis: icuDiagnosis ?? this.icuDiagnosis,
      vitalSigns: vitalSigns ?? this.vitalSigns,
      respiratoryParameters:
          respiratoryParameters ?? this.respiratoryParameters,
      bloodGasAnalysis: bloodGasAnalysis ?? this.bloodGasAnalysis,
      laborParameters: laborParameters ?? this.laborParameters,
      medicaments: medicaments ?? this.medicaments,
      movementData: movementData ?? this.movementData,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{};

  @override
  List<Object> get props => <Object>[
        icuDiagnosis,
        vitalSigns,
        respiratoryParameters,
        bloodGasAnalysis,
        laborParameters,
        medicaments,
        movementData
      ];

  @override
  String get table => databaseTable;
}
