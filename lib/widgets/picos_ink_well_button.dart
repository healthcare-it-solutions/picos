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

/// A defined button with InkWell animation.
class PicosInkWellButton extends StatelessWidget {
  /// Creates the PicosInkWellButton.
  const PicosInkWellButton({
    required this.text,
    required this.onTap,
    this.disabled = false,
    Key? key,
  }) : super(key: key);

  /// The text shown on the button.
  final String text;

  /// The function to execute on tap.
  final void Function() onTap;

  /// Disables the button.
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final BorderRadius buttonBorderRadius = BorderRadius.circular(7);
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    Color gradientColor1 = theme.green1!;
    Color gradientColor2 = theme.green2!;

    if (disabled) {
      gradientColor1 = theme.grey3!;
      gradientColor2 = theme.grey1!;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 30),
      child: Material(
        color: Colors.transparent,
        child: AbsorbPointer(
          absorbing: disabled,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: buttonBorderRadius,
              gradient: LinearGradient(
                colors: <Color>[
                  gradientColor1,
                  gradientColor2,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: buttonBorderRadius,
              child: SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
