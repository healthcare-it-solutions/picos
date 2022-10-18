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

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picos/repository/medications_repository.dart';
import 'package:picos/screens/login_screen.dart';
import 'package:picos/state/medications_list_bloc.dart';
import 'package:picos/themes/global_theme.dart';

import '../../api/backend_medications_api.dart';

import '../../routes.dart';

/// This is the screen which contains all relevant information
class MainScreen extends StatelessWidget {
  /// MainScreen constructor
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const GlobalTheme theme = GlobalTheme();

    final MedicationsRepository medicationsRepository =
        MedicationsRepository(medicationsApi: BackendMedicationsApi());

    return MultiRepositoryProvider(
      providers: <RepositoryProvider<MedicationsRepository>>[
        RepositoryProvider<MedicationsRepository>.value(
          value: medicationsRepository,
        )
      ],
      child: MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<MedicationsListBloc>(
            create: (BuildContext context) => MedicationsListBloc(
              medicationsRepository: context.read<MedicationsRepository>(),
            )..add(const MedicationsListSubscriptionRequested()),
          ),
        ],
        child: MaterialApp(
          title: 'PICOS',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: theme.darkGreen1,
            ),
            dialogBackgroundColor: theme.darkGreen2,
            focusColor: theme.darkGreen3,
            shadowColor: theme.grey2,
          ).copyWith(
            extensions: <ThemeExtension<dynamic>>{
              theme,
            },
          ),
          home: const LoginScreen(),
          routes: Routes(context).getRoutes(),
        ),
      ),
    );
  }
}
