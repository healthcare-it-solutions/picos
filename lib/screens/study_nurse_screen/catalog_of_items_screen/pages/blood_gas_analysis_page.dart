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
import 'package:picos/widgets/picos_display_card.dart';
import 'package:picos/widgets/picos_number_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/catalog_of_items_label.dart';

/// Shows the Blood Gas Analysis page for the [CatalogOfItemsScreen].
class BloodGasAnalysisPage extends StatelessWidget {
  /// Blood Gas Analysis constructor.
  const BloodGasAnalysisPage({
    required this.arterialOxygenSaturationCallback1,
    required this.arterialOxygenSaturationCallback2,
    required this.centralVenousOxygenSaturationCallback1,
    required this.centralVenousOxygenSaturationCallback2,
    required this.partialPressureOfOxygenCallback1,
    required this.partialPressureOfOxygenCallback2,
    required this.partialPressureOfCarbonDioxideCallback1,
    required this.partialPressureOfCarbonDioxideCallback2,
    required this.arterialBaseExcessCallback1,
    required this.arterialBaseExcessCallback2,
    required this.arterialPHCallback1,
    required this.arterialPHCallback2,
    required this.arterialSerumBicarbonateConcentrationCallback1,
    required this.arterialSerumBicarbonateConcentrationCallback2,
    required this.arterialLactateCallback1,
    required this.arterialLactateCallback2,
    required this.bloodGlucoseLevelCallback1,
    required this.bloodGlucoseLevelCallback2,
    Key? key,
    this.initialArterialOxygenSaturation1,
    this.initialArterialOxygenSaturation2,
    this.initialCentralVenousOxygenSaturation1,
    this.initialCentralVenousOxygenSaturation2,
    this.initialPartialPressureOfOxygen1,
    this.initialPartialPressureOfOxygen2,
    this.initialPartialPressureOfCarbonDioxide1,
    this.initialPartialPressureOfCarbonDioxide2,
    this.initialarterialBaseExcess1,
    this.initialarterialBaseExcess2,
    this.initialarterialPH1,
    this.initialarterialPH2,
    this.initialArterialSerumBicarbonateConcentration1,
    this.initialArterialSerumBicarbonateConcentration2,
    this.initialArterialLactate1,
    this.initialArterialLacatate2,
    this.initialBloodGlucoseLevel1,
    this.initialBloodGlucoseLevel2,
  }) : super(key: key);

  /// Arterial oxygen saturation 1 (%) Callback.
  final void Function(double?) arterialOxygenSaturationCallback1;

  /// Arterial oxygen saturation 2 (%) Callback.
  final void Function(double?) arterialOxygenSaturationCallback2;

  /// Central venous oxygen saturation 1 (%) Callback.
  final void Function(double?) centralVenousOxygenSaturationCallback1;

  /// Central venous oxygen saturation 2 (%) Callback.
  final void Function(double?) centralVenousOxygenSaturationCallback2;

  /// Partial pressure of oxygene 1 (mmHg) Callback.
  final void Function(double?) partialPressureOfOxygenCallback1;

  /// Partial pressure of oxygene 2 (mmHg) Callback.
  final void Function(double?) partialPressureOfOxygenCallback2;

  /// Partial pressure of carbon dioxide 1 (mmHg) Callback.
  final void Function(double?) partialPressureOfCarbonDioxideCallback1;

  /// Partial pressure of carbon dioxide 2 (mmHg) Callback.
  final void Function(double?) partialPressureOfCarbonDioxideCallback2;

  /// Arterial Base Excess 1 (mmol/L) Callback.
  final void Function(double?) arterialBaseExcessCallback1;

  /// Arterial Base Excess 2 (mmol/L) Callback.
  final void Function(double?) arterialBaseExcessCallback2;

  /// Arterial pH 1 Callback.
  final void Function(double?) arterialPHCallback1;

  /// Arterial pH 2 Callback.
  final void Function(double?) arterialPHCallback2;

  /// Arterial Serum Bicarbonate Concentration 1 (mmol/L) Callback.
  final void Function(double?) arterialSerumBicarbonateConcentrationCallback1;

