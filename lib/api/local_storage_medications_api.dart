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
    _medicationsList = <Medication>[..._medicationsList, medication];
    _dispatch();
  }

  void _dispatch() {
    _medicationsController.sink.add(_medicationsList);
  }
}
