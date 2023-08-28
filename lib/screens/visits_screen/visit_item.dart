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
import 'package:picos/models/stay.dart';

/// Displays a visit item.
class VisitItem extends StatelessWidget {
  /// Creates VisitItem.
  const VisitItem(
    this._stay, {
    Key? key,
  }) : super(key: key);

  final Stay _stay;

  /// Checks whether 'where' is 'hospital'
  bool isHospital() {
    return _stay.where.toLowerCase() == 'hospital';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: isHospital() ? Text(
        'Anfangszeit: ${_stay.record.day}.${_stay.record.month}.'
        '${_stay.record.year} - Endzeit: ${_stay.record.day}.'
        '${_stay.record.month}.${_stay.record.year} - ${_stay.where}',
      ) : Text('Besuchsdatum: ${_stay.record.day}.${_stay.record.month}.'
        '${_stay.record.year} - ${_stay.where}'),
    );
  }
}
