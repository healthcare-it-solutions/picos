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

import '../../../themes/global_theme.dart';

/// Creates a light blue form button.
class DocumentButton extends StatelessWidget {
  /// DocumentButton constructor.
  const DocumentButton({this.buttonTitle, Key? key, this.onPressed})
      : super(key: key);

  /// The shown title of the button.
  final String? buttonTitle;

  /// The action happening when pressing the button.
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: onPressed ?? () {},
        style: TextButton.styleFrom(
          backgroundColor: theme.cardButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        child: SizedBox(
          height: 32,
          width: double.infinity,
          child: Center(
            child: Text(
              buttonTitle ?? '',
              style: TextStyle(color: theme.grey1),
            ),
          ),
        ),
      ),
    );
  }
}
