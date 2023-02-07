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

import '../../../themes/global_theme.dart';
import '../../../widgets/picos_add_button_bar.dart';
import '../../../widgets/picos_body.dart';
import '../../../widgets/picos_ink_well_button.dart';

/// Shows a single page for the questionaire.
class QuestionairePage extends StatelessWidget {
  /// Creates QuestionairePage.
  const QuestionairePage({
    required this.child,
    Key? key,
    this.backFunction,
    this.nextFunction,
  }) : super(key: key);

  /// The body of the page.
  final Widget child;

  /// Function for getting a page back.
  final void Function()? backFunction;

  /// Function for getting the next page.
  final void Function()? nextFunction;

  @override
  Widget build(BuildContext context) {
    final String back = AppLocalizations.of(context)!.back;
    final String next = AppLocalizations.of(context)!.next;
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: PicosBody(
            child: child,
          ),
        ),
        PicosAddButtonBar(
          leftButton: PicosInkWellButton(
            padding: const EdgeInsets.only(
              left: 30,
              right: 13,
              top: 15,
              bottom: 10,
            ),
            text: back,
            onTap: backFunction ?? () {},
            buttonColor1: theme.grey3,
            buttonColor2: theme.grey1,
          ),
          rightButton: PicosInkWellButton(
            padding: const EdgeInsets.only(
              right: 30,
              left: 13,
              top: 15,
              bottom: 10,
            ),
            text: next,
            onTap: nextFunction ?? () {},
          ),
        )
      ],
    );
  }
}
