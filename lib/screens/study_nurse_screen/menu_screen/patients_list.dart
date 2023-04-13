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
import 'package:picos/api/backend_patient_api.dart';
import 'package:picos/api/backend_patient_data_api.dart';
import 'package:picos/models/patient.dart';
import 'package:picos/models/patient_data.dart';
import 'package:picos/state/objects_list_bloc.dart';
import 'patient_card.dart';

/// A List with all medications.
class PatientsList extends StatefulWidget {
  /// Creates the medication list.
  const PatientsList({Key? key}) : super(key: key);

  @override
  State<PatientsList> createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      // ignore: always_specify_types
      listeners: [
        BlocListener<ObjectsListBloc<BackendPatientApi>, ObjectsListState>(
          listener: (BuildContext context, ObjectsListState state) {},
        ),
        BlocListener<ObjectsListBloc<BackendPatientDataApi>, ObjectsListState>(
          listener: (BuildContext context, ObjectsListState state) {},
        ),
      ],
      child: BlocBuilder<ObjectsListBloc<BackendPatientApi>, ObjectsListState>(
        builder: (BuildContext context, ObjectsListState statePatient) {
          return BlocBuilder<ObjectsListBloc<BackendPatientDataApi>,
              ObjectsListState>(
            builder: (BuildContext context, ObjectsListState statePatientData) {
              if (statePatient.objectsList.isEmpty &&
                  statePatientData.objectsList.isEmpty &&
                  statePatient.status == ObjectsListStatus.loading &&
                  statePatientData.status == ObjectsListStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (statePatient.status == ObjectsListStatus.failure ||
                  statePatientData.status == ObjectsListStatus.failure) {
                return const Center(
                  child: Text('Error'),
                );
              }

              return ListView.builder(
                itemCount: statePatientData.objectsList.length,
                itemBuilder: (BuildContext context, int index) {
                  for (int j = 0; j < statePatient.objectsList.length; j++) {
                    if ((statePatient.objectsList[j] as Patient).objectId ==
                        (statePatientData.objectsList[index] as PatientData)
                            .patientObjectId) {
                      return PatientCard(
                        statePatient.objectsList[j] as Patient,
                        statePatientData.objectsList[index] as PatientData,
                      );
                    }
                  }
                  return null;
                },
              );
            },
          );
        },
      ),
    );
  }
}
