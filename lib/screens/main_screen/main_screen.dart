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
import 'package:picos/api/backend_medications_api.dart';
import 'package:picos/api/backend_patient_api.dart';
import 'package:picos/api/backend_patient_data_api.dart';
import 'package:picos/api/backend_patient_profile_api.dart';
import 'package:picos/api/backend_physicians_api.dart';
import 'package:picos/api/backend_relatives_api.dart';
import 'package:picos/api/backend_stays_api.dart';
import 'package:picos/api/backend_therapies_api.dart';
import 'package:picos/api/database_object_api.dart';
import 'package:picos/screens/login_screen.dart';
import 'package:picos/themes/global_theme.dart';

import '../../routes.dart';
import '../../state/objects_list_bloc.dart';

/// This is the screen which contains all relevant information
class MainScreen extends StatelessWidget {
  /// MainScreen constructor
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const GlobalTheme theme = GlobalTheme();

    return MultiBlocProvider(
      providers: <BlocProvider<ObjectsListBloc<DatabaseObjectApi>>>[
        BlocProvider<ObjectsListBloc<BackendMedicationsApi>>(
          create: (BuildContext context) =>
              ObjectsListBloc<BackendMedicationsApi>(
            BackendMedicationsApi(),
          )..add(const ObjectsListSubscriptionRequested()),
        ),
        BlocProvider<ObjectsListBloc<BackendPatientApi>>(
          create: (BuildContext context) =>
              ObjectsListBloc<BackendPatientApi>(
            BackendPatientApi(),
          )..add(const ObjectsListSubscriptionRequested()),
        ),
        BlocProvider<ObjectsListBloc<BackendPatientDataApi>>(
          create: (BuildContext context) =>
              ObjectsListBloc<BackendPatientDataApi>(
            BackendPatientDataApi(),
          )..add(const ObjectsListSubscriptionRequested()),
        ),
        BlocProvider<ObjectsListBloc<BackendPatientProfileApi>>(
          create: (BuildContext context) =>
              ObjectsListBloc<BackendPatientProfileApi>(
            BackendPatientProfileApi(),
          )..add(const ObjectsListSubscriptionRequested()),
        ),
        BlocProvider<ObjectsListBloc<BackendTherapiesApi>>(
          create: (BuildContext context) =>
              ObjectsListBloc<BackendTherapiesApi>(
            BackendTherapiesApi(),
          )..add(const ObjectsListSubscriptionRequested()),
        ),
        BlocProvider<ObjectsListBloc<BackendStaysApi>>(
          create: (BuildContext context) =>
          ObjectsListBloc<BackendStaysApi>(
            BackendStaysApi(),
          )..add(const ObjectsListSubscriptionRequested()),
        ),
        BlocProvider<ObjectsListBloc<BackendPhysiciansApi>>(
          create: (BuildContext context) =>
          ObjectsListBloc<BackendPhysiciansApi>(
            BackendPhysiciansApi(),
          )..add(const ObjectsListSubscriptionRequested()),
        ),
        BlocProvider<ObjectsListBloc<BackendRelativesApi>>(
          create: (BuildContext context) =>
          ObjectsListBloc<BackendRelativesApi>(
            BackendRelativesApi(),
          )..add(const ObjectsListSubscriptionRequested()),
        ),
      ],
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
        ).copyWith(
          extensions: <ThemeExtension<dynamic>>{
            theme,
          },
        ),
        home: const LoginScreen(),
        routes: Routes(context).getRoutes(),
      ),
    );
  }
}
