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

/// A text widget that automatically applies ellipsis overflow handling
/// and wraps the text in a [Flexible] widget to prevent layout issues.
class PicosOverflowText extends StatelessWidget {
  /// Creates a [PicosOverflowText] widget.
  ///
  /// The [text] parameter must not be null.
  const PicosOverflowText({
    required this.text,
    Key? key,
    this.style,
  }) : super(key: key);

  /// The text to display.
  final String text;

  /// The style to apply to the text.
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        text,
        style: style,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
