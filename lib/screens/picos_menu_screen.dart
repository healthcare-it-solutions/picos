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
      children: const <Widget>[
        Text('PLACEHOLDER'),
        ListTile(
          leading: Icon(Icons.wb_sunny),
          title: Text('Sun'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.brightness_3),
          title: Text('Moon'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text('Star'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        Text('PLACEHOLDER'),
        ListTile(
          leading: Icon(Icons.wb_sunny),
          title: Text('Sun'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.brightness_3),
          title: Text('Moon'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text('Star'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ],
    );
  }
}
