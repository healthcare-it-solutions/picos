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
import 'package:picos/widgets/picos_list_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/relative.dart';

/// The card displaying a family member.
class RelativeCard extends StatelessWidget {
  /// Creates RelativeCard.
  const RelativeCard(this._relative, {Key? key}) : super(key: key);

  final Relative _relative;

  @override
  Widget build(BuildContext context) {
    const double fontSize = 16;
    const double padding = 2;

    return PicosListCard(
      title: _relative.type,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${_relative.firstName} ${_relative.lastName}',
              style: const TextStyle(fontSize: fontSize),
            ),
            const SizedBox(
              height: padding,
            ),
            Text(
              _relative.address,
              style: const TextStyle(fontSize: fontSize),
            ),
            const SizedBox(
              height: padding,
            ),
            Text(
              _relative.city,
              style: const TextStyle(fontSize: fontSize),
            ),
            const SizedBox(
              height: padding,
            ),
            Text(
              '${AppLocalizations.of(context)!.phone} ${_relative.phone}',
              style: const TextStyle(fontSize: fontSize),
            ),
            const SizedBox(
              height: padding,
            ),
            Text(
              _relative.mail,
              style: const TextStyle(fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}