  /// Arterial Serum Bicarbonate Concentration 2 (mmol/L) Callback.
  final void Function(double?) arterialSerumBicarbonateConcentrationCallback2;

  /// Arterial Lactate 1 (mmol/L) Callback.
  final void Function(double?) arterialLactateCallback1;

  /// Arterial Lactate 2 (mmol/L) Callback.
  final void Function(double?) arterialLactateCallback2;

  /// Arterial Lactate 1 (mmol/L) Callback.
  final void Function(double?) bloodGlucoseLevelCallback1;

  /// Artetial Lactate 2 (mmol/L) Callback.
  final void Function(double?) bloodGlucoseLevelCallback2;

  /// Starting value for arterial oxygen saturation 1.
  final double? initialArterialOxygenSaturation1;

  /// Starting value for arterial oxygen saturation 2.
  final double? initialArterialOxygenSaturation2;

  /// Starting value for central venous oxygen saturation 1.
  final double? initialCentralVenousOxygenSaturation1;

  /// Starting value for central venous oxygen saturation 2.
  final double? initialCentralVenousOxygenSaturation2;

  /// Starting value for partial pressure of oxygen 1.
  final double? initialPartialPressureOfOxygen1;

  /// Starting value for partial pressure of oxygen 2.
  final double? initialPartialPressureOfOxygen2;

  /// Starting value for partial pressure of carbon dioxide 1.
  final double? initialPartialPressureOfCarbonDioxide1;

  /// Starting value for partial pressure of carbon dioxide 2.
  final double? initialPartialPressureOfCarbonDioxide2;

  /// Starting value for arterial base excess 1.
  final double? initialarterialBaseExcess1;

  /// Starting value for arterial base excess 2.
  final double? initialarterialBaseExcess2;

  /// Starting value for arterial pH 1.
  final double? initialarterialPH1;

  /// Starting value for arterial pH 2.
  final double? initialarterialPH2;

  /// Starting value for arterial serum bicarbonate concentration 1.
  final double? initialArterialSerumBicarbonateConcentration1;

  /// Starting value for arterial serum bicarbonate concentration 2.
  final double? initialArterialSerumBicarbonateConcentration2;

  /// Starting value for arterial lactate 1.
  final double? initialArterialLactate1;

  /// Starting value for arterial lactate 2.
  final double? initialArterialLacatate2;

  /// Starting value for blood glucose level 1.
  final double? initialBloodGlucoseLevel1;

  /// Starting value for blood glucose level 2.
  final double? initialBloodGlucoseLevel2;

