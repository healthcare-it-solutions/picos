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
import 'package:picos/screens/overview_screen/widgets/my_health_section.dart';
import 'widgets/input_card_section.dart';

/// Main widget using all subwidgets to build up the "overview"-screen
class OverviewScreen extends StatelessWidget {
  /// OverviewScreen constructor
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          color: const Color.fromARGB(255, 15, 88, 104),
          child: const InputCardSection(),
        ),
        Container(
          color: Colors.blue,
          child: const MyHealthSection(),
        ),
      ],
    );
  }
}
