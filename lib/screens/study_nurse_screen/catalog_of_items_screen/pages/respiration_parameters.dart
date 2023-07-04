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
import 'package:picos/widgets/picos_number_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Shows the Respiration Parameters page for the [CatalogOfItemsScreen].
class RespirationParameters extends StatelessWidget {
  /// Respiration Parameters constructor.
  const RespirationParameters({
    required this.tidalVolumenCallback,
    required this.respiratoryRate1Callback,
    required this.respiratoryRate2Callback,
    required this.oxygenSaturation1Callback,
    required this.oxygenSaturation2Callback,
    Key? key,
    this.initialTidalVolume,
    this.initialRespiratoryRate1,
    this.initialRespiratoryRate2,
    this.initialOxygenSaturation1,
    this.initialOxygenSaturation2,
  }) : super(key: key);

  /// Tidal Volume (ml) Callback.
  final void Function(double?) tidalVolumenCallback;

  /// Respiratory Rate 1 (/min) Callback.
  final void Function(double?) respiratoryRate1Callback;

  /// Respiratory Rate 2 (/min) Callback.
  final void Function(double?) respiratoryRate2Callback;

  /// Oxygen Saturation 1 (%) Callback.
  final void Function(double?) oxygenSaturation1Callback;

  /// Oxygen Saturation 2 (%) Callback.
  final void Function(double?) oxygenSaturation2Callback;

  /// Starting value for tidal volume.
  final double? initialTidalVolume;

  /// Starting value for respiratory rate 1.
  final double? initialRespiratoryRate1;

  /// Starting value for respiratory rate 2.
  final double? initialRespiratoryRate2;

  /// Starting value for oxygen saturation 1.
  final double? initialOxygenSaturation1;

  /// Starting value for oxygen saturation 2.
  final double? initialOxygenSaturation2;

  @override
  Widget build(BuildContext context) {
    const double fontSize = 15;

    const String min = '/min';

    return PicosDisplayCard(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          PicosLabel(AppLocalizations.of(context)!.respirationParameters),
          Column(
            children: <Widget>[
              Row(
                children: <Expanded>[
                  Expanded(
                    child: PicosLabel(
                      AppLocalizations.of(context)!.last,
                      fontSize: fontSize,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Expanded(
                    child: PicosLabel(
                      AppLocalizations.of(context)!.preLast,
                      fontSize: fontSize,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              PicosLabel(
                AppLocalizations.of(context)!.vtSpontanous,
                fontSize: fontSize,
              ),
              const PicosNumberField(hint: 'mL'),
              Row(
                children: <Expanded>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        PicosLabel(
                          AppLocalizations.of(context)!.o2sat,
                          fontSize: fontSize,
                        ),
                        const PicosNumberField(hint: '%'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        PicosLabel(
                          AppLocalizations.of(context)!.o2sat,
                          fontSize: fontSize,
                        ),
                        const PicosNumberField(hint: '%'),
                      ],
                    ),
                  ),
                ],
              ),
              const Row(
                children: <Expanded>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        PicosLabel('AF', fontSize: fontSize),
                        PicosNumberField(hint: min),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        PicosLabel('AF', fontSize: fontSize),
                        PicosNumberField(hint: min),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
