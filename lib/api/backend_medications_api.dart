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

import 'package:picos/api/medications_api.dart';
import 'package:picos/models/medication.dart';

import '../util/backend.dart';

/// API for storing medications at the backend.
class BackendMedicationsApi extends MedicationsApi {
  List<Medication> _medicationsList = <Medication>[];

  final StreamController<List<Medication>> _medicationsController =
      StreamController<List<Medication>>();

  @override
  Future<Stream<List<Medication>>> getMedications() async {
    try {
      List<dynamic> response = await Backend.getAll(Medication.databaseTable);

      for (dynamic element in response) {
        _medicationsList.add(
          Medication(
            compound: element['MedicalProduct'],
            morning: element['Morning'].toDouble(),
            noon: element['Noon'].toDouble(),
            evening: element['Evening'].toDouble(),
            night: element['AtNight'].toDouble(),
            objectId: element['objectId'],
            createdAt: DateTime.parse(element['createdAt']),
            updatedAt: DateTime.parse(element['updatedAt']),
          ),
        );
      }

      return _medicationsController.stream.asBroadcastStream(
        onListen: (StreamSubscription<List<Medication>> subscription) {
          _dispatch();
        },
      );
    } catch (e) {
      return Stream<List<Medication>>.error(e);
    }
  }

  @override
  Future<void> saveMedication(Medication medication) async {
    try {
      dynamic response = await Backend.saveObject(medication);

      medication = medication.copyWith(
        objectId: response['objectId'],
        createdAt: DateTime.tryParse(response['createdAt'] ?? '') ??
            medication.createdAt,
        updatedAt: DateTime.tryParse(response['updatedAt'] ?? '') ??
            medication.updatedAt,
      );

      int medicationIndex = _getIndex(medication);

      if (medicationIndex >= 0) {
        _medicationsList[medicationIndex] = medication;
        _medicationsList = <Medication>[..._medicationsList];
      }

      if (medicationIndex < 0) {
        _medicationsList = <Medication>[..._medicationsList, medication];
      }

      _dispatch();
    } catch (e) {
      return;
    }
  }

  @override
  Future<void> removeMedication(Medication medication) async {
    try {
      await Backend.removeObject(medication);

      int medicationIndex = _getIndex(medication);

      _medicationsList.removeAt(medicationIndex);
      _medicationsList = <Medication>[..._medicationsList];

      _dispatch();
    } catch (e) {
      return;
    }
  }

  void _dispatch() {
    _medicationsController.sink.add(_medicationsList);
  }

  int _getIndex(Medication medication) {
    return _medicationsList.indexWhere(
      (Medication element) => element.objectId == medication.objectId,
    );
  }
}
