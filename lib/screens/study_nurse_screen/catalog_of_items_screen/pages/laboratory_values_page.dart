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

import 'package:flutter/material.dart';
import 'package:picos/gen_l10n/app_localizations.dart';

import '../../../../widgets/picos_number_field.dart';
import '../catalog_of_items_page.dart';
import '../widgets/catalog_of_items_label.dart';

/// Shows the vital data page.
class LaboratoryValuesPage extends StatelessWidget {
  /// Creates VitalData.
  const LaboratoryValuesPage({
    required this.leukocyteCountCallback,
    required this.lymphocyteCountCallback,
    required this.lymphocytePercentageCallback,
    required this.plateletCountCallback,
    required this.cReactiveProteinLevelCallback,
    required this.procalcitoninLevelCallback,
    required this.interleukinCallback,
    required this.bloodUreaNitrogenCallback,
    required this.creatinineCallback,
    required this.heartFailureMarkerCallback,
    required this.heartFailureMarkerNTProBNPCallback,
    required this.bilirubinTotalCallback,
    required this.hemoglobinCallback,
    required this.hematocritCallback,
    required this.albuminCallback,
    required this.gotASATCallback,
    required this.gptALATCallback,
    required this.troponinCallback,
    required this.creatineKinaseCallback,
    required this.myocardialInfarctionMarkerCKMBCallback,
    required this.lactateDehydrogenaseLevelCallback,
    required this.amylaseLevelCallback,
    required this.lipaseLevelCallback,
    required this.dDimerCallback,
    required this.internationalNormalizedRatioCallback,
    required this.partialThromboplastinTimeCallback,
    Key? key,
    this.initialLeukocyteCount,
    this.initialLymphocyteCount,
    this.initialLymphocytePercentage,
    this.initialPlateletCount,
    this.initialcReactiveProteinLevel,
    this.initialProcalcitoninLevel,
    this.initialInterleukin,
    this.initialBloodUreaNitrogen,
    this.initialCreatinine,
    this.initialHeartFailureMarker,
    this.initialHeartFailureMarkerNTProBNP,
    this.initialBilirubinTotal,
    this.initialHemoglobin,
    this.initialHematocrit,
    this.initialAlbumin,
    this.initialGOTASAT,
    this.initialGPTALAT,
    this.initialTroponin,
    this.initialCreatineKinase,
    this.initialMyocardialInfarctionMarkerCKMB,
    this.initialLactateDehydrogenaseLevel,
    this.initialAmylaseLevel,
    this.initialLipaseLevel,
    this.initialDDimer,
    this.initialInternationalNormalizedRatio,
    this.initialPartialThromboplastinTime,
  }) : super(key: key);

  /// Leukocyte or white blood cells count callback.
  final void Function(double? value) leukocyteCountCallback;

  /// Lymphocytes count callback.
  final void Function(double? value) lymphocyteCountCallback;

  /// Lymphocytes percentage callback.
  final void Function(double? value) lymphocytePercentageCallback;

  /// Thrombocytes or platelets count callback.
  final void Function(double? value) plateletCountCallback;

  /// C-reactive protein level callback.
  final void Function(double? value) cReactiveProteinLevelCallback;

  /// Procalcitonin (PCT) level callback.
  final void Function(double? value) procalcitoninLevelCallback;

  /// Interleukin (IL-6) callback.
  final void Function(double? value) interleukinCallback;

  /// Blood Urea Nitrogen callback.
  final void Function(double? value) bloodUreaNitrogenCallback;

  /// Creatinine callback.
  final void Function(double? value) creatinineCallback;

  /// Heart failure marker BNP callback.
  final void Function(double? value) heartFailureMarkerCallback;

  /// Heart failure marker NT-proBNP callback.
  final void Function(double? value) heartFailureMarkerNTProBNPCallback;

  /// Bilirubin total callback.
  final void Function(double? value) bilirubinTotalCallback;

  /// Hemoglobin callback.
  final void Function(double? value) hemoglobinCallback;

  /// Hematocrit callback.
  final void Function(double? value) hematocritCallback;

  /// Albumin callback.
  final void Function(double? value) albuminCallback;

  /// Glutamat-Oxalacetat-Transaminase (GOT/ASAT) callback.
  final void Function(double? value) gotASATCallback;

  /// Glutamat-Pyruvat-Transaminase (GPT/ALAT) callback.
  final void Function(double? value) gptALATCallback;

  /// Troponin callback.
  final void Function(double? value) troponinCallback;

