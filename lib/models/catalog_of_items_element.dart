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
import 'package:picos/models/respiratory_parameters.dart';
import 'package:picos/models/respiratory_parameters_object.dart';
import 'package:picos/models/vital_signs.dart';
import 'package:picos/models/vital_signs_object.dart';

import 'blood_gas_analysis.dart';
import 'blood_gas_analysis_object.dart';

/// Class with Catalog of Items information.
class CatalogOfItemsElement extends AbstractDatabaseObject {
  /// Creates a Catalog of Items object.
  const CatalogOfItemsElement({
    required this.icuDiagnosis,
    required this.vitalSignsObject1,
    required this.vitalSignsObject2,
    required this.vitalSigns,
    required this.respiratoryParametersObject1,
    required this.respiratoryParametersObject2,
    required this.respiratoryParameters,
    required this.bloodGasAnalysisObject1,
    required this.bloodGasAnalysisObject2,
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

  final VitalSignsObject vitalSignsObject1;

  final VitalSignsObject vitalSignsObject2;

  final VitalSigns vitalSigns;

  final RespiratoryParametersObject respiratoryParametersObject1;

  final RespiratoryParametersObject respiratoryParametersObject2;

  final RespiratoryParameters respiratoryParameters;

  final BloodGasAnalysisObject bloodGasAnalysisObject1;

  final BloodGasAnalysisObject bloodGasAnalysisObject2;

  final BloodGasAnalysis bloodGasAnalysis;

  final LaborParameters laborParameters;

  final Medicaments medicaments;

  final PatientData movementData;

  @override
  CatalogOfItemsElement copyWith({
    ICUDiagnosis? icuDiagnosis,
    VitalSignsObject? vitalSignsObject1,
    VitalSignsObject? vitalSignsObject2,
    VitalSigns? vitalSigns,
    RespiratoryParametersObject? respiratoryParametersObject1,
    RespiratoryParametersObject? respiratoryParametersObject2,
    RespiratoryParameters? respiratoryParameters,
    BloodGasAnalysisObject? bloodGasAnalysisObject1,
    BloodGasAnalysisObject? bloodGasAnalysisObject2,
    BloodGasAnalysis? bloodGasAnalysis,
    LaborParameters? laborParameters,
    Medicaments? medicaments,
    PatientData? movementData,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CatalogOfItemsElement(
      icuDiagnosis: icuDiagnosis ?? this.icuDiagnosis,
      vitalSignsObject1: vitalSignsObject1 ?? this.vitalSignsObject1,
      vitalSignsObject2: vitalSignsObject2 ?? this.vitalSignsObject2,
      vitalSigns: vitalSigns ?? this.vitalSigns,
      respiratoryParametersObject1:
          respiratoryParametersObject1 ?? this.respiratoryParametersObject1,
      respiratoryParametersObject2:
          respiratoryParametersObject2 ?? this.respiratoryParametersObject2,
      respiratoryParameters:
          respiratoryParameters ?? this.respiratoryParameters,
      bloodGasAnalysisObject1:
          bloodGasAnalysisObject1 ?? this.bloodGasAnalysisObject1,
      bloodGasAnalysisObject2:
          bloodGasAnalysisObject2 ?? this.bloodGasAnalysisObject2,
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
        vitalSignsObject1,
        vitalSignsObject2,
        vitalSigns,
        respiratoryParametersObject1,
        respiratoryParametersObject2,
        respiratoryParameters,
        bloodGasAnalysisObject1,
        bloodGasAnalysisObject2,
        bloodGasAnalysis,
        laborParameters,
        medicaments,
        movementData
      ];

  @override
  String get table => databaseTable;
}
