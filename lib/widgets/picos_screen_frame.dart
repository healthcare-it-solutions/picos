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
import 'package:flutter/services.dart';

import '../themes/global_theme.dart';

/// Creates a standardized frame useful for most picos screens.
class PicosScreenFrame extends StatelessWidget {
  /// Creates PicosScreenFrame.
  const PicosScreenFrame({
    Key? key,
    this.bottomNavigationBar,
    this.title,
    this.appBar,
    this.body,
  }) : super(key: key);

  /// A Navigation bar displayed at the bottom.
  final Widget? bottomNavigationBar;

  /// The title of the screen.
  final String? title;

  /// An app bar to display at the top of the PicosScreenFrame.
  final PreferredSizeWidget? appBar;

  /// The content inside the frame to display.
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        color: theme.darkGreen1,
        child: Scaffold(
          bottomNavigationBar: bottomNavigationBar,
          appBar: appBar ??
              AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: theme.darkGreen1,
                  statusBarIconBrightness: Brightness.light,
                ),
                iconTheme: IconThemeData(
                  color: theme.white,
                ),
                centerTitle: true,
                title: Text(
                  title ?? '',
                  style: TextStyle(
                    color: theme.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                backgroundColor: theme.darkGreen1,
              ),
          body: body,
        ),
      ),
    );
  }
}
