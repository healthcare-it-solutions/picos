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

/// Class with patient data information.
class PatientData extends AbstractDatabaseObject {
  /// Creates a patient data object.
  const PatientData({
    required this.bodyHeight,
    required this.patientID,
    required this.caseNumber,
    required this.instKey,
    required this.patientObjectId,
    required this.doctorObjectId,
    this.bodyWeight,
    this.ezpICU,
    this.age,
    this.gender,
    this.bmi,
    this.idealBMI,
    this.dischargeReason,
    this.azpICU,
    this.ventilationDays,
    this.azpKH,
    this.ezpKH,
    this.icd10Codes,
    this.station,
    this.lbgt70,
    this.icuMortality,
    this.khMortality,
    this.icuLengthStay,
    this.khLengthStay,
    this.wdaKH,
    this.weznDisease,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// denotes the age of the patient.
  final int? age;

  /// denotes the gender of the patient.
  final String? gender;

  /// denotes the body height.
  final double bodyHeight;

  /// denotes the body weight.
  final double? bodyWeight;

  /// denotes body mass index.
  final double? bmi;

  /// denotes the ideal body mass index.
  final double? idealBMI;

  /// denotes the patient ID.
  final String patientID;

  /// denotes the case number.
  final String caseNumber;

  /// denotes the discharge reason.
  final String? dischargeReason;

  /// denotes the start time of ICU stay.
  final DateTime? azpICU;

  /// denotes the mortality rate within hospital.
  final double? khMortality;

  /// denotes the LBgt70 value.
  final bool? lbgt70;

  /// denotes the list of ICD 10 codes.
  final List<String>? icd10Codes;

  /// denotes the start time in hospital.
  final DateTime? azpKH;

  /// denotes the end time in hospital.
  final DateTime? ezpKH;

  /// denotes the final time in ICU.
  final DateTime? ezpICU;

  /// denotes the number of ventilation days.
  final int? ventilationDays;

  /// denotes the station.
  final String? station;

  /// denotes the ICU mortality.
  final double? icuMortality;

  /// denotes the length of the ICU stay.
  final int? icuLengthStay;

  /// denotes the length of the stay in hospital.
  final int? khLengthStay;

  /// denotes the WdaKH value.
  final double? wdaKH;

  /// denotes the WEZnDisease value.
  final double? weznDisease;

  /// denotes the institute key.
  final String instKey;

  /// denotes the doctor's object ID.
  final String doctorObjectId;

  /// denotes the patient's object ID.
  final String patientObjectId;

  /// The database table the objects are stored in.
  static const String databaseTable = 'patientData';

  @override
  get table {
    return databaseTable;
  }

  /// Returns a copy of this patient profile with the given values updated.
  @override
  PatientData copyWith({
    int? age,
    String? gender,
    double? bodyHeight,
    double? bodyWeight,
    double? bmi,
    double? idealBMI,
    String? patientID,
    String? caseNumber,
    String? dischargeReason,
    DateTime? azpICU,
    DateTime? ezpICU,
    int? ventilationDays,
    DateTime? azpKH,
    DateTime? ezpKH,
    List<String>? icd10Codes,
    String? station,
    bool? lbgt70,
    double? icuMortality,
    double? khMortality,
    int? icuLengthStay,
    int? khLengthStay,
    double? wdaKH,
    double? weznDisease,
    String? instKey,
    String? patientObjectId,
    String? doctorObjectId,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PatientData(
      age: age ?? this.age,
      gender: gender ?? this.gender,
      bodyHeight: bodyHeight ?? this.bodyHeight,
      bodyWeight: bodyWeight ?? this.bodyWeight,
      bmi: bmi ?? this.bmi,
      idealBMI: idealBMI ?? this.idealBMI,
      patientID: patientID ?? this.patientID,
      caseNumber: caseNumber ?? this.caseNumber,
      dischargeReason: dischargeReason ?? this.dischargeReason,
      azpICU: azpICU ?? this.azpICU,
      ezpICU: ezpICU ?? this.ezpICU,
      ventilationDays: ventilationDays ?? this.ventilationDays,
      azpKH: azpKH ?? this.azpKH,
      ezpKH: ezpKH ?? this.ezpKH,
      icd10Codes: icd10Codes ?? this.icd10Codes,
      station: station ?? this.station,
      lbgt70: lbgt70 ?? this.lbgt70,
      icuMortality: icuMortality ?? this.icuMortality,
      khMortality: khMortality ?? this.khMortality,
      icuLengthStay: icuLengthStay ?? this.icuLengthStay,
      khLengthStay: khLengthStay ?? this.khLengthStay,
      wdaKH: wdaKH ?? this.wdaKH,
      weznDisease: weznDisease ?? this.weznDisease,
      instKey: instKey ?? this.instKey,
      patientObjectId: patientObjectId ?? this.patientObjectId,
      doctorObjectId: doctorObjectId ?? this.doctorObjectId,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[
        bodyHeight,
        patientID,
        caseNumber,
        instKey,
      ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        'Age': age,
        'Gender': gender,
        'BodyHeight': bodyHeight,
        'BodyWeight': bodyWeight,
        'BMI': bmi,
        'IdealBMI': idealBMI,
        'ID': patientID,
        'CaseNumber': caseNumber,
        'DischargeReason': dischargeReason,
        'AZP_ICU': azpICU,
        'EZP_ICU': ezpICU,
        'VentilationDays': ventilationDays,
        'AZP_KH': azpKH,
        'EZP_KH': ezpKH,
        'ICD_10_Codes': icd10Codes,
        'Station': station,
        'LBgt70': lbgt70,
        'ICU_Mortality': icuMortality,
        'KH_Mortality': khMortality,
        'ICU_LengthStay': icuLengthStay,
        'KH_LengthStay': khLengthStay,
        'WdaKH': wdaKH,
        'WEZnDisease': weznDisease,
        'inst_key': instKey,
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
