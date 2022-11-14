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
import 'package:picos/widgets/picos_ink_well_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../themes/global_theme.dart';

/// Class for the Add-Button.
class PicosAddButtonBar extends StatelessWidget {
  /// Creates an App-Button-Bar.
  const PicosAddButtonBar({
    this.onTap,
    this.disabled = false,
    this.leftButton,
    this.rightButton,
    this.shadows = true,
    Key? key,
  }) : super(key: key);

  /// Function to execute when tapped.
  final Function()? onTap;

  /// Whether the button to save is disabled or not.
  final bool disabled;

  /// For custom button replacement of the left button.
  final PicosInkWellButton? leftButton;

  /// For custom button replacement of the right button.
  final PicosInkWellButton? rightButton;

  /// Determines if the elevation shadows should be casted or not.
  final bool shadows;

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return Container(
      decoration: shadows == true ? BoxDecoration(
        color: theme.bottomNavigationBar,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 5,
            offset: const Offset(0, -4),
          ),
          BoxShadow(
            color: theme.bottomNavigationBar!,
            offset: const Offset(-10, 0),
          ),
          BoxShadow(
            color: theme.bottomNavigationBar!,
            offset: const Offset(10, 0),
          ),
        ],
      ) : null,
      child: Row(
        children: <Widget>[
          Expanded(
            child: leftButton ?? PicosInkWellButton(
              padding: const EdgeInsets.only(
                left: 30,
                right: 13,
                top: 15,
                bottom: 10,
              ),
              text: AppLocalizations.of(context)!.abort,
              onTap: () {
                Navigator.pop(context);
              },
              buttonColor1: theme.grey3,
              buttonColor2: theme.grey1,
            ),
          ),
          Expanded(
            child: rightButton ?? PicosInkWellButton(
              padding: const EdgeInsets.only(
                right: 30,
                left: 13,
                top: 15,
                bottom: 10,
              ),
              text: AppLocalizations.of(context)!.save,
              onTap: onTap ?? () {},
              disabled: disabled,
            ),
          ),
        ],
      ),
    );
  }
}
