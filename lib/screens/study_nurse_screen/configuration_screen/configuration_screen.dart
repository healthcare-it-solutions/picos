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

import '../../../themes/global_theme.dart';

/// Screen which contains all relevant form elements in order to
/// create a new patient.
class ConfigurationScreen extends StatelessWidget {
  /// ConfigurationScreen constructor.
  const ConfigurationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.configuration,
          style: TextStyle(
            color: theme.darkGreen2,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.white,
        leading: BackButton(color: theme.darkGreen2),
      ),
      body: Container(
        color: theme.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Icon(
                Icons.settings_applications_outlined,
                size: 100,
                color: theme.darkGreen2,
              ),
            ),
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.startConfiguration,
                style: TextStyle(
                  fontSize: 25,
                  color: theme.darkGreen2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            PicosInkWellButton(
              text: AppLocalizations.of(context)!.letsStart,
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/study-nurse-screen/configuration-pages',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
