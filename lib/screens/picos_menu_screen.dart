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

/// This is the screen a user should see when prompted to provide some
/// information about their health status.
class PicosMenu extends StatelessWidget {
  /// PicosMenu constructor
  const PicosMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15.0),
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.myHealth,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ListTile(
          leading: const Icon(Icons.medication),
          title: Text(AppLocalizations.of(context)!.medicationScheme),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () => Navigator.of(context)
              .pushNamed('/my-medications-screen/my-medications'),
        ),
        ListTile(
          leading: const Icon(Icons.add_circle_outline),
          title: Text(AppLocalizations.of(context)!.therapy),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () =>
              Navigator.of(context).pushNamed('/my-therapy-screen/my-therapy'),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          AppLocalizations.of(context)!.more,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ListTile(
          leading: const Icon(Icons.gavel),
          title: Text(AppLocalizations.of(context)!.legals),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () => Navigator.of(context).pushNamed('/legals-screen'),
        ),
      ],
    );
  }
}
