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
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_text_area.dart';

/// Shows the Medicaments page for the [CatalogOfItemsScreen].
class Medicaments extends StatelessWidget {
  /// Medicaments constructor.
  const Medicaments({
    required this.plateletAggregationCallback,
    required this.noakCallback,
    required this.thrombosisprophylaxisCallback,
    required this.antihypertensivesCallback,
    required this.antiarrythmicsCallback,
    required this.antidiabeticsCallback,
    required this.antiinfectivesCallback,
    required this.steroidsCallback,
    required this.inhalativesCallback,
    required this.analgesicsCallback,
    Key? key,
    this.initialPlateletAggregation,
    this.initialNoak,
    this.initialThrombosisProphylaxis,
    this.initialAntihypertensives,
    this.initialAntiarrhythmics,
    this.initialAntidiabetics,
    this.initialAntiInfectives,
    this.initialSteroids,
    this.initialInhalatives,
    this.initialAnalgesics,
  }) : super(key: key);

  /// Platelet Aggregation Callback.
  final void Function(String?) plateletAggregationCallback;

  /// NOAK Callback.
  final void Function(String?) noakCallback;

  /// Thrombosis Prophylaxis Callback.
  final void Function(String?) thrombosisprophylaxisCallback;

  /// Antihypertensives Callback.
  final void Function(String?) antihypertensivesCallback;

  /// Antiarrythmics Callback.
  final void Function(String?) antiarrythmicsCallback;

  /// Antidiabetics Callback.
  final void Function(String?) antidiabeticsCallback;

  /// Antiinfectives Callback.
  final void Function(String?) antiinfectivesCallback;

  /// Steroids Callback.
  final void Function(String?) steroidsCallback;

  /// Inhalatives Callback.
  final void Function(String?) inhalativesCallback;

  /// Analgesics Callback.
  final void Function(String?) analgesicsCallback;

  /// Platelet Aggregation value.
  final String? initialPlateletAggregation;

  /// NOAK value.
  final String? initialNoak;

  /// Thrombosis Prophylaxis value.
  final String? initialThrombosisProphylaxis;

  /// Antihypertensives value.
  final String? initialAntihypertensives;

  /// Antiarrythmics value.
  final String? initialAntiarrhythmics;

  /// Antidiabetics value.
  final String? initialAntidiabetics;

  /// Antiinfectives value.
  final String? initialAntiInfectives;

  /// Steroids value.
  final String? initialSteroids;

  /// Inhalatives value.
  final String? initialInhalatives;

  /// Analgetics value
  final String? initialAnalgesics;

  @override
  Widget build(BuildContext context) {
    const double fontSize = 15;

    const int textAreaLines = 3;

    return PicosDisplayCard(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          const PicosLabel('Atmungsparameter (letzte Werte vor discharge)'),
          const PicosLabel('Thrombozytenaggregation', fontSize: fontSize),
          PicosTextArea(
            maxLines: textAreaLines,
            initialValue: initialPlateletAggregation,
          ),
          const PicosLabel('NOAK', fontSize: fontSize),
          PicosTextArea(
            maxLines: textAreaLines,
            initialValue: initialNoak,
          ),
          const PicosLabel('Thrombosenprophylaxe', fontSize: fontSize),
          PicosTextArea(
            maxLines: textAreaLines,
            initialValue: initialThrombosisProphylaxis,
          ),
          const PicosLabel('Antihypertensiva', fontSize: fontSize),
          PicosTextArea(
            maxLines: textAreaLines,
            initialValue: initialAntihypertensives,
          ),
          const PicosLabel('Antiarrhythmika', fontSize: fontSize),
          PicosTextArea(
            maxLines: textAreaLines,
            initialValue: initialAntiarrhythmics,
          ),
          const PicosLabel('Antidiabetika', fontSize: fontSize),
          PicosTextArea(
            maxLines: textAreaLines,
            initialValue: initialAntidiabetics,
          ),
          const PicosLabel('Antiinfektiva', fontSize: fontSize),
          PicosTextArea(
            maxLines: textAreaLines,
            initialValue: initialAntiInfectives,
          ),
          const PicosLabel('Steroide', fontSize: fontSize),
          PicosTextArea(
            maxLines: textAreaLines,
            initialValue: initialSteroids,
          ),
          const PicosLabel('Inhalativa', fontSize: fontSize),
          PicosTextArea(
            maxLines: textAreaLines,
            initialValue: initialInhalatives,
          ),
          const PicosLabel('Analgetika', fontSize: fontSize),
          PicosTextArea(
            maxLines: textAreaLines,
            initialValue: initialAnalgesics,
          ),
        ],
      ),
    );
  }
}
