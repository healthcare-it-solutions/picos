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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Class for Buttons wihin ListCard.
class PicosListCardButtons extends StatelessWidget {
  /// Constructor for Buttons within ListCard.
  const PicosListCardButtons(
      {required this.edit, required this.delete, Key? key,})
      : super(key: key);

  /// Function to edit the card.
  final Function()? edit;

  /// Function to delete the card.
  final Function()? delete;

  @override
  Widget build(BuildContext context) {
    final BorderRadius buttonBorderRadius = BorderRadius.circular(5);

    return Row(
      children: <Expanded>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 0,
              left: 20,
              right: 10,
            ),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).extension<GlobalTheme>()!.cardButton,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: buttonBorderRadius,
                  ),
                ),
                foregroundColor: MaterialStateProperty.all(
                  Theme.of(context).extension<GlobalTheme>()!.grey1,
                ),
              ),
              onPressed: edit,
              child: Text(AppLocalizations.of(context)!.edit),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 0,
              left: 10,
              right: 20,
            ),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).extension<GlobalTheme>()!.cardButton,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: buttonBorderRadius,
                  ),
                ),
                foregroundColor: MaterialStateProperty.all(
                  Theme.of(context).extension<GlobalTheme>()!.grey1,
                ),
              ),
              onPressed: delete,
              child: Text(AppLocalizations.of(context)!.delete),
            ),
          ),
        ),
      ],
    );
  }
}
