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
import 'package:picos/screens/home_screen/overview/widgets/contact_section.dart';
import 'package:picos/screens/home_screen/overview/widgets/my_health_section.dart';
import 'package:picos/themes/global_theme.dart';
import 'widgets/input_card_section.dart';

/// Main widget using all subwidgets to build up the "overview"-screen
class Overview extends StatelessWidget {
  /// OverviewScreen constructor
  const Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return ListView(
      children: <Widget>[
        const SizedBox(
          height: 15,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Image>[
            Image.asset(
              'assets/PICOS_Logo_RGB.png',
              height: 75,
            )
          ],
        ),
        Container(
          color: theme.darkGreen1,
          child: const InputCardSection(),
        ),
        Container(
          color: theme.blue,
          child: const MyHealthSection(),
        ),
        const ContactSection()
      ],
    );
  }
}
