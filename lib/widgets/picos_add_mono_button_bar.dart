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
import 'package:picos/gen_l10n/app_localizations.dart';
import '../themes/global_theme.dart';

/// Class for single add-button-bar.
class PicosAddMonoButtonBar extends StatelessWidget {
  /// Creates a single add-button-bar.
  const PicosAddMonoButtonBar({
    required this.route,
    Key? key,
  }) : super(key: key);

  /// Route for pushing a new page. Check routes.dart for available routes.
  final String route;

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
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
      ),
      child: PicosInkWellButton(
        text: AppLocalizations.of(context)!.add,
        onTap: () {
          Navigator.of(context).pushNamed(route);
        },
      ),
    );
  }
}
