import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/models/medication.dart';
import 'package:picos/screens/add_medication_screen/add_medication_screen_label.dart';
import 'package:picos/widgets/picos_ink_well_button.dart';
import 'package:picos/widgets/picos_select.dart';

import '../../states/medications_list_bloc.dart';
import '../../widgets/picos_body.dart';

/// A screen for adding new medication schedules.
class AddMedicationScreen extends StatefulWidget {
  /// Creates the AddMedicationScreen.
  const AddMedicationScreen({Key? key}) : super(key: key);

  @override
  _AddMedicationScreenState createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  /// The amount to take in the morning.
  String _morning = '0';
  /// The amount to take in the noon.
  String _noon = '0';
  /// The amount to take in the evening.
  String _evening = '0';
  /// The amount to take before night.
  String _night = '0';
  /// The compound to be taken.
  String? _compound;
  /// Determines if you are able to add the medication.
  bool _addDisabled = true;

  Expanded _createAmountSelect(
      EdgeInsets padding, String hint, String medicationTime) {
    return Expanded(
      child: Padding(
        padding: padding,
        child: PicosSelect(
          selection: Medication.selection,
          hint: hint,
          callBackFunction: (String value) {
            //Since mirrors are disabled or prohibited in Flutter.
            switch (medicationTime) {
              case 'morning':
                _morning = value;
                break;
              case 'noon':
                _noon = value;
                break;
              case 'evening':
                _evening = value;
                break;
              case 'night':
                _night = value;
                break;
            }
          },
        ),
      ),
    );
  }

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

    String addText = AppLocalizations.of(context)!.selectCompound;

    if (!_addDisabled) {
      addText = AppLocalizations.of(context)!.add;
    }

    return BlocBuilder<MedicationsListBloc, MedicationsListState>(
      builder: (BuildContext context, MedicationsListState state) {
        return Container(
          color: Theme.of(context).backgroundColor,
          child: SafeArea(
            child: Scaffold(
              bottomNavigationBar: PicosInkWellButton(
                disabled: _addDisabled,
                text: addText,
                onTap: () {
                  context
                      .read<MedicationsListBloc>()
                      .add(SaveMedication(Medication(
                        compound: _compound!,
                        morning: _morning,
                        noon: _noon,
                        evening: _evening,
                        night: _night,
                      )));
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
                            _compound = value;
                            setState(() {
                              _addDisabled = false;
                            });
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
