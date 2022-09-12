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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/pages/configuration_form.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/pages/configuration_vital_values.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/pages/configuration_activity_and_rest.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/pages/configuration_body_and_mind.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/pages/configuration_medication_and_therapy.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/pages/configuration_summary.dart';
import 'package:picos/widgets/picos_ink_well_button.dart';

import '../../../themes/global_theme.dart';

/// Stateful Widget for the PageView of configuration.
class ConfigurationPages extends StatefulWidget {
  /// Constructor of ConfigurationPages.
  const ConfigurationPages({Key? key}) : super(key: key);

  @override
  State<ConfigurationPages> createState() => _ConfigurationPages();
}

class _ConfigurationPages extends State<ConfigurationPages> {
  PageController controller = PageController();

  final List<Widget> _list = <Widget>[
    const ConfigurationForm(),
    const ConfigurationVitalValues(),
    const ConfigurationActivityAndRest(),
    const ConfigurationBodyAndMind(),
    const ConfigurationMedicationAndTherapy(),
    const ConfigurationSummary()
  ];

  int _currentPage = 0;

  final GlobalKey<FormState> formKeyConfiguration = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.configuration),
        backgroundColor: theme.darkGreen3,
      ),
      body: Form(
        key: formKeyConfiguration,
        child: PageView(
          scrollDirection: Axis.vertical,
          controller: controller,
          onPageChanged: (int num) {
            setState(() {
              _currentPage = num;
            });
          },
          children: _list,
        ),
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child: PicosInkWellButton(
              text: AppLocalizations.of(context)!.back,
              onTap: () {
                if (_currentPage == 0) {
                  Navigator.of(context).pop();
                } else {
                  controller.jumpToPage(_currentPage - 1);
                }
              },
              buttonColor1: theme.grey3,
              buttonColor2: theme.grey1,
            ),
          ),
          Expanded(
            child: PicosInkWellButton(
              text: AppLocalizations.of(context)!.proceed,
              onTap: () {
                if (_currentPage == _list.length - 1) {
                  Navigator.of(context)
                      .pushNamed('/configuration-finish-screen');
                } else {
                  if (_currentPage == 0) {
                    if (formKeyConfiguration.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppLocalizations.of(context)!.submitData,
                          ),
                        ),
                      );
                      controller.jumpToPage(_currentPage + 1);
                    }
                  }
                  else {
                    controller.jumpToPage(_currentPage + 1);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