  /// Creatine kinase callback.
  final void Function(double? value) creatineKinaseCallback;

  /// Myocardial infarction marker CK-MB callback.
  final void Function(double? value) myocardialInfarctionMarkerCKMBCallback;

  /// Lactate dehydrogenase level callback.
  final void Function(double? value) lactateDehydrogenaseLevelCallback;

  /// Amylase level callback.
  final void Function(double? value) amylaseLevelCallback;

  /// Lipase level callback.
  final void Function(double? value) lipaseLevelCallback;

  /// D-dimer callback.
  final void Function(double? value) dDimerCallback;

  /// International Normalized Ratio (INR) callback.
  final void Function(double? value) internationalNormalizedRatioCallback;

  /// Partial thromboplastin time callback.
  final void Function(double? value) partialThromboplastinTimeCallback;

  /// Starting value for leukocyte count.
  final double? initialLeukocyteCount;

  /// Starting value for lymphocyte count.
  final double? initialLymphocyteCount;

  /// Starting value for Lymphocyte percentage.
  final double? initialLymphocytePercentage;

  /// Starting value for platelet count.
  final double? initialPlateletCount;

  /// Starting value for C-Reactive protein level.
  final double? initialcReactiveProteinLevel;

  /// Starting value for procalcitonin (PCT) level.
  final double? initialProcalcitoninLevel;

  /// Starting value for interleukin (IL-6).
  final double? initialInterleukin;

  /// Starting value for blood urea nitrogen.
  final double? initialBloodUreaNitrogen;

  /// Starting value for creatinine.
  final double? initialCreatinine;

  /// Starting value for heart failure marker BNP.
  final double? initialHeartFailureMarker;

  /// Starting value for heart failure marker NT-proBNP.
  final double? initialHeartFailureMarkerNTProBNP;

  /// Starting value for bilirubin total.
  final double? initialBilirubinTotal;

  /// Starting value for hemoglobin.
  final double? initialHemoglobin;

  /// Starting value for hematocrit.
  final double? initialHematocrit;

  /// Starting value for albumin.
  final double? initialAlbumin;

  /// Starting value for Glutamat-Oxalacetat-Transaminase (GOT/ASAT).
  final double? initialGOTASAT;

  /// Starting value for Glutamat-Pyruvat-Transaminase (GPT/ALAT).
  final double? initialGPTALAT;

  /// Starting value for troponin.
  final double? initialTroponin;

  /// Starting value for creatine kinase.
  final double? initialCreatineKinase;

  /// Starting value for myocardial infarction marker CK-MB.
  final double? initialMyocardialInfarctionMarkerCKMB;

  /// Starting value for lactate dehydrogenase level.
  final double? initialLactateDehydrogenaseLevel;

  /// Starting value for amylase level.
  final double? initialAmylaseLevel;

  /// Starting value for lipase level.
  final double? initialLipaseLevel;

  /// Starting value for D-dimere.
  final double? initialDDimer;

  /// Starting value for international Normalized Ratio (INR).
  final double? initialInternationalNormalizedRatio;

  /// Starting value for partial thromboplastin time.
  final double? initialPartialThromboplastinTime;

