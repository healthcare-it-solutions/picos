/*
*  This file is part of Picos, a health tracking mobile app
*  Copyright (C) 2022 Healthcare IT Solutions GmbH
*
*  This program is free software: you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation, either version 3 of the License, or
*  (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  You should have received a copy of the GNU General Public License
*  along with this program. If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/screens/overview_screen/widgets/tile.dart';
import 'package:picos/screens/overview_screen/widgets/section.dart';

/// Widget which displays health-related information
class MyHealthSection extends StatelessWidget {
  /// MyHealthSection constructor
  const MyHealthSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Section(
      title: AppLocalizations.of(context)!.myHealth,
      titleColor: Colors.white,
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 20,
          runSpacing: 20,
          children: <Widget>[
            Tile(
              imageName: 'assets/Medikationsplan.png',
              sectionName: AppLocalizations.of(context)!.myMedications,
              routeName: '/my-medications-screen/my-medications',
            ),
            Tile(
              imageName: 'assets/Physiotherapie.png',
              sectionName: AppLocalizations.of(context)!.myTherapy,
              routeName: '/my-therapy-screen/my-therapy',
            ),
            Tile(
              imageName: 'assets/Rehospitalisierung_1225743855_┬®iStock.png',
              sectionName: AppLocalizations.of(context)!.visits,
              routeName: '/visits-screen/visits',
            )
          ],
        ),
      ),
    );
  }
}
