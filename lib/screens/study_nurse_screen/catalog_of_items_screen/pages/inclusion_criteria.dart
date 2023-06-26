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

import '../catalog_of_items_page.dart';

/// Shows the inclusion criteria page.
class InclusionCriteria extends StatelessWidget {
  /// Creates InclusionCriteria.
  const InclusionCriteria({
    required this.mechanicalVentilation24hCallback,
    required this.icuStay72hCallback,
    required this.age18YearsCallback,
    Key? key,
    this.initialMechanicalVentilation24h,
    this.initialIcuStay72h,
    this.initialAge18Years,
  }) : super(key: key);

  /// Mechanical ventilation >24h callback.
  final void Function(bool value) mechanicalVentilation24hCallback;

  /// ICU stay > 72h callback.
  final void Function(bool value) icuStay72hCallback;

  /// Age >= 18 years callback.
  final void Function(bool value) age18YearsCallback;

  /// Starting value for mechanical ventilation.
  final bool? initialMechanicalVentilation24h;

  /// Starting value for ICU stay.
  final bool? initialIcuStay72h;

  /// Starting value for age.
  final bool? initialAge18Years;

  @override
  Widget build(BuildContext context) {
    return CatalogOfItemsPage(
      title: AppLocalizations.of(context)!.inclusionCriteriaDistance,
      padding: EdgeInsets.zero,
      children: <PicosSwitch>[
        PicosSwitch(
          onChanged: (bool value) {
            mechanicalVentilation24hCallback(value);
          },
          initialValue: initialMechanicalVentilation24h,
          title: '${AppLocalizations.of(context)!.mechanicalVentilation} >24h',
        ),
        PicosSwitch(
          onChanged: (bool value) {
            icuStay72hCallback(value);
          },
          initialValue: initialIcuStay72h,
          title:
              '${AppLocalizations.of(context)!.icuStay} >72h',
        ),
        PicosSwitch(
          onChanged: (bool value) {
            age18YearsCallback(value);
          },
          initialValue: initialAge18Years,
          title:
              '${AppLocalizations.of(context)!.age} >=18 '
                  '${AppLocalizations.of(context)!.years}',
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
        ),
      ],
    );
  }
}
