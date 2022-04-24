/*   This file is part of Picos, a health trcking mobile app
*    Copyright (C) 2022 Aleksej Funkner
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

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../questionaire_screen/questionaire_screen.dart';

// TODO: add proper docs

/// This widget is the home page of your application. It is stateful, meaning
/// that it has a State object (defined below) that contains fields that affect
/// how it looks.

/// This class is the configuration for the state. It holds the values (in this
/// case the title) provided by the parent (in this case the App widget) and
/// used by the build method of the State. Fields in a Widget subclass are
/// always marked "final".
class BottomBar extends StatefulWidget {
  /// Constructor
  const BottomBar({required this.title, Key? key}) : super(key: key);

  /// home screen title
  final String title;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

/// This class contains all relevant Widgets for the UI.
/// The needed variables and functions/methods are also implemented here.
class _BottomBarState extends State<BottomBar> {

  /// Variable to store the value of the currently clicked navbar-item.
  int selectedIndex = 0;

  /// Assignment of index to selectedIndex
  /// in order to show the corresponding page.
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  /// returns the Scaffold containing all UI-widgets.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: <Widget>[
    MaterialButton(
      color: Colors.amber,
      child: const Text('something'),
      onPressed: () {
        Navigator.pushNamed(context, '/questionaire');
      },
    ),
    const Icon(
      Icons.mail,
      size: 150,
    ),
    const Icon(
      Icons.calendar_month,
      size: 150,
    ),
    const Icon(
      Icons.bubble_chart,
      size: 150,
    )
  ].elementAt(selectedIndex),
      ),
      backgroundColor: Colors.grey,
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
                Icons.mail_outline,
                color: Colors.black,
              ),
              label: Text(AppLocalizations.of(context)!.inbox).data),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.calendar_month_outlined,
                color: Colors.black,
              ),
              label: Text(AppLocalizations.of(context)!.calendar).data),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.black,
              ),
              label: Text(AppLocalizations.of(context)!.myPicos).data),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
