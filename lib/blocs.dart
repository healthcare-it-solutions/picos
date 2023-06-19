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
import 'package:picos/api/backend_daily_inputs_api.dart';
import 'package:picos/api/backend_patients_data_api.dart';
import 'package:picos/api/backend_patients_list_api.dart';
import 'package:picos/api/backend_patients_profile_api.dart';
import 'package:picos/state/objects_list_bloc.dart';

import 'api/backend_documents_api.dart';
import 'api/backend_medications_api.dart';
import 'api/backend_physicians_api.dart';
import 'api/backend_relatives_api.dart';
import 'api/backend_stays_api.dart';
import 'api/backend_therapies_api.dart';
import 'api/database_object_api.dart';

/// This is a central place to manage all BLoCs.
class Blocs extends StatelessWidget {
  /// Creates Blocs.
  const Blocs({required this.child, Key? key}) : super(key: key);

  /// The app to initialize.
  final MaterialApp child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<ObjectsListBloc<DatabaseObjectApi>>>[
        BlocProvider<ObjectsListBloc<BackendMedicationsApi>>(
          create: (BuildContext context) =>
          ObjectsListBloc<BackendMedicationsApi>(
            BackendMedicationsApi(),
          )..add(const ObjectsListSubscriptionRequested()),
        ),
        BlocProvider<ObjectsListBloc<BackendTherapiesApi>>(
          create: (BuildContext context) =>
          ObjectsListBloc<BackendTherapiesApi>(
            BackendTherapiesApi(),
          )..add(const ObjectsListSubscriptionRequested()),
        ),
        BlocProvider<ObjectsListBloc<BackendStaysApi>>(
          create: (BuildContext context) =>
          ObjectsListBloc<BackendStaysApi>(
            BackendStaysApi(),
          )..add(const ObjectsListSubscriptionRequested()),
        ),
        BlocProvider<ObjectsListBloc<BackendPhysiciansApi>>(
          create: (BuildContext context) =>
          ObjectsListBloc<BackendPhysiciansApi>(
            BackendPhysiciansApi(),
          )..add(const ObjectsListSubscriptionRequested()),
        ),
        BlocProvider<ObjectsListBloc<BackendRelativesApi>>(
          create: (BuildContext context) =>
          ObjectsListBloc<BackendRelativesApi>(
            BackendRelativesApi(),
          )..add(const ObjectsListSubscriptionRequested()),
        ),
        BlocProvider<ObjectsListBloc<BackendDocumentsApi>>(
          create: (BuildContext context) =>
          ObjectsListBloc<BackendDocumentsApi>(
            BackendDocumentsApi(),
          )..add(const ObjectsListSubscriptionRequested()),
        ),
        BlocProvider<ObjectsListBloc<BackendDailyInputsApi>>(
          create: (BuildContext context) =>
          ObjectsListBloc<BackendDailyInputsApi>(
            BackendDailyInputsApi(),
          )..add(const ObjectsListSubscriptionRequested()),
        ),
        BlocProvider<ObjectsListBloc<BackendPatientsListApi>>(
          create: (BuildContext context) =>
          ObjectsListBloc<BackendPatientsListApi>(
            BackendPatientsListApi(),
          )..add(const ObjectsListSubscriptionRequested()),
        ),
        BlocProvider<ObjectsListBloc<BackendPatientsDataApi>>(
          create: (BuildContext context) =>
          ObjectsListBloc<BackendPatientsDataApi>(
            BackendPatientsDataApi(),
          )..add(const ObjectsListSubscriptionRequested()),
        ),
        BlocProvider<ObjectsListBloc<BackendPatientsProfileApi>>(
          create: (BuildContext context) =>
          ObjectsListBloc<BackendPatientsProfileApi>(
            BackendPatientsProfileApi(),
          )..add(const ObjectsListSubscriptionRequested()),
        ),
      ],
      child: child,
    );
  }
}
