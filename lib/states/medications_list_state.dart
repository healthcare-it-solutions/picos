import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picos/models/medication_model.dart';
import 'package:picos/screens/my_medications_screen/medication_card.dart';

///A BloC holding the MedicationsList.
class MedicationsListState extends Cubit<List<MedicationCard>> {
  ///Creates the MedicationsListState.
  MedicationsListState(List<MedicationCard> initialState) : super(initialState);

  ///Adds a new Card to the medication list.
  void addCard(MedicationModel medication) {
    state.add(MedicationCard(medication));
    emit(state);
  }
}
