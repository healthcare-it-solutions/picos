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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/api/backend_patients_list_api.dart';
import 'package:picos/models/patient.dart';
import 'package:picos/models/patient_data.dart';
import 'package:picos/models/patient_profile.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/pages/configuration_additional_entries.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/pages/configuration_form.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/pages/configuration_vital_values.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/pages/configuration_activity_and_rest.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/pages/configuration_body_and_mind.dart';
import 'package:picos/screens/study_nurse_screen/configuration_screen/pages/configuration_medication_and_therapy.dart';
import 'package:picos/state/objects_list_bloc.dart';
import 'package:picos/util/backend.dart';
import 'package:picos/widgets/picos_ink_well_button.dart';
import '../../../widgets/picos_form_of_address.dart';

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
  final PageController _controller = PageController();

  final Map<String, bool> _vitalValuesEntries = <String, bool>{
    'entryBloodPressureEnabled': false,
    'entryBloodSugarLevelsEnabled': false,
    'entryHeartFrequencyEnabled': false,
    'entryWeightBMIEnabled': true,
  };

  final Map<String, bool> _medicationAndTherapyEntries = <String, bool>{
    'entryDoctorsVisitEnabled': true,
    'entryMedicationEnabled': true,
    'entryTherapyEnabled': true,
  };

  final Map<String, bool> _bodyAndMindEntries = <String, bool>{
    'entryPainEnabled': true,
    'entryPhq4Enabled': true,
  };

  final Map<String, bool> _activityAndRestEntries = <String, bool>{
    'entrySleepDurationEnabled': true,
    'entrySleepQualityEnabled': true,
    'entryWalkDistanceEnabled': false,
  };

  final Map<String, String> _formEntries = <String, String>{
    'entryFirstName': '',
    'entryFamilyName': '',
    'entryEmail': '',
    'entryNumber': '',
    'entryAddress': '',
    'entryFormOfAddress': FormOfAddress.female.toString(),
  };

  final Map<String, String> _additionalEntries = <String, String>{
    'entryCaseNumber': '',
    'entryPatientID': '',
    'entryInstituteKey': '',
    'entryHeight': '',
  };

  final List<Widget> _list = <Widget>[];

  int _currentPage = 0;

  late Patient patient;

  Future<Patient> _savePatient() async {
    patient = Patient(
      firstName: _formEntries['entryFirstName']!,
      familyName: _formEntries['entryFamilyName']!,
      email: _formEntries['entryEmail']!,
      number: _formEntries['entryNumber']!,
      address: _formEntries['entryAddress']!,
      formOfAddress: _formEntries['entryFormOfAddress']!,
    );
    BackendACL patientACL = BackendACL();
    patientACL.setReadAccess(
      userId: BackendRole.doctor.id,
    );
    dynamic responsePatient = await Backend.saveObject(
      patient,
      acl: patientACL,
    );
    patient = patient.copyWith(
      objectId: responsePatient['objectId'],
      createdAt: DateTime.parse(responsePatient['createdAt']),
    );

    return patient;
  }

  Future<PatientProfile> _savePatientProfile() async {
    PatientProfile patientProfile = PatientProfile(
      bloodPressureEnabled: _vitalValuesEntries['entryBloodPressureEnabled']!,
      bloodSugarLevelsEnabled:
          _vitalValuesEntries['entryBloodSugarLevelsEnabled']!,
      heartFrequencyEnabled: _vitalValuesEntries['entryHeartFrequencyEnabled']!,
      weightBMIEnabled: _vitalValuesEntries['entryWeightBMIEnabled']!,
      doctorsVisitEnabled:
          _medicationAndTherapyEntries['entryDoctorsVisitEnabled']!,
      medicationEnabled:
          _medicationAndTherapyEntries['entryMedicationEnabled']!,
      therapyEnabled: _medicationAndTherapyEntries['entryTherapyEnabled']!,
      walkDistanceEnabled: _activityAndRestEntries['entryWalkDistanceEnabled']!,
      sleepDurationEnabled:
          _activityAndRestEntries['entrySleepDurationEnabled']!,
      sleepQualityEnabled: _activityAndRestEntries['entrySleepQualityEnabled']!,
      painEnabled: _bodyAndMindEntries['entryPainEnabled']!,
      phq4Enabled: _bodyAndMindEntries['entryPhq4Enabled']!,
      patientObjectId: patient.objectId!,
      doctorObjectId: Backend.user.objectId!,
    );
    BackendACL patientProfileACL = BackendACL();
    patientProfileACL.setReadAccess(
      userId: patient.objectId!,
    );
    patientProfileACL.setReadAccess(
      userId: BackendRole.doctor.id,
    );
    patientProfileACL.setWriteAccess(
      userId: BackendRole.doctor.id,
    );
    await Backend.saveObject(
      patientProfile,
      acl: patientProfileACL,
    );

    return patientProfile;
  }

  Future<PatientData> _savePatientData() async {
    PatientData patientData = PatientData(
      bodyHeight: double.parse(_additionalEntries['entryHeight']!),
      patientID: _additionalEntries['entryPatientID']!,
      caseNumber: _additionalEntries['entryCaseNumber']!,
      instKey: _additionalEntries['entryInstituteKey']!,
      patientObjectId: patient.objectId!,
      doctorObjectId: Backend.user.objectId!,
    );
    BackendACL patientDataACL = BackendACL();
    patientDataACL.setReadAccess(
      userId: patient.objectId!,
    );
    patientDataACL.setReadAccess(
      userId: BackendRole.doctor.id,
    );
    patientDataACL.setWriteAccess(
      userId: BackendRole.doctor.id,
    );
    await Backend.saveObject(
      patientData,
      acl: patientDataACL,
    );

    return patientData;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    int lastPage = _list.length - 1;

    if (_list.isEmpty) {
      final ConfigurationForm configurationForm = ConfigurationForm(
        callbackForm: (String key, String value) {
          _formEntries[key] = value;
        },
        initialForm: _formEntries,
      );

      final ConfigurationActivityAndRest configurationActivityAndRest =
          ConfigurationActivityAndRest(
        callbackActivityAndRest: (String key, bool value) {
          _activityAndRestEntries[key] = value;
        },
        initialAlactivityAndRest: _activityAndRestEntries,
      );

      final ConfigurationBodyAndMind configurationBodyAndMind =
          ConfigurationBodyAndMind(
        callbackBodyAndMind: (String key, bool value) {
          _bodyAndMindEntries[key] = value;
        },
        initialBodyAndMind: _bodyAndMindEntries,
      );

      final ConfigurationMedicationAndTherapy
          configurationMedicationAndTherapy = ConfigurationMedicationAndTherapy(
        callbackMedicationAndTherapy: (String key, bool value) {
          _medicationAndTherapyEntries[key] = value;
        },
        initialMedicationAndTherapy: _medicationAndTherapyEntries,
      );

      final ConfigurationVitalValues configurationVitalValues =
          ConfigurationVitalValues(
        callbackVitalValues: (String key, bool value) {
          _vitalValuesEntries[key] = value;
        },
        initialVitalValues: _vitalValuesEntries,
      );

      final ConfigurationAdditionalEntries configurationAdditionalEntries =
          ConfigurationAdditionalEntries(
        callbackAdditionalEntries: (String key, String value) {
          _additionalEntries[key] = value;
        },
      );

      _list.addAll(<Widget>[
        configurationForm,
        configurationVitalValues,
        configurationActivityAndRest,
        configurationBodyAndMind,
        configurationMedicationAndTherapy,
        configurationAdditionalEntries,
      ]);
    }

    return BlocBuilder<ObjectsListBloc<BackendPatientsListApi>,
        ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.configuration),
            backgroundColor: theme.darkGreen2,
          ),
          body: Form(
            key: formKeyConfiguration,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
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
                      _controller.jumpToPage(_currentPage - 1);
                    }
                  },
                  buttonColor1: theme.grey3,
                  buttonColor2: theme.grey1,
                ),
              ),
              Expanded(
                child: PicosInkWellButton(
                  text: _currentPage == lastPage
                      ? AppLocalizations.of(context)!.save
                      : AppLocalizations.of(context)!.proceed,
                  onTap: () async {
                    if (_currentPage == lastPage &&
                        formKeyConfiguration.currentState!.validate()) {
                      formKeyConfiguration.currentState!.save();
                      await _savePatient();
                      await _savePatientData();
                      await _savePatientProfile();
                      if (!mounted) return;
                      Navigator.of(context).pushReplacementNamed(
                        '/study-nurse-screen/configuration-finish-screen',
                      );
                      return;
                    }
                    if ((_currentPage == 0 &&
                            formKeyConfiguration.currentState!.validate()) ||
                        _currentPage > 0 && _currentPage != lastPage) {
                      _controller.jumpToPage(_currentPage + 1);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
