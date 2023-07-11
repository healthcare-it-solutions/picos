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

/// Class with Laborparameter.
class Laborparameter extends AbstractDatabaseObject {
  /// Creates a Laborparameter object.
  const Laborparameter({
    this.leukocyteCount,
    this.lymphocyteCount,
    this.lymphocytePercentage,
    this.plateletCount,
    this.cReactiveProteinLevel,
    this.procalcitoninLevel,
    this.interleukin,
    this.bloodUreaNitrogen,
    this.creatinine,
    this.heartFailureMarker,
    this.heartFailureMarkerNTProBNP,
    this.bilirubinTotal,
    this.hemoglobin,
    this.hematocrit,
    this.albumin,
    this.gotASAT,
    this.gptALAT,
    this.troponin,
    this.creatineKinase,
    this.myocardialInfarctionMarkerCKMB,
    this.lactateDehydrogenaseLevel,
    this.amylaseLevel,
    this.lipaseLevel,
    this.dDimer,
    this.internationalNormalizedRatio,
    this.partialThromboplastinTime,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = 'Laborparameter';

  /// leukocyte count.
  final double? leukocyteCount;

  /// lymphocyte count.
  final double? lymphocyteCount;

  /// Lymphocyte percentage.
  final double? lymphocytePercentage;

  /// platelet count.
  final double? plateletCount;

  /// C-Reactive protein level.
  final double? cReactiveProteinLevel;

  /// procalcitonin (PCT) level.
  final double? procalcitoninLevel;

  /// interleukin (IL-6).
  final double? interleukin;

  /// blood urea nitrogen.
  final double? bloodUreaNitrogen;

  /// creatinine.
  final double? creatinine;

  /// heart failure marker BNP.
  final double? heartFailureMarker;

  /// heart failure marker NT-proBNP.
  final double? heartFailureMarkerNTProBNP;

  /// bilirubin total.
  final double? bilirubinTotal;

  /// hemoglobin.
  final double? hemoglobin;

  /// hematocrit.
  final double? hematocrit;

  /// albumin.
  final double? albumin;

  /// Glutamat-Oxalacetat-Transaminase (GOT/ASAT).
  final double? gotASAT;

  /// Glutamat-Pyruvat-Transaminase (GPT/ALAT).
  final double? gptALAT;

  /// troponin.
  final double? troponin;

  /// creatine kinase.
  final double? creatineKinase;

  /// myocardial infarction marker CK-MB.
  final double? myocardialInfarctionMarkerCKMB;

  /// lactate dehydrogenase level.
  final double? lactateDehydrogenaseLevel;

  /// amylase level.
  final double? amylaseLevel;

  /// lipase level.
  final double? lipaseLevel;

  /// D-dimere.
  final double? dDimer;

  /// international Normalized Ratio (INR).
  final double? internationalNormalizedRatio;

  /// partial thromboplastin time.
  final double? partialThromboplastinTime;

  @override
  get table {
    return databaseTable;
  }

  @override
  Laborparameter copyWith({
    double? leukocyteCount,
    double? lymphocyteCount,
    double? lymphocytePercentage,
    double? plateletCount,
    double? cReactiveProteinLevel,
    double? procalcitoninLevel,
    double? interleukin,
    double? bloodUreaNitrogen,
    double? creatinine,
    double? heartFailureMarker,
    double? heartFailureMarkerNTProBNP,
    double? bilirubinTotal,
    double? hemoglobin,
    double? hematocrit,
    double? albumin,
    double? gotASAT,
    double? gptALAT,
    double? troponin,
    double? creatineKinase,
    double? myocardialInfarctionMarkerCKMB,
    double? lactateDehydrogenaseLevel,
    double? amylaseLevel,
    double? lipaseLevel,
    double? dDimer,
    double? internationalNormalizedRatio,
    double? partialThromboplastinTime,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Laborparameter(
      leukocyteCount: leukocyteCount ?? this.leukocyteCount,
      lymphocyteCount: lymphocyteCount ?? this.lymphocyteCount,
      lymphocytePercentage: lymphocytePercentage ?? this.lymphocytePercentage,
      plateletCount: plateletCount ?? this.plateletCount,
      cReactiveProteinLevel:
          cReactiveProteinLevel ?? this.cReactiveProteinLevel,
      procalcitoninLevel: procalcitoninLevel ?? this.procalcitoninLevel,
      interleukin: interleukin ?? this.interleukin,
      bloodUreaNitrogen: bloodUreaNitrogen ?? this.bloodUreaNitrogen,
      creatinine: creatinine ?? this.creatinine,
      heartFailureMarker: heartFailureMarker ?? this.heartFailureMarker,
      heartFailureMarkerNTProBNP:
          heartFailureMarkerNTProBNP ?? this.heartFailureMarkerNTProBNP,
      bilirubinTotal: bilirubinTotal ?? this.bilirubinTotal,
      hemoglobin: hemoglobin ?? this.hemoglobin,
      hematocrit: hematocrit ?? this.hematocrit,
      albumin: albumin ?? this.albumin,
      gotASAT: gotASAT ?? this.gotASAT,
      gptALAT: gptALAT ?? this.gptALAT,
      troponin: troponin ?? this.troponin,
      creatineKinase: creatineKinase ?? this.creatineKinase,
      myocardialInfarctionMarkerCKMB:
          myocardialInfarctionMarkerCKMB ?? this.myocardialInfarctionMarkerCKMB,
      lactateDehydrogenaseLevel:
          lactateDehydrogenaseLevel ?? this.lactateDehydrogenaseLevel,
      amylaseLevel: amylaseLevel ?? this.amylaseLevel,
      lipaseLevel: lipaseLevel ?? this.lipaseLevel,
      dDimer: dDimer ?? this.dDimer,
      internationalNormalizedRatio:
          internationalNormalizedRatio ?? this.internationalNormalizedRatio,
      partialThromboplastinTime:
          partialThromboplastinTime ?? this.partialThromboplastinTime,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[
        leukocyteCount!,
        lymphocyteCount!,
        lymphocytePercentage!,
        plateletCount!,
        cReactiveProteinLevel!,
        procalcitoninLevel!,
        interleukin!,
        bloodUreaNitrogen!,
        creatinine!,
        heartFailureMarker!,
        heartFailureMarkerNTProBNP!,
        bilirubinTotal!,
        hemoglobin!,
        hematocrit!,
        albumin!,
        gotASAT!,
        gptALAT!,
        troponin!,
        creatineKinase!,
        myocardialInfarctionMarkerCKMB!,
        lactateDehydrogenaseLevel!,
        amylaseLevel!,
        lipaseLevel!,
        dDimer!,
        internationalNormalizedRatio!,
        partialThromboplastinTime!,
      ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        'Leukozyten': leukocyteCount,
        'lymphozyten_abs': lymphocyteCount,
        'lymphozyten_proz': lymphocytePercentage,
        'Thrombozyten': plateletCount,
        'CRP': cReactiveProteinLevel,
        'PCT': procalcitoninLevel,
        'IL_6': interleukin,
        'Urea': bloodUreaNitrogen,
        'Kreatinin': creatinine,
        'BNP': heartFailureMarker,
        'NT_Pro_BNP': heartFailureMarkerNTProBNP,
        'Bilirubin': bilirubinTotal,
        'Haemoglobin': hemoglobin,
        'Haematokrit': hematocrit,
        'Albumin': albumin,
        'GOT': gotASAT,
        'GPT': gptALAT,
        'Troponin': troponin,
        'CK': creatineKinase,
        'CK_MB': myocardialInfarctionMarkerCKMB,
        'LDH': lactateDehydrogenaseLevel,
        'Amylase': amylaseLevel,
        'Lipase': lipaseLevel,
        'D_Dimere': dDimer,
        'INR': internationalNormalizedRatio,
        'pTT': partialThromboplastinTime,
      };
}
