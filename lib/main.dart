// ignore_for_file: public_member_api_docs

/*
Copyright 2022 by Mustafa Sezer <mustafa.sezer@hit-solutions.de>

This file is part of picos.

picos is free software: you can redistribute it and/or modify it under the
terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

picos is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
details.

You should have received a copy of the GNU General Public License along
with picos. If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/repository/medications_repository.dart';
import 'package:picos/screens/add_medication_screen/add_medication_screen.dart';
import 'package:picos/screens/my_medications_screen/my_medications_screen.dart';
import 'package:picos/states/medications_list_bloc.dart';

import 'api/local_storage_medications_api.dart';

/// This is the main entry point of the application.
void main() {
  runApp(const MainAppScreen());
}

/// The main application screen as a stateful widget will be created here.
class MainAppScreen extends StatefulWidget {
  const MainAppScreen({Key? key}) : super(key: key);

  @override
  State<MainAppScreen> createState() => MainAppScreenState();
}

/// This class builds the application with its certain properties.
class MainAppScreenState extends State<MainAppScreen> {
  final MedicationsRepository medicationsRepository =
      MedicationsRepository(medicationsApi: LocalStorageMedicationsApi());

  @override
  Widget build(BuildContext context) {
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
            home: const MyHomePage(title: 'PICOS'),
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

/// This widget is the home page of your application. It is stateful, meaning
/// that it has a State object (defined below) that contains fields that affect
/// how it looks.

/// This class is the configuration for the state. It holds the values (in this
/// case the title) provided by the parent (in this case the App widget) and
/// used by the build method of the State. Fields in a Widget subclass are
/// always marked "final".
class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => MainAppClass();
}

void pushScreen(String screen, BuildContext ctx) {
  Navigator.of(ctx).pushNamed(screen);
}

/// This is a list of Widgets to build the pages.
List<Widget> createHomeScreenWidgets(BuildContext ctx) {
  return <Widget>[
    const Icon(
      Icons.house,
      size: 150,
    ),
    const Icon(
      Icons.mail,
      size: 150,
    ),
    const Icon(
      Icons.calendar_month,
      size: 150,
    ),
    SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: IconButton(
        onPressed: () => Navigator.of(ctx).pushNamed('/my-medications'),
        icon: const Icon(
          Icons.bubble_chart,
          size: 150,
        ),
      ),
    ),
  ];
}

/// This class contains all relevant Widgets for the UI.
/// The needed variables and functions/methods are also implemented here.
class MainAppClass extends State<MyHomePage> {
  // Variable to store the value of the currently clicked navbar-item.
  int selectedIndex = 0;

  /// Assignment of index to selectedIndex
  /// in order to show the corresponding page.
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  /// returns the Scaffold containing all UI-widgets.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: createHomeScreenWidgets(context).elementAt(selectedIndex),
      ),
      backgroundColor: Colors.grey,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.house_outlined,
              color: Colors.black,
            ),
            label: Text(AppLocalizations.of(context)!.overview).data,
          ),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.mail_outline,
                color: Colors.black,
              ),
              label: Text(AppLocalizations.of(context)!.inbox).data),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.calendar_month_outlined,
                color: Colors.black,
              ),
              label: Text(AppLocalizations.of(context)!.calendar).data),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.black,
              ),
              label: Text(AppLocalizations.of(context)!.myPicos).data),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
