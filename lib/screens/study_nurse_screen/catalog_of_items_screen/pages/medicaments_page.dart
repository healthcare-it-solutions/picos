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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../widgets/picos_number_field.dart';
import '../../../../widgets/picos_text_area.dart';
import '../widgets/catalog_of_items_label.dart';

/// Shows the Medicaments page for the [CatalogOfItemsScreen].
class MedicamentsPage extends StatelessWidget {
  /// Medicaments constructor.
  const MedicamentsPage({
    required this.morningCallback,
    required this.noonCallback,
    required this.eveningCallback,
    required this.atNightCallback,
    required this.unitCallback,
    required this.medicalProductCallback,
    Key? key,
    this.initialMorning,
    this.initialNoon,
    this.initialEvening,
    this.initialAtNight,
    this.initialUnit,
    this.initialMedicalProduct,
  }) : super(key: key);

  /// NOAK Callback.
  final void Function(double?) morningCallback;

  /// Thrombosis Prophylaxis Callback.
  final void Function(double?) noonCallback;

  /// Antihypertensives Callback.
  final void Function(double?) eveningCallback;

  /// Antiarrythmics Callback.
  final void Function(double?) atNightCallback;

  /// Antidiabetics Callback.
  final void Function(String?) unitCallback;

  /// Antidiabetics Callback.
  final void Function(String?) medicalProductCallback;

  /// Platelet Aggregation value.
  final double? initialMorning;

  /// NOAK value.
  final double? initialNoon;

  /// Thrombosis Prophylaxis value.
  final double? initialEvening;

  /// Antihypertensives value.
  final double? initialAtNight;

  /// Antiarrythmics value.
  final String? initialUnit;

  /// Antidiabetics value.
  final String? initialMedicalProduct;

  @override
  Widget build(BuildContext context) {
    const int textAreaLines = 3;

    return CatalogOfItemsPage(
      title: AppLocalizations.of(context)!.medicaments,
      children: <Widget>[
        Column(
          children: <Widget>[
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.inTheMorning,
            ),
            PicosNumberField(
              initialValue: initialMorning?.toString(),
              onChanged: (String value) {
                morningCallback(
                  double.tryParse(value),
                );
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.noon,
            ),
            PicosNumberField(
              initialValue: initialNoon?.toString(),
              onChanged: (String value) {
                noonCallback(
                  double.tryParse(value),
                );
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.inTheEvening,
            ),
            PicosNumberField(
              initialValue: initialEvening?.toString(),
              onChanged: (String value) {
                eveningCallback(
                  double.tryParse(value),
                );
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.toTheNight,
            ),
            PicosNumberField(
              initialValue: initialAtNight?.toString(),
              onChanged: (String value) {
                atNightCallback(
                  double.tryParse(value),
                );
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.unit,
            ),
            PicosTextArea(
              maxLines: textAreaLines,
              initialValue: initialUnit,
              onChanged: (String value) {
                unitCallback(
                  value,
                );
              },
            ),
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.medicalProduct,
            ),
            PicosTextArea(
              maxLines: textAreaLines,
              initialValue: initialMedicalProduct,
              onChanged: (String value) {
                medicalProductCallback(
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
