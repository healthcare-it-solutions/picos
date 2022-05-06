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

/// This is the screen a user should see when prompted to provide some
/// information about their health status.
class PicosMenu extends StatelessWidget {
  // ignore: public_member_api_docs
  const PicosMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15.0),
      children: const <Widget>[
        Text(
          'PLACEHOLDER',
          style: TextStyle(
            fontWeight: FontWeight.bold
          )
        ),
        SizedBox(height: 20),
        ListTile(
          leading: Icon(Icons.insights),
          title: Text('Sun'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.medication),
          title: Text('Moon'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.groups),
          title: Text('Star'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.people),
          title: Text('Star'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.description),
          title: Text('Star'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        SizedBox(height: 20,),
        Text(
          'PLACEHOLDER',
          style: TextStyle(
            fontWeight: FontWeight.bold
          )
        ),
        SizedBox(height: 20),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Sun'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Moon'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.lock),
          title: Text('Star'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.gavel),
          title: Text('Star'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Star'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ],
    );
  }
}
