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
import 'package:picos/widgets/picos_add_button_bar.dart';
import 'package:picos/widgets/picos_ink_well_button.dart';
import 'package:picos/gen_l10n/app_localizations.dart';

import '../themes/global_theme.dart';

/// A standardized button bar for [PageViewNavigation].
class PicosPageViewButtonBar extends StatelessWidget {
  /// Creates PicosPageViewButtonBar.
  const PicosPageViewButtonBar({
    Key? key,
    this.nextPage,
    this.previousPage,
    this.nextTitle,
    this.previousTitle,
  }) : super(key: key);

  /// Function for the next page button.
  final void Function()? nextPage;

  /// Function for the previous page button.
  final void Function()? previousPage;

  /// Defines a custom title for the next button.
  final String? nextTitle;

  /// Defines a custom title for the previous button.
  final String? previousTitle;

  static GlobalTheme? _theme;
  static String? _back;
  static String? _next;

  @override
  Widget build(BuildContext context) {
    if (_theme == null) {
      _theme = Theme.of(context).extension<GlobalTheme>()!;

      _back = AppLocalizations.of(context)!.back;
      _next = AppLocalizations.of(context)!.next;
    }

    return PicosAddButtonBar(
      leftButton: PicosInkWellButton(
        padding: const EdgeInsets.only(
          left: 30,
          right: 13,
          top: 15,
          bottom: 10,
        ),
        text: previousTitle ?? _back!,
        onTap: previousPage ?? () {},
        buttonColor1: _theme!.grey3,
        buttonColor2: _theme!.grey1,
      ),
      rightButton: PicosInkWellButton(
        padding: const EdgeInsets.only(
          right: 30,
          left: 13,
          top: 15,
          bottom: 10,
        ),
        text: nextTitle ?? _next!,
        onTap: nextPage ?? () {},
      ),
    );
  }
}
