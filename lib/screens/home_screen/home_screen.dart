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
import 'package:picos/screens/home_screen/picos_menu/picos_menu.dart';
import 'package:picos/themes/global_theme.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:picos/widgets/picos_svg_icon.dart';

import 'overview/overview.dart';

/// This widget is the home page of your application. It is stateful, meaning
/// that it has a State object (defined below) that contains fields that affect
/// how it looks.

/// This class is the configuration for the state. It holds the values (in this
/// case the title) provided by the parent (in this case the App widget) and
/// used by the build method of the State. Fields in a Widget subclass are
/// always marked "final".
class HomeScreen extends StatefulWidget {
  /// BottomBar constructor
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// This class contains all relevant Widgets for the UI.
/// The needed variables and functions/methods are also implemented here.
class _HomeScreenState extends State<HomeScreen> {
  /// stores the currently selected element of the navbar
  int selectedIndex = 0;

  /// This function gets called when tapping on an element on the bottom bar.
  /// It keeps track of the currently selected element.
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _generateHomeScreen(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    BottomNavigationBar bottomNavigationBar = BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const PicosSvgIcon(
            assetName: 'assets/Uebersicht.svg',
            height: 25,
            width: 25,
          ),
          label: AppLocalizations.of(context)!.overview,
        ),
        BottomNavigationBarItem(
          icon: const PicosSvgIcon(
            assetName: 'assets/MyPICOS.svg',
            height: 25,
            width: 25,
          ),
          label: AppLocalizations.of(context)!.myPicos,
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      selectedItemColor: theme.darkGreen1,
    );

    if (selectedIndex == 0) {
      return Scaffold(
        body: const Overview(),
        bottomNavigationBar: bottomNavigationBar,
      );
    }

    return SafeArea(
      child: PicosScreenFrame(
        body: const PicosMenu(),
        title: 'MyPICOS',
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _generateHomeScreen(context);
  }
}
