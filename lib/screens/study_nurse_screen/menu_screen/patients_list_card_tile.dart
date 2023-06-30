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

/// Shows the patient card tile.
class PatientsListCardTile extends StatelessWidget {
  /// Constructor for PatientCardTile where you enter a denotation and a value
  /// as argument.
  const PatientsListCardTile(this._denotation, this._value, {Key? key})
      : super(key: key);

  final String _denotation;
  final String _value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 90,
          child: Text(
            _denotation,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            _value,
            softWrap: true,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
