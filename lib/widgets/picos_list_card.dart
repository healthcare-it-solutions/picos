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
import 'package:picos/gen_l10n/app_localizations.dart';

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

  Widget _createButton(
    BuildContext context,
    String label,
    Function()? onPressed,
  ) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: TextButton(
          style: _buttonStyle(theme),
          onPressed: onPressed,
          child: Text(label),
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle(GlobalTheme theme) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(theme.cardButton),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      foregroundColor: WidgetStateProperty.all(theme.grey1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        surfaceTintColor: theme.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildTitle(theme),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 23),
              child: child,
            ),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(GlobalTheme theme) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: theme.darkGreen2,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      children: <Widget>[
        if (edit != null)
          _createButton(
            context,
            AppLocalizations.of(context)!.edit,
            edit,
          ),
        if (delete != null)
          _createButton(
            context,
            AppLocalizations.of(context)!.delete,
            delete,
          ),
      ],
    );
  }
}
