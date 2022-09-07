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

import 'package:flutter/cupertino.dart';
import 'package:picos/screens/add_family_member_screen.dart';
import 'package:picos/screens/add_medication_screen/add_medication_screen.dart';
import 'package:picos/screens/add_physician_screen.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/configuration_finished_screen.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/configuration_pages.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/configuration_screen.dart';
import 'package:picos/screens/family_members_screen.dart';
import 'package:picos/screens/main_screen/bottom_bar.dart';
import 'package:picos/screens/my_medications_screen/my_medications_screen.dart';
import 'package:picos/screens/overview_screen/overview_screen.dart';
import 'package:picos/screens/physicians_screen.dart';
import 'package:picos/screens/study_nurse_screen/study_nurse_screen.dart';

///This is a central place to manage all routes contained in the app.
///Remember to put the "/" when using the routes.
class Routes {
  ///Builds the routes.
  Routes(BuildContext ctx) {
    _routes = <String, Widget Function(BuildContext)>{
      '/my-medications': (BuildContext ctx) => const MyMedicationsScreen(),
      '/add-medication': (BuildContext ctx) => const AddMedicationScreen(),
      '/add-family-member': (BuildContext ctx) => const AddFamilyMemberScreen(),
      '/add-physician': (BuildContext ctx) => const AddPhysicianScreen(),
      '/physicians': (BuildContext ctx) => const PhysiciansScreen(),
      '/family-members': (BuildContext ctx) => const FamilyMembersScreen(),
      '/mainscreen': (BuildContext ctx) => const BottomBar(title: 'PICOS',),
      '/studynursescreen': (BuildContext ctx) => const StudyNurseScreen(),
      '/configuration-screen': (BuildContext ctx) => const ConfigurationScreen(),
      '/configuration-pages': (BuildContext ctx) => const ConfigurationPages(),
      '/configuration-finish-screen': (BuildContext ctx) => const ConfigurationFinishedScreen(),
      '/overview': (BuildContext ctx) => const OverviewScreen(),
    };
  }

  late Map<String, Widget Function(BuildContext p1)> _routes;

  ///Returns all routes for the app.
  Map<String, Widget Function(BuildContext p1)> getRoutes() {
    return _routes;
  }
}