  @override
  Widget build(BuildContext context) {
    const String mmHg = 'mmHg';
    const String mmoll = 'mmol/L';
    const String mgdl = 'mg/dL';
    const String percent = '%';

    return PicosDisplayCard(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          CatalogOfItemsLabel(AppLocalizations.of(context)!.bloodGasAnalysis),
          Column(
            children: <Widget>[
              Row(
                children: <Expanded>[
                  Expanded(
                    child: CatalogOfItemsLabel(
                      AppLocalizations.of(context)!.last,
                    ),
                  ),
                  Expanded(
                    child: CatalogOfItemsLabel(
                      AppLocalizations.of(context)!.preLast,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Expanded>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CatalogOfItemsLabel(
                          AppLocalizations.of(context)!.paO2,
                        ),
                        PicosNumberField(
                          hint: mmHg,
                          onChanged: (String value) {
                            partialPressureOfOxygenCallback1(
                              double.tryParse(value),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CatalogOfItemsLabel(
                          AppLocalizations.of(context)!.paO2,
                        ),
                        PicosNumberField(
                          hint: mmHg,
                          onChanged: (String value) {
                            partialPressureOfOxygenCallback2(
                              double.tryParse(value),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Expanded>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CatalogOfItemsLabel(
                          AppLocalizations.of(context)!.paCO2,
                        ),
                        PicosNumberField(
                          hint: mmHg,
                          onChanged: (String value) {
                            partialPressureOfCarbonDioxideCallback1(
                              double.tryParse(value),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CatalogOfItemsLabel(
                          AppLocalizations.of(context)!.paCO2,
                        ),
                        PicosNumberField(
                          hint: mmHg,
                          onChanged: (String value) {
                            partialPressureOfCarbonDioxideCallback2(
                              double.tryParse(value),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Expanded>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CatalogOfItemsLabel(
                          AppLocalizations.of(context)!.arterialPH,
                        ),
                        PicosNumberField(
                          hint: '[pH]',
                          onChanged: (String value) {
                            arterialPHCallback1(double.tryParse(value));
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CatalogOfItemsLabel(
                          AppLocalizations.of(context)!.arterialPH,
                        ),
                        PicosNumberField(
                          hint: '[pH]',
                          onChanged: (String value) {
                            arterialPHCallback2(double.tryParse(value));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Expanded>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CatalogOfItemsLabel(
                          AppLocalizations.of(context)!.saO2,
                        ),
                        PicosNumberField(
                          hint: percent,
                          onChanged: (String value) {
                            arterialBaseExcessCallback1(
                              double.tryParse(value),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CatalogOfItemsLabel(
                          AppLocalizations.of(context)!.saO2,
                        ),
                        PicosNumberField(
                          hint: percent,
                          onChanged: (String value) {
                            arterialBaseExcessCallback2(
                              double.tryParse(value),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Expanded>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CatalogOfItemsLabel(
                          AppLocalizations.of(context)!.arterialLactate,
                        ),
                        PicosNumberField(
                          hint: mmoll,
                          onChanged: (String value) {
                            arterialLactateCallback1(
                              double.tryParse(value),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CatalogOfItemsLabel(
                          AppLocalizations.of(context)!.arterialLactate,
                        ),
                        PicosNumberField(
                          hint: mmoll,
                          onChanged: (String value) {
                            arterialLactateCallback2(
                              double.tryParse(value),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Expanded>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CatalogOfItemsLabel(
                          AppLocalizations.of(context)!.arterialBicarbonate,
                        ),
                        PicosNumberField(
                          hint: mmoll,
                          onChanged: (String value) {
                            arterialSerumBicarbonateConcentrationCallback1(
                              double.tryParse(value),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CatalogOfItemsLabel(
                          AppLocalizations.of(context)!.arterialBicarbonate,
                        ),
                        PicosNumberField(
                          hint: mmoll,
                          onChanged: (String value) {
                            arterialSerumBicarbonateConcentrationCallback2(
                              double.tryParse(value),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Expanded>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CatalogOfItemsLabel(
                          AppLocalizations.of(context)!.svO2,
                        ),
                        PicosNumberField(
                          hint: percent,
                          onChanged: (String value) {
                            centralVenousOxygenSaturationCallback1(
                              double.tryParse(value),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CatalogOfItemsLabel(
                          AppLocalizations.of(context)!.svO2,
                        ),
                        PicosNumberField(
                          hint: percent,
                          onChanged: (String value) {
                            centralVenousOxygenSaturationCallback2(
                              double.tryParse(value),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Expanded>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CatalogOfItemsLabel(
                          AppLocalizations.of(context)!.arterialBaseExcess,
                        ),
                        PicosNumberField(
                          hint: mmoll,
                          onChanged: (String value) {
                            arterialBaseExcessCallback1(
                              double.tryParse(value),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CatalogOfItemsLabel(
                          AppLocalizations.of(context)!.arterialBaseExcess,
                        ),
                        PicosNumberField(
                          hint: mmoll,
                          onChanged: (String value) {
                            arterialBaseExcessCallback2(
                              double.tryParse(value),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Expanded>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CatalogOfItemsLabel(
                          AppLocalizations.of(context)!.bloodSugar,
                        ),
                        PicosNumberField(
                          hint: mgdl,
                          onChanged: (String value) {
                            bloodGlucoseLevelCallback1(
                              double.tryParse(value),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CatalogOfItemsLabel(
                          AppLocalizations.of(context)!.bloodSugar,
                        ),
                        PicosNumberField(
                          hint: mgdl,
                          onChanged: (String value) {
                            bloodGlucoseLevelCallback2(
                              double.tryParse(value),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
