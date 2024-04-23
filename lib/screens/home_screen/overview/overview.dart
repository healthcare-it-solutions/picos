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
import 'package:picos/screens/home_screen/overview/widgets/graph_section.dart';
import 'package:picos/screens/home_screen/overview/widgets/my_health_section.dart';
import 'package:picos/screens/home_screen/overview/widgets/questionnaire_section.dart';
import '../../../themes/global_theme.dart';
import '../../../util/status_bar.dart';

/// Main widget using all subwidgets to build up the "overview"-screen
class Overview extends StatefulWidget {
  /// OverviewScreen constructor
  const Overview({Key? key}) : super(key: key);

  /// Holds the value of the scroll position on the Overview-Screen.
  static double overviewScrollPosition = 0.0;

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  final ScrollController _scrollController = ScrollController();

  Color _initialStatusBarColor = Colors.white;
  Brightness _initialStatusBarIconBrightness = Brightness.dark;

  void _onScroll() {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    double scrollPosition = _scrollController.offset;

    if (scrollPosition > 100) {
      StatusBar.setStatusBarProperties(
        theme.darkGreen1!,
        Brightness.light,
      );
    } else {
      StatusBar.setStatusBarProperties(
        _initialStatusBarColor,
        _initialStatusBarIconBrightness,
      );
    }

    Overview.overviewScrollPosition = scrollPosition;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _initialStatusBarColor = Colors.white;
    _initialStatusBarIconBrightness = Brightness.dark;
    StatusBar.setStatusBarProperties(
      _initialStatusBarColor,
      _initialStatusBarIconBrightness,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollUpdateNotification) {
          _onScroll();
        }
        return false;
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 45,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Image>[
                Image.asset(
                  'assets/PICOS_Logo_RGB.png',
                  height: 75,
                ),
              ],
            ),
            const QuestionaireSection(),
            Container(
              color: theme.white,
              child: const GraphSection(),
            ),
            Container(
              color: theme.blue,
              child: const MyHealthSection(),
            ),
            const ContactSection(),
          ],
        ),
      ),
    );
  }
}
