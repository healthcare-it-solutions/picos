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
import 'package:picos/screens/study_nurse_screen/menu_screen/widgets/patients_list.dart';
import 'package:picos/widgets/picos_add_mono_button_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picos/widgets/picos_screen_frame.dart';

import '../../../api/backend_patients_list_api.dart';
import '../../../state/objects_list_bloc.dart';
import '../../../util/backend.dart';

/// Shows a list with all patients.
class MenuMainScreen extends StatefulWidget {
  /// Creates MenuMainScreen.
  const MenuMainScreen({Key? key}) : super(key: key);

  @override
  State<MenuMainScreen> createState() => _MenuMainScreenState();
}

class _MenuMainScreenState extends State<MenuMainScreen> {
  @override
  void initState() {
    super.initState();
    _refreshPatientsList();
  }

  void _refreshPatientsList() {
    context.read<ObjectsListBloc<BackendPatientsListApi>>().add(
          const LoadObjectsList(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return PicosScreenFrame(
      title: AppLocalizations.of(context)!.myPatients,
      body: const PatientsList(),
      bottomNavigationBar: const PicosAddMonoButtonBar(
        route: '/study-nurse-screen/configuration-screen',
      ),
      leading: IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: _refreshPatientsList,
        tooltip: 'Refresh',
      ),
      appBarActions: <Widget>[
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            if (await Backend.logout() && context.mounted) {
              Navigator.of(context).pushReplacementNamed('/login-screen');
            }
          },
          tooltip: AppLocalizations.of(context)!.logout,
        ),
      ],
    );
  }
}