  @override
  Widget build(BuildContext context) {
    const String mgdL = 'mg/dL';
    const String tenUl = '10*3/µL';
    const String pgmL = 'pg/mL';
    const String ngmL = 'ng/mL';
    const String qdL = 'q/dL';
    const String uL = 'U/L';
    const String percent = '%';

    return CatalogOfItemsPage(
      title: AppLocalizations.of(context)!.laboratoryValues,
      children: <Widget>[
        Column(
          children: <Widget>[
            CatalogOfItemsLabel(AppLocalizations.of(context)!.leukocyteCount),
            PicosNumberField(
              hint: tenUl,
              initialValue: initialLeukocyteCount?.toString(),
              onChanged: (String value) {
                leukocyteCountCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.lymphocyteCount,
            ),
            PicosNumberField(
              hint: tenUl,
              initialValue: initialLymphocyteCount?.toString(),
              onChanged: (String value) {
                lymphocyteCountCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.lymphocytePercentage,
            ),
            PicosNumberField(
              hint: percent,
              initialValue: initialLymphocytePercentage?.toString(),
              onChanged: (String value) {
                lymphocytePercentageCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.plateletCount),
            PicosNumberField(
              hint: tenUl,
              initialValue: initialPlateletCount?.toString(),
              onChanged: (String value) {
                plateletCountCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.cReactiveProteinLevel,
            ),
            PicosNumberField(
              hint: 'nmol/L',
              initialValue: initialcReactiveProteinLevel?.toString(),
              onChanged: (String value) {
                cReactiveProteinLevelCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.procalcitoninLevel,
            ),
            PicosNumberField(
              hint: ngmL,
              initialValue: initialProcalcitoninLevel?.toString(),
              onChanged: (String value) {
                procalcitoninLevelCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.interleukin),
            PicosNumberField(
              hint: pgmL,
              initialValue: initialInterleukin?.toString(),
              onChanged: (String value) {
                interleukinCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.bloodUreaNitrogen,
            ),
            PicosNumberField(
              hint: mgdL,
              initialValue: initialBloodUreaNitrogen?.toString(),
              onChanged: (String value) {
                bloodUreaNitrogenCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.creatinine),
            PicosNumberField(
              hint: mgdL,
              initialValue: initialCreatinine?.toString(),
              onChanged: (String value) {
                creatinineCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.heartFailureMarker,
            ),
            PicosNumberField(
              hint: pgmL,
              initialValue: initialHeartFailureMarker?.toString(),
              onChanged: (String value) {
                heartFailureMarkerCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.heartFailureMarkerNTProBNP,
            ),
            PicosNumberField(
              hint: pgmL,
              initialValue: initialHeartFailureMarkerNTProBNP?.toString(),
              onChanged: (String value) {
                heartFailureMarkerNTProBNPCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.bilirubinTotal),
            PicosNumberField(
              hint: mgdL,
              initialValue: initialBilirubinTotal?.toString(),
              onChanged: (String value) {
                bilirubinTotalCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.hemoglobin),
            PicosNumberField(
              hint: qdL,
              initialValue: initialHemoglobin?.toString(),
              onChanged: (String value) {
                hemoglobinCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.hematocrit),
            PicosNumberField(
              hint: percent,
              initialValue: initialHematocrit?.toString(),
              onChanged: (String value) {
                hematocritCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.albumin),
            PicosNumberField(
              hint: qdL,
              initialValue: initialAlbumin?.toString(),
              onChanged: (String value) {
                albuminCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.gotASAT),
            PicosNumberField(
              hint: uL,
              initialValue: initialGOTASAT?.toString(),
              onChanged: (String value) {
                gotASATCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.gptALAT),
            PicosNumberField(
              hint: uL,
              initialValue: initialGPTALAT?.toString(),
              onChanged: (String value) {
                gptALATCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.troponin),
            PicosNumberField(
              hint: 'µg/L',
              initialValue: initialTroponin?.toString(),
              onChanged: (String value) {
                troponinCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.creatineKinase),
            PicosNumberField(
              hint: uL,
              initialValue: initialCreatineKinase?.toString(),
              onChanged: (String value) {
                creatineKinaseCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.myocardialInfarctionMarkerCKMB,
            ),
            PicosNumberField(
              hint: uL,
              initialValue: initialMyocardialInfarctionMarkerCKMB?.toString(),
              onChanged: (String value) {
                myocardialInfarctionMarkerCKMBCallback(
                  double.tryParse(value),
                );
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.lactateDehydrogenaseLevel,
            ),
            PicosNumberField(
              hint: uL,
              initialValue: initialLactateDehydrogenaseLevel?.toString(),
              onChanged: (String value) {
                lactateDehydrogenaseLevelCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.amylaseLevel),
            PicosNumberField(
              hint: uL,
              initialValue: initialAmylaseLevel?.toString(),
              onChanged: (String value) {
                amylaseLevelCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.lipaseLevel),
            PicosNumberField(
              hint: uL,
              initialValue: initialLipaseLevel?.toString(),
              onChanged: (String value) {
                lipaseLevelCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(AppLocalizations.of(context)!.dDimer),
            PicosNumberField(
              hint: ngmL,
              initialValue: initialDDimer?.toString(),
              onChanged: (String value) {
                dDimerCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.internationalNormalizedRatio,
            ),
            PicosNumberField(
              hint: '',
              initialValue: initialInternationalNormalizedRatio?.toString(),
              onChanged: (String value) {
                internationalNormalizedRatioCallback(double.tryParse(value));
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.partialThromboplastinTime,
            ),
            PicosNumberField(
              hint: 's',
              initialValue: initialPartialThromboplastinTime?.toString(),
              onChanged: (String value) {
                partialThromboplastinTimeCallback(double.tryParse(value));
              },
            ),
          ],
        ),
      ],
    );
  }
}
