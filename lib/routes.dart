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
import 'package:picos/screens/legals_screen.dart';
import 'package:picos/screens/my_medications_screen/add_medication_screen.dart';
import 'package:picos/screens/my_therapies_screen/add_therapy_screen.dart';
import 'package:picos/screens/my_therapies_screen/my_therapies_screen.dart';
import 'package:picos/screens/physician_list_screen/add_physician_screen.dart';
import 'package:picos/screens/family_member_list_screen/add_family_member_screen.dart';
import 'package:picos/screens/family_member_list_screen/family_members_screen.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/configuration_finished_screen.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/configuration_pages.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/configuration_screen.dart';
import 'package:picos/screens/main_screen/bottom_bar.dart';
import 'package:picos/screens/my_medications_screen/my_medications_screen.dart';
import 'package:picos/screens/overview_screen/overview_screen.dart';
import 'package:picos/screens/physician_list_screen/physicians_screen.dart';
import 'package:picos/screens/study_nurse_screen/study_nurse_screen.dart';
import 'package:picos/screens/my_therapies_screen/view_therapy_screen.dart';

///This is a central place to manage all routes contained in the app.
///Remember to put the "/" when using the routes.
class Routes {
  ///Builds the routes.
  Routes(BuildContext ctx) {
    _routes = <String, Widget Function(BuildContext)>{
      '/my-medications-screen/my-medications': (BuildContext ctx) =>
          const MyMedicationsScreen(),
      '/my-medication-screen/add-medication': (BuildContext ctx) =>
          const AddMedicationScreen(),
      '/family-member-list-screen/add-family-member': (BuildContext ctx) =>
          const AddFamilyMemberScreen(),
      '/family-member-list-screen/family-members': (BuildContext ctx) =>
          const FamilyMembersScreen(),
      '/physician-list-screen/add-physician': (BuildContext ctx) =>
          const AddPhysicianScreen(),
      '/physician-list-screen/physicians': (BuildContext ctx) =>
          const PhysiciansScreen(),
      '/main-screen/mainscreen': (BuildContext ctx) => const BottomBar(
            title: 'PICOS',
          ),
      '/study-nurse-screen/studynursescreen': (BuildContext ctx) =>
          const StudyNurseScreen(),
      '/study-nurse-screen/configuration-screen': (BuildContext ctx) =>
          const ConfigurationScreen(),
      '/study-nurse-screen/configuration-pages': (BuildContext ctx) =>
          const ConfigurationPages(),
      '/study-nurse-screen/configuration-finish-screen': (BuildContext ctx) =>
          const ConfigurationFinishedScreen(),
      '/overview-screen/overview': (BuildContext ctx) => const OverviewScreen(),
      '/my-therapy-screen/add-therapy': (BuildContext ctx) =>
          const AddTherapyScreen(),
      '/my-therapy-screen/view-therapy': (BuildContext ctx) =>
          const ViewTherapyScreen(),
      '/my-therapy-screen/my-therapy': (BuildContext ctx) =>
          const MyTherapiesScreen(),
      '/legals-screen': (BuildContext ctx) => const LegalsScreen(),
    };
  }

  late Map<String, Widget Function(BuildContext p1)> _routes;

  ///Returns all routes for the app.
  Map<String, Widget Function(BuildContext p1)> getRoutes() {
    return _routes;
  }
}
