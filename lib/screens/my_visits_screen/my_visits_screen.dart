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
import 'package:picos/screens/my_visits_screen/widgets/visits_list.dart';
import 'package:picos/widgets/picos_add_mono_button_bar.dart';
import 'package:picos/widgets/picos_screen_frame.dart';

/// Shows a list with all personal therapies.
class MyVisitsScreen extends StatelessWidget {
  /// Creates MyTherapiesScreen
  const MyVisitsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PicosScreenFrame(
      body: const Padding(
        padding: EdgeInsets.only(top: 5),
        child: VisitsList(),
      ),
      bottomNavigationBar: const PicosAddMonoButtonBar(
        route: '/visits-screen/add-visit',
      ),
      title: AppLocalizations.of(context)!.myVisits,
    );
  }
}
