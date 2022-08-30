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

/// The global theme providing with theme data.
///
/// It is possible to abstract this class if we would add more themes.
@immutable
class GlobalTheme extends ThemeExtension<GlobalTheme> {
  /// Creates global theme.
  const GlobalTheme({
    this.darkGreen1 = const Color(0xFF197888),
    this.darkGreen2 = const Color(0xFF4a8a96),
    this.darkGreen3 = const Color(0xFF0f5868),
    this.white = const Color(0xFFe8f1f3),
    this.blue = const Color(0xFF236fa8),
    this.green1 = const Color(0xFF95c11f),
    this.green2 = const Color(0xFF6eab27),
    this.grey1 = const Color(0xFF5f7383),
    this.grey2 = const Color(0xFFbfc7cd),
    this.grey3 = const Color(0xFF8796a2),
    this.bottomNavigationBar = const Color(0xF8F8F8F8),
    this.cardButton = const Color(0xFFe4edef),
  });

  /// Standard: #197888
  final Color? darkGreen1;

  /// Standard: #4a8a96
  final Color? darkGreen2;

  /// Standard: #0f5868
  final Color? darkGreen3;

  /// Standard: #e8f1f3
  final Color? white;

  /// Standard: #236fa8
  final Color? blue;

  /// Standard: #95c11f
  final Color? green1;

  /// Standard: #6eab27
  final Color? green2;

  /// Standard: #5f7383
  final Color? grey1;

  /// Standard: #bfc7cd
  final Color? grey2;

  /// Standard: #8796a2
  final Color? grey3;

  /// Standard: 0xFFF2F2F2, blends well with Android bottom navigation menu.
  /// Open for debate.
  final Color? bottomNavigationBar;

  /// Color used in the mockup for delete and edit buttons.
  final Color? cardButton;

  @override
  GlobalTheme copyWith({
    Color? darkGreen1,
    Color? darkGreen2,
    Color? darkGreen3,
    Color? white,
    Color? blue,
    Color? green1,
    Color? green2,
    Color? grey1,
    Color? grey2,
    Color? grey3,
    Color? bottomNavigationBar,
    Color? cardButton,
  }) {
    return GlobalTheme(
      darkGreen1: darkGreen1 ?? this.darkGreen1,
      darkGreen2: darkGreen2 ?? this.darkGreen2,
      darkGreen3: darkGreen3 ?? this.darkGreen3,
      white: white ?? this.white,
      blue: blue ?? this.blue,
      green1: green1 ?? this.green1,
      green2: green2 ?? this.green2,
      grey1: grey1 ?? this.grey1,
      grey2: grey2 ?? this.grey2,
      grey3: grey3 ?? this.grey3,
      bottomNavigationBar: bottomNavigationBar ?? this.bottomNavigationBar,
      cardButton: cardButton ?? this.cardButton,
    );
  }

  @override
  GlobalTheme lerp(
    ThemeExtension<GlobalTheme>? other,
    double t,
  ) {
    if (other is! GlobalTheme) {
      return this;
    }

    return GlobalTheme(
      darkGreen1: Color.lerp(darkGreen1, other.darkGreen1, t),
      darkGreen2: Color.lerp(darkGreen2, other.darkGreen2, t),
      darkGreen3: Color.lerp(darkGreen3, other.darkGreen3, t),
      white: Color.lerp(white, other.white, t),
      blue: Color.lerp(blue, other.blue, t),
      green1: Color.lerp(green1, other.green1, t),
      green2: Color.lerp(green2, other.green2, t),
      grey1: Color.lerp(grey1, other.grey1, t),
      grey2: Color.lerp(grey2, other.grey2, t),
      grey3: Color.lerp(grey3, other.grey3, t),
      bottomNavigationBar: Color.lerp(
        bottomNavigationBar,
        other.bottomNavigationBar,
        t,
      ),
      cardButton: Color.lerp(cardButton, other.cardButton, t),
    );
  }
}
