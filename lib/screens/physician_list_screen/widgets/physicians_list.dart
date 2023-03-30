import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picos/api/backend_physicians_api.dart';
import 'package:picos/screens/physician_list_screen/widgets/physician_card.dart';

import '../../../models/physician.dart';
import '../../../state/objects_list_bloc.dart';

/// A list with all physicians.
class PhysiciansList extends StatefulWidget {
  /// Creates the PhysiciansList.
  const PhysiciansList({Key? key}) : super(key: key);

  @override
  State<PhysiciansList> createState() => _PhysiciansListState();
}

class _PhysiciansListState extends State<PhysiciansList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObjectsListBloc<BackendPhysiciansApi>,
        ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        if (state.objectsList.isEmpty &&
            state.status == ObjectsListStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == ObjectsListStatus.failure) {
          return const Center(
            child: Text('Error'),
          );
        }

        return ListView.builder(
          itemCount: state.objectsList.length,
          itemBuilder: (BuildContext context, int index) {
            return PhysicianCard(state.objectsList[index] as Physician);
          },
        );
      },
    );
  }
}