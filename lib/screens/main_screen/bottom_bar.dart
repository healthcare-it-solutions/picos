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
import 'package:picos/screens/overview_screen/overview_screen.dart';
import 'package:picos/screens/picos_menu_screen.dart';

// TODO: add proper docs

/// This widget is the home page of your application. It is stateful, meaning
/// that it has a State object (defined below) that contains fields that affect
/// how it looks.

/// This class is the configuration for the state. It holds the values (in this
/// case the title) provided by the parent (in this case the App widget) and
/// used by the build method of the State. Fields in a Widget subclass are
/// always marked "final".
class BottomBar extends StatefulWidget {
  /// BottomBar constructor
  const BottomBar({required this.title, Key? key}) : super(key: key);

  /// home screen title
  final String title;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

/// This class contains all relevant Widgets for the UI.
/// The needed variables and functions/methods are also implemented here.
class _BottomBarState extends State<BottomBar> {
  /// stores the currently selected element of the navbar
  int selectedIndex = 0;

  // TODO: refactor and remove this List
  final List<String> _appBarTitles = <String>[
    'Overview',
    'MyPicos'
  ];

  // TODO: refactor the appBarTitle to return localized messages
  String appBarTitle(BuildContext context, int index) {
    final List<String> appBarTitles = <String>[
      'Overview',
      'MyPicos'
    ];

    return appBarTitles[index];
  }

  /// This function gets called when tapping on an element on the bottom bar.
  /// It keeps track of the currently selected element.
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(25, 102, 117, 1.0),
        title: Center(
          child: Text(
            _appBarTitles[selectedIndex],
          ),
        ),
      ),
      body: Center(
        // TODO: move this widget list outside of the build function,
        // TODO: implement a function that returns a title instead
        child: <Widget>[
          const OverviewScreen(),
          const PicosMenu()
        ].elementAt(selectedIndex),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.house_outlined,
              color: Colors.black,
            ),
            label: Text(AppLocalizations.of(context)!.overview).data,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.chat_bubble_outline,
              color: Colors.black,
            ),
            label: Text(AppLocalizations.of(context)!.myPicos).data,
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
