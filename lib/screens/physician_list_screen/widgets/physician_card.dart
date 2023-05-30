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
import 'package:picos/api/backend_physicians_api.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/physician.dart';
import '../../../state/objects_list_bloc.dart';
import '../../../widgets/picos_list_card.dart';

/// The card displaying physician information.
class PhysicianCard extends StatelessWidget {
  /// Creates PhysicianCard.
  const PhysicianCard(this._physician, {Key? key}) : super(key: key);

  final Physician _physician;

  bool _hasAnyValues() {
    return (_physician.practice != '' ||
        _physician.firstName != '' ||
        _physician.lastName != '' ||
        _physician.address != '' ||
        _physician.city != '' ||
        _physician.phone != '' ||
        _physician.mail != '' ||
        _physician.homepage != '');
  }

  @override
  Widget build(BuildContext context) {
    const double fontSize = 16;
    const double padding = 2;

    return PicosListCard(
      edit: () {
        Navigator.of(context).pushNamed(
          '/physician-list-screen/add-physician',
          arguments: _physician,
        );
      },
      delete: () {
        context
            .read<ObjectsListBloc<BackendPhysiciansApi>>()
            .add(RemoveObject(_physician));
      },
      title: PhysicianSubjectAreaConverter.stringToPhysicianSubjectArea(
        _physician.subjectArea!,
      ).getLocalization(context),
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
            if (_physician.practice != '')
              Text(
                _physician.practice!,
                style: const TextStyle(fontSize: fontSize),
              ),
              const SizedBox(
                height: padding,
              ),
            if (_physician.firstName != '' && _physician.lastName != '')
              Text(
                '${_physician.firstName} ${_physician.lastName}',
                style: const TextStyle(fontSize: fontSize),
              ),
              const SizedBox(
                height: padding,
              ),
            if (_physician.firstName != '' && _physician.lastName == '')
              Text(
                '${_physician.firstName}',
                style: const TextStyle(fontSize: fontSize),
              ),
              const SizedBox(
                height: padding,
              ),
            if (_physician.firstName == '' && _physician.lastName != '')
              Text(
                '${_physician.lastName}',
                style: const TextStyle(fontSize: fontSize),
              ),
              const SizedBox(
                height: padding,
              ),
            if (_physician.address != '')
              Text(
                _physician.address!,
                style: const TextStyle(fontSize: fontSize),
              ),
              const SizedBox(
                height: padding,
              ),
            if (_physician.city != '')
              Text(
                _physician.city!,
                style: const TextStyle(fontSize: fontSize),
              ),
              const SizedBox(
                height: padding,
              ),
            if (_physician.phone != '')
              Text(
                '${AppLocalizations.of(context)!.phone} ${_physician.phone}',
                style: const TextStyle(fontSize: fontSize),
              ),
              const SizedBox(
                height: padding,
              ),
            if (_physician.mail != '')
              Text(
                _physician.mail!,
                style: const TextStyle(fontSize: fontSize),
              ),
              const SizedBox(
                height: padding,
              ),
            if (_physician.homepage != '')
              Text(
                _physician.homepage!,
                style: const TextStyle(fontSize: fontSize),
              ),
          ],
        ),
      ),
    );
  }
}
