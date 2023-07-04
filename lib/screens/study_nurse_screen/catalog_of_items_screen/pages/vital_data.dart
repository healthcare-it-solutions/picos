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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../widgets/picos_number_field.dart';
import '../catalog_of_items_page.dart';
import '../widgets/catalog_of_items_label.dart';

/// Shows the vital data page.
class VitalData extends StatelessWidget {
  /// Creates VitalData.
  const VitalData({
    required this.heartRateCallback1,
    required this.sapCallback1,
    required this.mapCallback1,
    required this.dapCallback1,
    required this.centralVenousPressureCallback1,
    required this.heartRateCallback2,
    required this.sapCallback2,
    required this.mapCallback2,
    required this.dapCallback2,
    required this.centralVenousPressureCallback2,
    Key? key,
    this.initialCentralVenousPressure1,
    this.initialCentralVenousPressure2,
    this.initialDap1,
    this.initialDap2,
    this.initialHeartRate1,
    this.initialHeartRate2,
    this.initialMap1,
    this.initialMap2,
    this.initialSap1,
    this.initialSap2,
  }) : super(key: key);

  /// Heart rate callback.
  final void Function(double? value) heartRateCallback1;

  /// Systolic arterial pressure callback.
  final void Function(double? value) sapCallback1;

  /// Mean arterial pressure callback.
  final void Function(double? value) mapCallback1;

  /// Diastolic arterial pressure callback.
  final void Function(double? value) dapCallback1;

  /// Central venous pressure callback.
  final void Function(double? value) centralVenousPressureCallback1;

  /// Heart rate callback.
  final void Function(double? value) heartRateCallback2;

  /// Systolic arterial pressure callback.
  final void Function(double? value) sapCallback2;

  /// Mean arterial pressure callback.
  final void Function(double? value) mapCallback2;

  /// Diastolic arterial pressure callback.
  final void Function(double? value) dapCallback2;

  /// Central venous pressure callback.
  final void Function(double? value) centralVenousPressureCallback2;

  /// Starting value for last heart rate.
  final double? initialHeartRate1;

  /// Starting value for pre last heart rate.
  final double? initialHeartRate2;

  /// Starting value for last systolic arterial pressure.
  final double? initialSap1;

  /// Starting value for pre last systolic arterial pressure.
  final double? initialSap2;

  /// Starting value for last mean arterial pressure.
  final double? initialMap1;

  /// Starting value for pre last mean arterial pressure.
  final double? initialMap2;

  /// Starting value for last diastolic arterial pressure.
  final double? initialDap1;

  /// Starting value for pre diastolic arterial pressure.
  final double? initialDap2;

  /// Starting value for last central venous pressure.
  final double? initialCentralVenousPressure1;

  /// Starting value for pre last central venous pressure.
  final double? initialCentralVenousPressure2;

  Row _createRow(Widget left, Widget right) {
    return Row(
      children: <Expanded>[
        Expanded(child: left),
        Expanded(child: right),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const String min = '/min';
    const String mmHg = 'mmHg';

    return CatalogOfItemsPage(
      title: AppLocalizations.of(context)!.vitalDataIcuDischarge,
      children: <Widget>[
        _createRow(
          CatalogOfItemsLabel(
            AppLocalizations.of(context)!.last,
            fontWeight: FontWeight.normal,
          ),
          CatalogOfItemsLabel(
            AppLocalizations.of(context)!.preLast,
            fontWeight: FontWeight.normal,
          ),
        ),
        _createRow(
          Column(
            children: <Widget>[
              CatalogOfItemsLabel(
                AppLocalizations.of(context)!.heartFrequency,
              ),
              PicosNumberField(
                hint: min,
                initialValue: initialHeartRate1?.toString(),
                onChanged: (String value) {
                  heartRateCallback1(double.tryParse(value));
                },
              ),
            ],
          ),
          Column(
            children: <Widget>[
              CatalogOfItemsLabel(
                AppLocalizations.of(context)!.heartFrequency,
              ),
              PicosNumberField(
                hint: min,
                initialValue: initialHeartRate2?.toString(),
                onChanged: (String value) {
                  heartRateCallback2(double.tryParse(value));
                },
              ),
            ],
          ),
        ),
        _createRow(
          Column(
            children: <Widget>[
              CatalogOfItemsLabel(
                AppLocalizations.of(context)!.systolicArterialPressure,
              ),
              PicosNumberField(
                hint: mmHg,
                initialValue: initialSap1?.toString(),
                onChanged: (String value) {
                  sapCallback1(double.tryParse(value));
                },
              ),
            ],
          ),
          Column(
            children: <Widget>[
              CatalogOfItemsLabel(
                AppLocalizations.of(context)!.systolicArterialPressure,
              ),
              PicosNumberField(
                hint: mmHg,
                initialValue: initialSap2?.toString(),
                onChanged: (String value) {
                  sapCallback2(double.tryParse(value));
                },
              ),
            ],
          ),
        ),
        _createRow(
          Column(
            children: <Widget>[
              CatalogOfItemsLabel(
                AppLocalizations.of(context)!.meanArterialPressure,
              ),
              PicosNumberField(
                hint: mmHg,
                initialValue: initialMap1?.toString(),
                onChanged: (String value) {
                  mapCallback1(double.tryParse(value));
                },
              ),
            ],
          ),
          Column(
            children: <Widget>[
              CatalogOfItemsLabel(
                AppLocalizations.of(context)!.meanArterialPressure,
              ),
              PicosNumberField(
                hint: mmHg,
                initialValue: initialMap2?.toString(),
                onChanged: (String value) {
                  mapCallback2(double.tryParse(value));
                },
              ),
            ],
          ),
        ),
        _createRow(
          Column(
            children: <Widget>[
              CatalogOfItemsLabel(
                AppLocalizations.of(context)!.diastolicArterialPressure,
              ),
              PicosNumberField(
                hint: mmHg,
                initialValue: initialDap1?.toString(),
                onChanged: (String value) {
                  dapCallback1(double.tryParse(value));
                },
              ),
            ],
          ),
          Column(
            children: <Widget>[
              CatalogOfItemsLabel(
                AppLocalizations.of(context)!.diastolicArterialPressure,
              ),
              PicosNumberField(
                hint: mmHg,
                initialValue: initialDap2?.toString(),
                onChanged: (String value) {
                  dapCallback2(double.tryParse(value));
                },
              ),
            ],
          ),
        ),
        _createRow(
          Column(
            children: <Widget>[
              CatalogOfItemsLabel(
                AppLocalizations.of(context)!.centralVenousPressure,
              ),
              PicosNumberField(
                hint: mmHg,
                initialValue: initialCentralVenousPressure1?.toString(),
                onChanged: (String value) {
                  centralVenousPressureCallback1(double.tryParse(value));
                },
              ),
            ],
          ),
          Column(
            children: <Widget>[
              CatalogOfItemsLabel(
                AppLocalizations.of(context)!.centralVenousPressure,
              ),
              PicosNumberField(
                hint: mmHg,
                initialValue: initialCentralVenousPressure2?.toString(),
                onChanged: (String value) {
                  centralVenousPressureCallback2(double.tryParse(value));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
