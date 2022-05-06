import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/models/medication_model.dart';
import 'package:picos/screens/add_medication_screen/add_medication_screen_label.dart';
import 'package:picos/widgets/picos_ink_well_button.dart';
import 'package:picos/widgets/picos_select.dart';
import '../../states/medications_list_state.dart';
import '../../widgets/picos_body.dart';
import '../my_medications_screen/medication_card.dart';

///A screen for adding new medication schedules.
class AddMedicationScreen extends StatelessWidget {
  ///Creates the AddMedicationScreen.
  const AddMedicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color infoTextFontColor = Colors.white;
    const EdgeInsets selectPaddingRight = EdgeInsets.only(
      bottom: 5,
      right: 5,
      top: 5,
    );
    const EdgeInsets selectPaddingLeft = EdgeInsets.only(
      bottom: 5,
      left: 5,
      top: 5,
    );

    final MedicationModel medication = MedicationModel();

    Expanded _createAmountSelect(
        EdgeInsets padding, String hint, String medicationTime) {
      return Expanded(
        child: Padding(
          padding: padding,
          child: PicosSelect(
            selection: MedicationModel.selection,
            hint: hint,
            callBackFunction: (String value) {
              //Since mirrors are disabled or prohibited in Flutter.
              switch (medicationTime) {
                case 'morning':
                  medication.morning = value;
                  break;
                case 'noon':
                  medication.noon = value;
                  break;
                case 'evening':
                  medication.evening = value;
                  break;
                case 'night':
                  medication.night = value;
                  break;
              }
            },
          ),
        ),
      );
    }

    return BlocBuilder<MedicationsListState, List<MedicationCard>>(
      builder: (BuildContext context, List<MedicationCard> state) {
        return Container(
          color: Theme.of(context).backgroundColor,
          child: SafeArea(
            child: Scaffold(
              bottomNavigationBar: PicosInkWellButton(
                text: AppLocalizations.of(context)!.add,
                onTap: () {
                  context.read<MedicationsListState>().addCard(medication);
                  Navigator.of(context).pop();
                },
              ),
              appBar: AppBar(
                centerTitle: true,
                title: Text(AppLocalizations.of(context)!.addMedication),
                backgroundColor: Theme.of(context).backgroundColor,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              body: PicosBody(
                child: Column(
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: const <Widget>[
                                  Icon(Icons.info, color: infoTextFontColor),
                                  SizedBox(
                                    height: 60,
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .addMedicationInfoPart1,
                                  style: const TextStyle(
                                      color: infoTextFontColor, fontSize: 15),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .addMedicationInfoPart2,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .addMedicationInfoPart3),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    AddMedicationScreenLabel(
                      label: AppLocalizations.of(context)!.compound,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: PicosSelect(
                          callBackFunction: (String value) {
                            medication.compound = value;
                          },
                          // Placeholder values to be changed.
                          selection: const <String>['Aspirin', 'Vitamin C'],
                          hint: AppLocalizations.of(context)!.selectCompound),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AddMedicationScreenLabel(
                      label: AppLocalizations.of(context)!.intake,
                    ),
                    Row(
                      children: <Expanded>[
                        _createAmountSelect(
                            selectPaddingRight,
                            AppLocalizations.of(context)!.inTheMorning,
                            'morning'),
                        _createAmountSelect(selectPaddingLeft,
                            AppLocalizations.of(context)!.noon, 'noon'),
                      ],
                    ),
                    Row(
                      children: <Expanded>[
                        _createAmountSelect(
                            selectPaddingRight,
                            AppLocalizations.of(context)!.inTheEvening,
                            'evening'),
                        _createAmountSelect(selectPaddingLeft,
                            AppLocalizations.of(context)!.toTheNight, 'night'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
