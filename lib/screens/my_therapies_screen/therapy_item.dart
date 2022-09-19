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

import '../../models/therapy.dart';

/// Displays a therapy item.
class TherapyItem extends StatelessWidget {
  /// Creates TherapyItem.
  const TherapyItem(
    this._therapy, {
    Key? key,
  }) : super(key: key);

  final Therapy _therapy;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_therapy.date.toIso8601String()),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () {
        Navigator.of(context)
            .pushNamed('/add-therapy', arguments: _therapy);
      },
    );
  }
}
