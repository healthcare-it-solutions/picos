import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picos/states/medications_list_state.dart';
import 'medication_card.dart';

///A List with all medications.
class MedicationsList extends StatefulWidget {
  ///Creates the medication list.
  const MedicationsList({Key? key}) : super(key: key);

  @override
  _MedicationsListState createState() => _MedicationsListState();
}

class _MedicationsListState extends State<MedicationsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicationsListState, List<MedicationCard>>(
      builder: (BuildContext context, List<MedicationCard> state) =>
          ListView.builder(
        itemCount: context.read<MedicationsListState>().state.length,
        itemBuilder: (BuildContext context, int index) {
          return context.read<MedicationsListState>().state[index];
        },
      ),
    );
  }
}
