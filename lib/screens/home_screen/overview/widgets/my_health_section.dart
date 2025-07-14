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
import 'package:picos/gen_l10n/app_localizations.dart';
import 'package:picos/screens/home_screen/overview/widgets/section.dart';
import 'package:picos/screens/home_screen/overview/widgets/tile.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Tile(
                  imageName: 'assets/Medikationsplan.png',
                  sectionName: AppLocalizations.of(context)!.myMedications,
                  routeName: '/my-medications-screen/my-medications',
                ),
                const SizedBox(
                  width: 15,
                ),
                Tile(
                  imageName: 'assets/Physiotherapie.png',
                  sectionName: AppLocalizations.of(context)!.myTherapy,
                  routeName: '/my-therapy-screen/my-therapy',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Tile(
                  imageName:
                      'assets/Rehospitalisierung_1225743855_┬®iStock.png',
                  sectionName: AppLocalizations.of(context)!.visits,
                  routeName: '/visits-screen/my-visits-screen',
                ),
                const SizedBox(
                  width: 15,
                ),
                Tile(
                  imageName: 'assets/BehandlerInnen.png',
                  sectionName: AppLocalizations.of(context)!.myPhysicians,
                  routeName: '/physician-list-screen/physicians',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Tile(
                  imageName: 'assets/Angehoerige.png',
                  sectionName: AppLocalizations.of(context)!.myFamilyMembers,
                  routeName: '/family-member-list-screen/family-members',
                ),
                const SizedBox(
                  width: 15,
                ),
                Tile(
                  imageName: 'assets/Dokumente.png',
                  sectionName: AppLocalizations.of(context)!.myDocuments,
                  routeName: '/my-documents-screen/my-documents',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
