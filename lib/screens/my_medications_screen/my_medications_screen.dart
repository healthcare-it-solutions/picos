import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/screens/my_medications_screen/medications_list.dart';
import 'package:picos/widgets/picos_ink_well_button.dart';

///Shows a list with all personal medication plans.
class MyMedicationsScreen extends StatelessWidget {
  ///Creates MyMedicationsScreen
  const MyMedicationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  spreadRadius: 2,
                  blurRadius: 2,
                ),
              ],
            ),
            child: PicosInkWellButton(
              text: AppLocalizations.of(context)!.addMedication,
              onTap: () {
                Navigator.of(context).pushNamed('/add-medication');
              },
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text(AppLocalizations.of(context)!.myMedications),
          ),
          body: const MedicationsList(),
        ),
      ),
    );
  }
}
