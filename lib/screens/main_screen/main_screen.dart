import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/screens/questionaire_screen/questionaire_screen.dart';

import 'bottom_bar.dart';

/// This is the screen the user sees after 'login'
class MainScreen extends StatefulWidget {
  /// Constructor
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PICOS',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: <String, WidgetBuilder> {
        '/questionaire': (BuildContext context) => QuestionaireScreen()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomBar(title: 'PICOS'),
    );
  }
}
