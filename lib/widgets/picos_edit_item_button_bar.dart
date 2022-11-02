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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../themes/global_theme.dart';

/// Class for adding a button bar for item edits.
class PicosEditItemButtonBar extends StatelessWidget {
  /// Creates an PicosEditItemButtonBar.
  const PicosEditItemButtonBar({
    this.onTapLeft,
    this.onTapRight,
    Key? key,
  }) : super(key: key);

  /// Function to execute when left button is tapped.
  final Function()? onTapLeft;

  /// Function to execute when right button is tapped.
  final Function()? onTapRight;

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return PicosAddButtonBar(
      leftButton: PicosInkWellButton(
        padding: const EdgeInsets.only(
          left: 30,
          right: 13,
          top: 15,
          bottom: 10,
        ),
        text: AppLocalizations.of(context)!.edit,
        onTap: onTapLeft ?? () {},
      ),
      rightButton: PicosInkWellButton(
        padding: const EdgeInsets.only(
          right: 30,
          left: 13,
          top: 15,
          bottom: 10,
        ),
        text: AppLocalizations.of(context)!.delete,
        onTap: onTapRight ?? () {},
        buttonColor1: theme.grey3,
        buttonColor2: theme.grey1,
      ),
    );
  }
}
