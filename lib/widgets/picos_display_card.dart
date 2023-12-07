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
import 'package:picos/themes/global_theme.dart';

/// Creates a card or a box for displaying any content inside of it.
class PicosDisplayCard extends StatelessWidget {
  /// PicosDisplayBox constructor.
  PicosDisplayCard({
    required this.child,
    Key? key,
    this.label,
    this.padding,
    this.backgroundColor,
  }) : super(key: key);

  /// The label of the box.
  final Widget? label;

  /// The content to be displayed.
  final Widget child;

  /// Possible custom padding.
  final EdgeInsetsGeometry? padding;

  /// The card's background color.
  final Color? backgroundColor;

  final List<Widget> _children = <Widget>[];

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    if (label != null) {
      _children.add(label!);
      _children.add(const SizedBox(height: 15));
    }

    _children.add(child);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        surfaceTintColor: theme.white,
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _children,
          ),
        ),
      ),
    );
  }
}
