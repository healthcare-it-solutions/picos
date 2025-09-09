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
import 'package:picos/widgets/picos_display_card.dart';

/// Displays an info card. [infoText] overrides [simpleInfoText].
class PicosInfoCard extends StatelessWidget {
  /// PicosInfoCard constructor.
  const PicosInfoCard({
    this.infoText,
    Key? key,
    this.simpleInfoText,
  }) : super(key: key);

  /// Use this if you just want to display an simple info.
  final String? simpleInfoText;

  /// The text to be displayed.
  final Widget? infoText;

  /// The color to be grabbed for the font.
  static const Color infoTextFontColor = Colors.white;

  /// The size to be grabbed for the font.
  static const double infoTextFontSize = 20;

  @override
  Widget build(BuildContext context) {
    Widget info = const Text('');

    if (simpleInfoText != null) {
      info = Text(
        simpleInfoText!,
        style: const TextStyle(
          color: infoTextFontColor,
          fontSize: infoTextFontSize,
        ),
      );
    }

    if (infoText != null) {
      info = Flexible(child: infoText!);
    }

    return PicosDisplayCard(
      backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(
              right: 15,
            ),
            child: Icon(Icons.info, color: infoTextFontColor),
          ),
          info,
        ],
      ),
    );
  }
}
