/*   This file is part of Picos, a health trcking mobile app
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
import 'package:picos/screens/add_medication_screen/add_medication_screen.dart';
import 'package:picos/screens/my_medications_screen/my_medications_screen.dart';
import 'package:picos/states/medications_list_bloc.dart';

import '../../api/local_storage_medications_api.dart';

import 'bottom_bar.dart';

/// This is the screen which contains all relevant informations
class MainScreen extends StatelessWidget {
  // ignore: public_member_api_docs
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MedicationsRepository medicationsRepository =
    MedicationsRepository(medicationsApi: LocalStorageMedicationsApi());

    return MultiRepositoryProvider(
      providers: <RepositoryProvider<MedicationsRepository>>[
        RepositoryProvider<MedicationsRepository>.value(
          value: medicationsRepository,
        )
      ],
      child: MultiBlocProvider(
        providers: <BlocProvider<MedicationsListBloc>>[
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
              primaryColor: Colors.blue,
              primarySwatch: Colors.blue,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.blue,
              ),
              backgroundColor: const Color(0xFFF2F2F2),
              scaffoldBackgroundColor: const Color(0xFFF2F2F2),
              shadowColor: Colors.grey,
              textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
            ),
            home: const BottomBar(title: 'PICOS'),
            routes: <String, Widget Function(BuildContext)>{
              '/my-medications': (BuildContext ctx) =>
              const MyMedicationsScreen(),
              '/add-medication': (BuildContext ctx) =>
              const AddMedicationScreen()
            }),
      ),
    );
  }
}
