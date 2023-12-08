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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../themes/global_theme.dart';

/// Card item for displaying in a list.
class PicosListCard extends StatelessWidget {
  /// Creates a card.
  const PicosListCard({
    required this.title,
    required this.child,
    this.edit,
    this.delete,
    Key? key,
  }) : super(key: key);

  /// Function to edit the card.
  final Function()? edit;

  /// Function to delete the card.
  final Function()? delete;

  /// Title shown on the card.
  final String title;

  /// The content displayed inside the card.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(10);
    final BorderRadius buttonBorderRadius = BorderRadius.circular(5);

    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
      child: Card(
        surfaceTintColor: theme.white,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                color: Theme.of(context).extension<GlobalTheme>()!.darkGreen2,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 23),
              child: child,
            ),
            Row(
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
                          Theme.of(context)
                              .extension<GlobalTheme>()!
                              .cardButton,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
