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
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:picos/screens/login_screen.dart';
import 'package:picos/themes/global_theme.dart';

import 'blocs.dart';
import 'routes.dart';

/// Here the app gets initialized.
class AppConfig extends StatelessWidget {
  /// AppConfig constructor
  const AppConfig({Key? key}) : super(key: key);

  void _setSystemNavigationBarColor(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
                Theme.of(context).canvasColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _setSystemNavigationBarColor(context);
    const GlobalTheme theme = GlobalTheme();

    return Blocs(
      child: MaterialApp(
        title: 'PICOS',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                secondary: theme.grey3,
              ),
          textSelectionTheme: Theme.of(context).textSelectionTheme.copyWith(
                selectionColor: theme.grey2,
                selectionHandleColor: theme.grey1,
              ),
          appBarTheme: AppBarTheme(
            backgroundColor: theme.darkGreen1,
          ),
          dialogBackgroundColor: theme.darkGreen2,
          focusColor: theme.darkGreen3,
          shadowColor: theme.grey2,
          inputDecorationTheme: InputDecorationTheme(
            floatingLabelStyle: TextStyle(color: theme.darkGreen3),
          ),
        ).copyWith(
          extensions: <ThemeExtension<dynamic>>{
            theme,
          },
        ),
        home: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: const LoginScreen(),
        ),
        routes: Routes(context).getRoutes(),
      ),
    );
  }
}
