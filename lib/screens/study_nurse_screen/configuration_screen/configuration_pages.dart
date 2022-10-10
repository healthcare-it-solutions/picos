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
import 'package:picos/models/patient.dart';
import 'package:picos/models/patient_profile.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/pages/configuration_form.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/pages/configuration_vital_values.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/pages/configuration_activity_and_rest.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/pages/configuration_body_and_mind.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/pages/configuration_medication_and_therapy.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/pages/configuration_summary.dart';
import 'package:picos/util/backend.dart';
import 'package:picos/widgets/picos_ink_well_button.dart';

import 'package:picos/themes/global_theme.dart';

/// FormKey for the underlying PageView-Elements.
final GlobalKey<FormState> formKeyConfiguration = GlobalKey<FormState>();

/// Stateful Widget for the PageView of configuration.
class ConfigurationPages extends StatefulWidget {
  /// Constructor of ConfigurationPages.
  const ConfigurationPages({Key? key}) : super(key: key);

  @override
  State<ConfigurationPages> createState() => _ConfigurationPages();
}

class _ConfigurationPages extends State<ConfigurationPages> {
  PageController controller = PageController();

  static Map<String, bool> vitalValuesEntries = <String, bool>{
    'entryBloodPressureEnabled': false,
    'entryBloodSugarLevelsEnabled': false,
    'entryHeartFrequencyEnabled': false,
    'entryWeightBMIEnabled': false,
  };

  static Map<String, bool> medicationAndTherapyEntries = <String, bool>{
    'entryDoctorsVisitEnabled': false,
    'entryMedicationEnabled': false,
    'entryTherapyEnabled': false,
  };

  static Map<String, bool> bodyAndMindEntries = <String, bool>{
    'entryPainEnabled': false,
    'entryPhq4Enabled': false,
  };

  static Map<String, bool> activityAndRestEntries = <String, bool>{
    'entrySleepDurationEnabled': false,
    'entrySleepQualityEnabled': false,
    'entryWalkDistanceEnabled': false,
  };

  static Map<String, String> formEntries = <String, String>{
    'entryFirstName': '',
    'entryFamilyName': '',
    'entryEmail': '',
    'entryNumber': '',
    'entryAddress': '',
    'entryFormOfAddress': '',
  };

  ConfigurationForm configurationForm = ConfigurationForm(
    callbackForm: (String key, String value) {
      formEntries[key] = value;
    },
  );

  ConfigurationActivityAndRest configurationActivityAndRest =
      ConfigurationActivityAndRest(
    callbackActivityAndRest: (String key, bool value) {
      activityAndRestEntries[key] = value;
    },
  );

  ConfigurationBodyAndMind configurationBodyAndMind = ConfigurationBodyAndMind(
    callbackBodyAndMind: (String key, bool value) {
      bodyAndMindEntries[key] = value;
    },
  );

  ConfigurationMedicationAndTherapy configurationMedicationAndTherapy =
      ConfigurationMedicationAndTherapy(
    callbackMedicationAndTherapy: (String key, bool value) {
      medicationAndTherapyEntries[key] = value;
    },
  );

  ConfigurationSummary configurationSummary = const ConfigurationSummary();
  ConfigurationVitalValues configurationVitalValues = ConfigurationVitalValues(
    callbackVitalValues: (String key, bool value) {
      vitalValuesEntries[key] = value;
    },
  );

  List<Widget> list = <Widget>[];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    if (list.isEmpty) {
      list = <Widget>[
        configurationForm,
        configurationVitalValues,
        configurationActivityAndRest,
        configurationBodyAndMind,
        configurationMedicationAndTherapy,
        configurationSummary,
      ];
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.configuration),
        backgroundColor: theme.darkGreen3,
      ),
      body: Form(
        key: formKeyConfiguration,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          onPageChanged: (int num) {
            setState(() {
              _currentPage = num;
            });
          },
          children: list,
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
              onTap: () async {
                if (_currentPage == list.length - 1) {
                  formKeyConfiguration.currentState!.save();
                  Patient patient = Patient(
                    firstName: formEntries['entryFirstName']!,
                    familyName: formEntries['entryFamilyName']!,
                    email: formEntries['entryEmail']!,
                    number: formEntries['entryNumber']!,
                    address: formEntries['entryAddress']!,
                    formOfAddress: formEntries['entryFormOfAddress']!,
                  );
                  BackendACL patientACL = BackendACL();
                  patientACL.setReadAccess(
                    userId: 'role:Doctor',
                  );
                  dynamic responsePatient = await Backend.saveObject(
                    patient,
                    acl: patientACL,
                  );
                  patient = patient.copyWith(
                    objectId: responsePatient['objectId'],
                    createdAt: DateTime.parse(responsePatient['createdAt']),
                  );
                  PatientProfile patientProfile = PatientProfile(
                    bloodPressureEnabled:
                        vitalValuesEntries['entryBloodPressureEnabled']!,
                    bloodSugarLevelsEnabled:
                        vitalValuesEntries['entryBloodSugarLevelsEnabled']!,
                    heartFrequencyEnabled:
                        vitalValuesEntries['entryHeartFrequencyEnabled']!,
                    weightBMIEnabled:
                        vitalValuesEntries['entryWeightBMIEnabled']!,
                    doctorsVisitEnabled: medicationAndTherapyEntries[
                        'entryDoctorsVisitEnabled']!,
                    medicationEnabled:
                        medicationAndTherapyEntries['entryMedicationEnabled']!,
                    therapyEnabled:
                        medicationAndTherapyEntries['entryTherapyEnabled']!,
                    walkDistanceEnabled: activityAndRestEntries[
                        'entryWalkDistanceEnabled']!,
                    sleepDurationEnabled:
                        activityAndRestEntries['entrySleepDurationEnabled']!,
                    sleepQualityEnabled:
                        activityAndRestEntries['entrySleepQualityEnabled']!,
                    painEnabled: bodyAndMindEntries['entryPainEnabled']!,
                    phq4Enabled: bodyAndMindEntries['entryPhq4Enabled']!,
                    patientObjectId: patient.objectId!,
                  );
                  BackendACL patientProfileACL = BackendACL();
                  patientProfileACL.setReadAccess(
                    userId: patient.objectId!,
                  );
                  patientProfileACL.setReadAccess(
                    userId: 'role:Doctor',
                  );
                  patientProfileACL.setWriteAccess(
                    userId: 'role:Doctor',
                  );
                  dynamic responsePatientProfile = await Backend.saveObject(
                    patientProfile,
                    acl: patientProfileACL,
                  );
                  patientProfile = patientProfile.copyWith(
                    objectId: responsePatientProfile['objectId'],
                    createdAt: DateTime.parse(
                      responsePatientProfile['createdAt'],
                    ),
                  );
                  if (!mounted) {
                    return;
                  }
                  Navigator.of(context)
                      .pushReplacementNamed('/configuration-finish-screen');
                }
                if ((_currentPage == 0 &&
                        formKeyConfiguration.currentState!.validate()) ||
                    _currentPage > 0) {
                  controller.jumpToPage(_currentPage + 1);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
