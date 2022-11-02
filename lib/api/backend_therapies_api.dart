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

import 'dart:async';

import 'package:picos/api/therapies_api.dart';

import '../models/therapy.dart';
import '../util/backend.dart';

/// API for storing therapies at the backend.
class BackendTherapiesApi extends TherapiesApi {
  List<Therapy> _therapiesList = <Therapy>[];

  final StreamController<List<Therapy>> _therapiesController =
      StreamController<List<Therapy>>();

  @override
  Future<Stream<List<Therapy>>> getTherapies() async {
    try {
      List<dynamic> response = await Backend.getAll(Therapy.databaseTable);

      for (dynamic element in response) {
        _therapiesList.add(
          Therapy(
            date: DateTime.parse(element['date']['iso']),
            therapy: element['therapieText'],
            objectId: element['objectId'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
          ),
        );
      }

      return _therapiesController.stream.asBroadcastStream(
        onListen: (StreamSubscription<List<Therapy>> subscription) {
          _dispatch();
        },
      );
    } catch (e) {
      return Stream<List<Therapy>>.error(e);
    }
  }

  @override
  Future<void> saveTherapy(Therapy therapy) async {
    try {
      dynamic response = await Backend.saveObject(therapy);

      therapy = therapy.copyWith(
        objectId: response['objectId'],
        createdAt: DateTime.tryParse(response['createdAt'] ?? '') ??
            therapy.createdAt,
        updatedAt: DateTime.tryParse(response['updatedAt'] ?? '') ??
            therapy.updatedAt,
      );

      int therapyIndex = _getIndex(therapy);

      if (therapyIndex >= 0) {
        _therapiesList[therapyIndex] = therapy;
        _therapiesList = <Therapy>[..._therapiesList];
      }

      if (therapyIndex < 0) {
        _therapiesList = <Therapy>[..._therapiesList, therapy];
      }

      _dispatch();
    } catch (e) {
      return;
    }
  }

  @override
  Future<void> removeTherapy(Therapy therapy) async {
    try {
      await Backend.removeObject(therapy);

      int therapyIndex = _getIndex(therapy);

      _therapiesList.removeAt(therapyIndex);
      _therapiesList = <Therapy>[..._therapiesList];

      _dispatch();
    } catch (e) {
      return;
    }
  }

  void _dispatch() {
    _therapiesController.sink.add(_therapiesList);
  }

  int _getIndex(Therapy therapy) {
    return _therapiesList.indexWhere(
      (Therapy element) => element.objectId == therapy.objectId,
    );
  }
}
