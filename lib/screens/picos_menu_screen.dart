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
import 'package:picos/screens/family_members_screen.dart';
import 'package:picos/screens/physicians_screen.dart';

/// This is the screen a user should see when prompted to provide some
/// information about their health status.
class PicosMenu extends StatelessWidget {
  // ignore: public_member_api_docs
  const PicosMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15.0),
      children: <Widget>[
        const Text('Meine Gesundheit',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        const ListTile(
          leading: Icon(Icons.insights),
          title: Text('Werte'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        const ListTile(
          leading: Icon(Icons.medication),
          title: Text('Medikationsplan'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: const Icon(Icons.groups),
          title: const Text('BehandlerInnen'),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute<Widget>(
              builder: (BuildContext context) => const Physicians(),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.people),
          title: const Text('Angehörige'),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute<Widget>(
              builder: (BuildContext context) => const FamilyMembers(),
            ),
          ),
        ),
        const ListTile(
          leading: Icon(Icons.description),
          title: Text('Dokumente'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text('Mehr', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        const ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Benachrichtigungen'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        const ListTile(
          leading: Icon(Icons.settings),
          title: Text('Profil'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        const ListTile(
          leading: Icon(Icons.lock),
          title: Text('Datenschutzhinweise'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        const ListTile(
          leading: Icon(Icons.gavel),
          title: Text('Impressum'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        const ListTile(
          leading: Icon(Icons.logout),
          title: Text('Ausloggen'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ],
    );
  }
}
