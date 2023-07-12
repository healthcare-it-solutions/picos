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
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/catalog_of_items_page.dart';
import 'package:picos/widgets/picos_text_area.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/catalog_of_items_label.dart';

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
    const int textAreaLines = 3;

    return CatalogOfItemsPage(
      title: AppLocalizations.of(context)!.medicaments,
      children: <Widget>[
        Column(
          children: <Widget>[
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.thrombosisAggregation,
            ),
            PicosTextArea(
              maxLines: textAreaLines,
              initialValue: initialPlateletAggregation,
              onChanged: (String value) {
                plateletAggregationCallback(
                  value,
                );
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.noac,
            ),
            PicosTextArea(
              maxLines: textAreaLines,
              initialValue: initialNoak,
              onChanged: (String value) {
                noakCallback(
                  value,
                );
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.thrombosisProphylaxis,
            ),
            PicosTextArea(
              maxLines: textAreaLines,
              initialValue: initialThrombosisProphylaxis,
              onChanged: (String value) {
                thrombosisprophylaxisCallback(
                  value,
                );
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.antihypertensives,
            ),
            PicosTextArea(
              maxLines: textAreaLines,
              initialValue: initialAntihypertensives,
              onChanged: (String value) {
                antiarrythmicsCallback(
                  value,
                );
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.antiarrythmics,
            ),
            PicosTextArea(
              maxLines: textAreaLines,
              initialValue: initialAntiarrhythmics,
              onChanged: (String value) {
                analgesicsCallback(
                  value,
                );
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.antidiabetics,
            ),
            PicosTextArea(
              maxLines: textAreaLines,
              initialValue: initialAntidiabetics,
              onChanged: (String value) {
                antidiabeticsCallback(
                  value,
                );
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.antiinfectives,
            ),
            PicosTextArea(
              maxLines: textAreaLines,
              initialValue: initialAntiInfectives,
              onChanged: (String value) {
                antiinfectivesCallback(
                  value,
                );
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.stereoids,
            ),
            PicosTextArea(
              maxLines: textAreaLines,
              initialValue: initialSteroids,
              onChanged: (String value) {
                steroidsCallback(
                  value,
                );
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.inhalatives,
            ),
            PicosTextArea(
              maxLines: textAreaLines,
              initialValue: initialInhalatives,
              onChanged: (String value) {
                inhalativesCallback(
                  value,
                );
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.analgesics,
            ),
            PicosTextArea(
              maxLines: textAreaLines,
              initialValue: initialAnalgesics,
              onChanged: (String value) {
                analgesicsCallback(
                  value,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
