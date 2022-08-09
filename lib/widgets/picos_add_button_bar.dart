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
    required this.formKey,
    Key? key,
  }) : super(key: key);

  /// Class variable for form key.
  final GlobalKey<FormState> formKey;

  /// When 'save'-button is pressed, this method will be triggered.
  /// After successful validation, data will be written in database.
  void addListElement(BuildContext context, GlobalKey<FormState> key) {
    if (key.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.submitData,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return Row(
      children: <Widget>[
        Expanded(
          child: PicosInkWellButton(
            text: AppLocalizations.of(context)!.abort,
            onTap: () {
              Navigator.pop(context);
            },
            buttonColor1: theme.grey3,
            buttonColor2: theme.grey1,
          ),
        ),
        Expanded(
          child: PicosInkWellButton(
            text: AppLocalizations.of(context)!.save,
            onTap: () => addListElement(context, formKey),
          ),
        ),
      ],
    );
  }
}
