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

/// Class with ICU Diagnosis.
class ICUDiagnosis extends AbstractDatabaseObject {
  /// Creates an ICU Diagnosis object.
  const ICUDiagnosis({
    required this.mainDiagnosis,
    required this.progressDiagnosis,
    required this.coMorbidity,
    required this.intensiveCareUnitAcquiredWeakness,
    required this.postIntensiveCareSyndrome,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = 'ICU_Diagnoses';

  /// The ICU main diagnosis.
  final String mainDiagnosis;

  /// The ICU progress diagnosis.
  final String progressDiagnosis;

  /// The co-morbidity.
  final String coMorbidity;

  /// If the patient has ICUAW.
  final bool intensiveCareUnitAcquiredWeakness;

  /// If the patient has PICS.
  final bool postIntensiveCareSyndrome;

  @override
  get table {
    return databaseTable;
  }

  @override
  ICUDiagnosis copyWith({
    String? mainDiagnosis,
    String? progressDiagnosis,
    String? coMorbidity,
    bool? intensiveCareUnitAcquiredWeakness,
    bool? postIntensiveCareSyndrome,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ICUDiagnosis(
      mainDiagnosis: mainDiagnosis ?? this.mainDiagnosis,
      progressDiagnosis: progressDiagnosis ?? this.progressDiagnosis,
      coMorbidity: coMorbidity ?? this.coMorbidity,
      intensiveCareUnitAcquiredWeakness: intensiveCareUnitAcquiredWeakness ??
          this.intensiveCareUnitAcquiredWeakness,
      postIntensiveCareSyndrome:
          postIntensiveCareSyndrome ?? this.postIntensiveCareSyndrome,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[
        mainDiagnosis,
        progressDiagnosis,
        coMorbidity,
        intensiveCareUnitAcquiredWeakness,
        postIntensiveCareSyndrome,
      ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        'ICU_Hd': mainDiagnosis,
        'PICS': postIntensiveCareSyndrome,
        'ICU_Vd': progressDiagnosis,
        'ICU_AW': intensiveCareUnitAcquiredWeakness,
        'CO_Morb': coMorbidity,
      };
}
