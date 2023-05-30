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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picos/api/backend_relatives_api.dart';
import 'package:picos/widgets/picos_list_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/relative.dart';
import '../../../state/objects_list_bloc.dart';

/// The card displaying a family member.
class RelativeCard extends StatelessWidget {
  /// Creates RelativeCard.
  const RelativeCard(this._relative, {Key? key}) : super(key: key);

  final Relative _relative;

  bool _hasAnyValues() {
    return (_relative.firstName != '' ||
        _relative.lastName != '' ||
        _relative.address != '' ||
        _relative.city != '' ||
        _relative.phone != '' ||
        _relative.mail != '');
  }

  @override
  Widget build(BuildContext context) {
    const double fontSize = 16;
    const double padding = 2;

    return PicosListCard(
        edit: () {
          Navigator.of(context).pushNamed(
            '/family-member-list-screen/add-family-member',
            arguments: _relative,
          );
        },
        delete: () {
          context
              .read<ObjectsListBloc<BackendRelativesApi>>()
              .add(RemoveObject(_relative));
        },
        title: RelativeTypeConverter.stringToRelativeType(_relative.type!)
            .getLocalization(context),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (!_hasAnyValues())
                Text(
                  AppLocalizations.of(context)!.noData,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
              if (_relative.firstName != '' && _relative.lastName != '')
                Text(
                  '${_relative.firstName} ${_relative.lastName}',
                  style: const TextStyle(fontSize: fontSize),
                ),
                const SizedBox(
                  height: padding,
                ),
              if (_relative.firstName == '' && _relative.lastName != '')
                Text(
                  '${_relative.lastName}',
                  style: const TextStyle(fontSize: fontSize),
                ),
                const SizedBox(
                  height: padding,
                ),
              if (_relative.firstName != '' && _relative.lastName == '')
                Text(
                  '${_relative.firstName}',
                  style: const TextStyle(fontSize: fontSize),
                ),
                const SizedBox(
                  height: padding,
                ),
              if (_relative.address != '')
                Text(
                  _relative.address!,
                  style: const TextStyle(fontSize: fontSize),
                ),
                const SizedBox(
                  height: padding,
                ),
              if (_relative.city != '')
                Text(
                  _relative.city!,
                  style: const TextStyle(fontSize: fontSize),
                ),
                const SizedBox(
                  height: padding,
                ),
              if (_relative.phone != '')
                Text(
                  '${AppLocalizations.of(context)!.phone} ${_relative.phone}',
                  style: const TextStyle(fontSize: fontSize),
                ),
                const SizedBox(
                  height: padding,
                ),
              if (_relative.mail != '')
              Text(
                _relative.mail!,
                style: const TextStyle(fontSize: fontSize),
              ),
            ],
          ),
        ),);
  }
}
