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

import '../../../../themes/global_theme.dart';

/// Creates a standardized section for the overview.
class Section extends StatelessWidget {
  /// Section constructor.
  const Section({required this.child, Key? key, this.title, this.titleColor})
      : super(key: key);

  /// Title for the section.
  final String? title;

  /// The content for the section.
  final Widget child;

  /// The color for the title.
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              title ?? '',
              style: TextStyle(
                color: titleColor ?? theme.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            color: titleColor ?? theme.black,
            height: 1,
          ),
          const SizedBox(
            height: 20,
          ),
          child,
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
