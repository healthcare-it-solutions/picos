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

// ignore_for_file: file_names

import 'dart:async';

import 'package:picos/api/medications_api.dart';
import 'package:picos/models/medication.dart';

/// API for storing medications at local storage. Currently a placeholder.
class LocalStorageMedicationsApi extends MedicationsApi {
  List<Medication> _medicationsList = <Medication>[];

  final StreamController<List<Medication>> _medicationsController =
      StreamController<List<Medication>>();

  @override
  Stream<List<Medication>> getMedications() {
    return _medicationsController.stream.asBroadcastStream(
      onListen: (StreamSubscription<List<Medication>> subscription) {
        _dispatch();
      },
    );
  }

  @override
  Future<void> saveMedication(Medication medication) async {
    final int medicationIndex = _getIndex(medication);

    if (medicationIndex >= 0) {
      _medicationsList[medicationIndex] = medication;
      _medicationsList = <Medication>[..._medicationsList];
    }

    if (medicationIndex < 0) {
      _medicationsList = <Medication>[..._medicationsList, medication];
    }

    _dispatch();
  }

  @override
  Future<void> removeMedication(Medication medication) async {
    final int medicationIndex = _getIndex(medication);

    _medicationsList.removeAt(medicationIndex);
    _medicationsList = <Medication>[..._medicationsList];

    _dispatch();
  }

  void _dispatch() {
    _medicationsController.sink.add(_medicationsList);
  }

  int _getIndex(Medication medication) {
    return _medicationsList.indexWhere(
      (Medication element) => element.compound == medication.compound,
    );
  }
}
