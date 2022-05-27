import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/screens/my_medications_screen/medications_list.dart';
import 'package:picos/widgets/picos_ink_well_button.dart';

import '../../themes/global_theme.dart';

/// Shows a list with all personal medication plans.
class MyMedicationsScreen extends StatelessWidget {
  /// Creates MyMedicationsScreen
  const MyMedicationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return Container(
      color: theme.darkGreen1,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: theme.bottomNavigationBar,
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
