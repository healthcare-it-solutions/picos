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
import 'package:picos/screens/my_medications_screen/my_medications_screen.dart';
import 'package:picos/screens/physician_list_screen/physicians_screen.dart';
import 'package:picos/screens/family_member_list_screen/family_members_screen.dart';

/// Widget which displays health-related information
class MyHealthSection extends StatelessWidget {
  /// MyHealthSection constructor
  const MyHealthSection({Key? key}) : super(key: key);

  // final double h = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            AppLocalizations.of(context)!.myEntries,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          // This is a horizontal line
          // be my guest to make it better if you know how
          SizedBox(
            height: 1,
            child: Container(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                Container(
                  color: Colors.green,
                  width: 180,
                  height: 180,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext context) =>
                            const MyMedicationsScreen(),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          flex: 3,
                          child: Image.asset('./assets/Medikationsplan.png'),
                        ),
                        Flexible(
                          flex: 2,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.medicationScheme,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.green,
                  width: 180,
                  height: 180,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext context) =>
                            const PhysiciansScreen(),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          flex: 3,
                          child: Image.asset('assets/BehandlerInnen.png'),
                        ),
                        Flexible(
                          flex: 2,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.myPhysicians,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.green,
                  width: 180,
                  height: 180,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext context) =>
                            const FamilyMembersScreen(),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          flex: 3,
                          child: Image.asset('./assets/Angehoerige.png'),
                        ),
                        Flexible(
                          flex: 2,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.familyMembers,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.green,
                  width: 180,
                  height: 180,
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: Image.asset('./assets/Dokumente.png'),
                      ),
                      Flexible(
                        flex: 2,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.documents,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
