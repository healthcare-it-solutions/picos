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
import 'package:picos/widgets/picos_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/widgets/picos_text_area.dart';
import 'package:picos/widgets/picos_text_field.dart';

import '../catalog_of_items_page.dart';
import '../widgets/catalog_of_items_label.dart';

/// Shows the ICU diagnosis page.
class IcuDiagnosisPage extends StatelessWidget {
  /// Creates IcuDiagnosis.
  const IcuDiagnosisPage({
    required this.mainDiagnosisCallback,
    required this.ancillaryDiagnosisCallback,
    required this.icuawCallback,
    required this.picsCallback,
    Key? key,
    this.initialMainDiagnosis,
    this.initialAncillaryDiagnosis,
    this.initialIcuaw,
    this.initialPics,
  }) : super(key: key);

  /// Main diagnosis callback.
  final void Function(String? value) mainDiagnosisCallback;

  /// Ancillary diagnosis callback.
  final void Function(List<dynamic>? value) ancillaryDiagnosisCallback;

  /// PICS callback.
  final void Function(bool? value) icuawCallback;

  /// Co-morbidity callback.
  final void Function(bool? value) picsCallback;

  /// Starting value for main diagnosis.
  final String? initialMainDiagnosis;

  /// Starting value for ancillary diagnosis.
  final List<dynamic>? initialAncillaryDiagnosis;

  /// Starting value for ICUAW.
  final bool? initialIcuaw;

  /// Starting value for PICS.
  final bool? initialPics;

  @override
  Widget build(BuildContext context) {
    return CatalogOfItemsPage(
      title: AppLocalizations.of(context)!.icuDiagnosis,
      children: <Widget>[
        Column(
          children: <Widget>[
            CatalogOfItemsLabel(
              AppLocalizations.of(context)!.mainDiagnosis,
            ),
            PicosTextField(
              initialValue: initialMainDiagnosis,
              onChanged: (String value) {
                mainDiagnosisCallback(value);
              },
            ),
            CatalogOfItemsLabel(
                AppLocalizations.of(context)!.ancillaryDiagnosis),
            PicosTextArea(
              initialValue: initialAncillaryDiagnosis?[0].toString(),
              onChanged: (String value) {
                List<dynamic> list = <dynamic>[];
                list.add(value);
                ancillaryDiagnosisCallback(list);
              },
            ),
          ],
        ),
        PicosSwitch(
          onChanged: (bool value) {
            icuawCallback(value);
          },
          initialValue: initialIcuaw,
          title: AppLocalizations.of(context)!.icuaw,
        ),
        PicosSwitch(
          onChanged: (bool value) {
            picsCallback(value);
          },
          initialValue: initialPics,
          title: AppLocalizations.of(context)!.pics,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
        ),
      ],
    );
  }
}
