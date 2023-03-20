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
import 'package:picos/screens/my_therapies_screen/my_therapies_screen.dart';
import 'package:picos/screens/visits_screen/visits_screen.dart';
import 'package:picos/screens/overview_screen/widgets/section.dart';
import 'package:picos/themes/global_theme.dart';

/// Widget which displays health-related information
class MyHealthSection extends StatelessWidget {
  /// MyHealthSection constructor
  const MyHealthSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    Color gradientColor1 = theme.green1!;
    Color gradientColor2 = theme.green2!;

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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                gradient: LinearGradient(
                  colors: <Color>[
                    gradientColor1,
                    gradientColor2,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
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
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(7),
                          topRight: Radius.circular(7),
                        ),
                        child: Image.asset('assets/Medikationsplan.png'),
                      ),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.green,
                gradient: LinearGradient(
                  colors: <Color>[
                    gradientColor1,
                    gradientColor2,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              width: 180,
              height: 180,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (BuildContext context) =>
                        const MyTherapiesScreen(),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(7),
                          topRight: Radius.circular(7),
                        ),
                        child: Image.asset('assets/Physiotherapie.png'),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.myTherapy,
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.green,
                gradient: LinearGradient(
                  colors: <Color>[
                    gradientColor1,
                    gradientColor2,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              width: 180,
              height: 180,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (BuildContext context) => const VisitsScreen(),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(7),
                          topRight: Radius.circular(7),
                        ),
                        child: Image.asset(
                          'assets/Rehospitalisierung_1225743855_┬®iStock.png',
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.visits,
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
          ],
        ),
      ),
    );
  }
}
