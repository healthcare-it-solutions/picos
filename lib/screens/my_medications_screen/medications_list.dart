import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picos/states/medications_list_bloc.dart';
import 'medication_card.dart';

/// A List with all medications.
class MedicationsList extends StatefulWidget {
  /// Creates the medication list.
  const MedicationsList({Key? key}) : super(key: key);

  @override
  _MedicationsListState createState() => _MedicationsListState();
}

class _MedicationsListState extends State<MedicationsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicationsListBloc, MedicationsListState>(
      builder: (BuildContext context, MedicationsListState state) {

        if (state.medicationsList.isEmpty &&
            state.status == MedicationsListStatus.loading) {

          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: state.medicationsList.length,
          itemBuilder: (BuildContext context, int index) {

            return MedicationCard(state.medicationsList[index]);
          },
        );
      },
    );
  }
}
