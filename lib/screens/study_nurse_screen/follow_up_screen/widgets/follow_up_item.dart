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
import 'package:picos/models/follow_up.dart';

/// Displays a follow up item.
class FollowUpItem extends StatelessWidget {
  /// Creates FollowUpItem.
  const FollowUpItem(
    this._followUp, {
    Key? key,
  }) : super(key: key);

  final FollowUp _followUp;

  @override
  Widget build(BuildContext context) {
    const double sidePadding = 15;
    return Card(
      margin: const EdgeInsets.all(sidePadding),
      child: ListTile(
        title: Text('V${_followUp.number}'),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.of(context).pushNamed(
            '/follow_up_screen/edit_follow_up_screen',
            arguments: _followUp,
          );
        },
      ),
    );
  }
}
