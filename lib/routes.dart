import 'package:flutter/cupertino.dart';
import 'package:picos/screens/add_medication_screen/add_medication_screen.dart';
import 'package:picos/screens/my_medications_screen/my_medications_screen.dart';

///This is a central place to manage all routes contained in the app.
class Routes {
  ///Builds the routes.
  Routes(BuildContext ctx) {
    _routes = <String, Widget Function(BuildContext)>{
      '/my-medications': (BuildContext ctx) => const MyMedicationsScreen(),
      '/add-medication': (BuildContext ctx) => const AddMedicationScreen(),
    };
  }

  late Map<String, Widget Function(BuildContext p1)> _routes;

  ///Returns all routes for the app.
  Map<String, Widget Function(BuildContext p1)> getRoutes() {
    return _routes;
  }
}
