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
import 'package:picos/models/daily_input.dart';
import 'package:picos/models/patient_data.dart';
import 'package:picos/screens/questionnaire_screen/pages/blood_pressure.dart';
import 'package:picos/screens/questionnaire_screen/pages/blood_sugar.dart';
import 'package:picos/screens/questionnaire_screen/pages/body_and_mind.dart';
import 'package:picos/screens/questionnaire_screen/pages/heart_frequency.dart';
import 'package:picos/screens/questionnaire_screen/pages/sleep.dart';
import 'package:picos/screens/questionnaire_screen/pages/weight.dart';
import 'package:picos/screens/questionnaire_screen/widgets/cover.dart';
import 'package:picos/screens/questionnaire_screen/widgets/doctor_card.dart';
import 'package:picos/screens/questionnaire_screen/widgets/pain_scale_card.dart';
import 'package:picos/screens/questionnaire_screen/widgets/questionnaire_page.dart';
import 'package:picos/screens/questionnaire_screen/widgets/radio_select_card.dart';
import 'package:picos/screens/questionnaire_screen/widgets/sleep_quality_card.dart';
import 'package:picos/screens/questionnaire_screen/widgets/text_field_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/patient_profile.dart';
import '../../util/backend.dart';

import '../../widgets/picos_label.dart';

/// Manages the state of the questionaire pages.
class QuestionairePageStorage {
  QuestionairePageStorage._create(
    BuildContext context, {
    required this.dailyInput,
  }) {
    _initValues();
    _initStrings(context);
  }

  /// Constructs QuestionairePageState.
  static Future<QuestionairePageStorage> create(
    void Function() previousPage,
    void Function() nextPage,
    BuildContext context,
    DailyInput dailyInput,
  ) async {
    QuestionairePageStorage qps = QuestionairePageStorage._create(
      context,
      dailyInput: dailyInput,
    );
    await qps._initPages(previousPage, nextPage);
    return qps;
  }

  /// The [DailyInput] model containing all question answers.
  final DailyInput dailyInput;

  /// The loaded pages.
  final List<Widget> pages = <Widget>[];

  /// Maps the pageViews to according titles.
  final List<String> titles = <String>[];

  // Value store for the user
  /// The selected body weight.
  double? selectedBodyWeight;

  /// The given bmi.
  double? selectedBMI;

  /// The selected heart frequency.
  int? selectedHeartFrequency;

  /// The selected syst value for blood pressure.
  int? selectedSyst;

  /// The selected dias value for blood pressure.
  int? selectedDias;

  /// The selected blood sugar value.
  int? selectedBloodSugar;

  /// The selected blood sugar value (mmol/l).
  double? selectedBloodSugarMol;

  /// The selected walk distance.
  int? selectedWalkDistance;

  /// The selected sleep duration.
  double? selectedSleepDuration;

  /// The selected sleep quality.
  int? selectedSleepQuality;

  /// The selected pain value.
  int? selectedPain;

  /// Answer to question A.
  int? selectedQuestionA;

  /// Answer to question B.
  int? selectedQuestionB;

  /// Answer to question C.
  int? selectedQuestionC;

  /// Answer to question D.
  int? selectedQuestionD;

  /// Tells if the medication got updated by the user.
  bool medicationUpdated = false;

  /// Tells if the therapy got updated by the user.
  bool therapyUpdated = false;

  /// Tells if the doctor visits got updated by the user.
  bool doctorVisitedUpdated = false;

  /// Tells if the medication got changed and should be updated (synced)
  /// by the user.
  bool? medicationChanged;

  /// Tells if the therapy got changed and should be updated (synced)
  /// by the user.
  bool? therapyChanged;

  /// Tells if the user visited a doctor or a hospital and should be updated
  /// (synced) by the user.
  bool? doctorVisited;

  /// Tells what pages include redirects.
  final Map<String, int> redirectingPages = <String, int>{
    'medicationPage': 16,
    'therapyPage': 17,
    'doctorPage': 18,
  };

  //Denotation Strings
  String? _myEntries;
  String? _vitalValues;
  String? _letsStart;
  String? _activityAndRest;
  String? _bodyAndMind;
  String? _medicationAndTherapy;
  String? _ready;
  String? _possibleWalkDistance;
  String? _sleepQuality7Days;
  String? _pain;
  String? _lowInterest;
  String? _dejection;
  String? _nervousness;
  String? _worries;
  String? _changedMedication;
  String? _changedTherapy;
  Map<String, dynamic>? _medicationAndTherapyValues;

  void _initValues() {
    selectedBloodSugarMol = dailyInput.daily?.bloodSugarMol;
    selectedBodyWeight = dailyInput.weekly?.bodyWeight;
    selectedBMI = dailyInput.weekly?.bmi;
    selectedHeartFrequency = dailyInput.daily?.heartFrequency;
    selectedSyst = dailyInput.daily?.bloodSystolic;
    selectedDias = dailyInput.daily?.bloodDiastolic;
    selectedBloodSugar = dailyInput.daily?.bloodSugar;
    selectedWalkDistance = dailyInput.weekly?.walkingDistance;
    selectedSleepDuration = dailyInput.daily?.sleepDuration;
    selectedSleepQuality = dailyInput.weekly?.sleepQuality;
    selectedPain = dailyInput.daily?.pain;
    selectedQuestionA = dailyInput.phq4?.a;
    selectedQuestionB = dailyInput.phq4?.b;
    selectedQuestionC = dailyInput.phq4?.c;
    selectedQuestionD = dailyInput.phq4?.d;
  }

  void _initStrings(BuildContext context) {
    _possibleWalkDistance = AppLocalizations.of(context)!.possibleWalkDistance;
    _ready = AppLocalizations.of(context)!.questionnaireFinished;
    _sleepQuality7Days = AppLocalizations.of(context)!.sleepQuality7Days;
    _pain = AppLocalizations.of(context)!.pain;
    _lowInterest = AppLocalizations.of(context)!.lowInterest;
    _dejection = AppLocalizations.of(context)!.dejection;
    _nervousness = AppLocalizations.of(context)!.nervousness;
    _worries = AppLocalizations.of(context)!.controlWorries;
    _changedTherapy = AppLocalizations.of(context)!.changedTherapy;
    _changedMedication = AppLocalizations.of(context)!.changedMedication;
    _medicationAndTherapyValues = <String, dynamic>{
      AppLocalizations.of(context)!.yes: true,
      AppLocalizations.of(context)!.no: false,
    };
    _myEntries = AppLocalizations.of(context)!.myEntries;
    _vitalValues = AppLocalizations.of(context)!.vitalValues;
    _activityAndRest = AppLocalizations.of(context)!.activityAndRest;
    _bodyAndMind = AppLocalizations.of(context)!.bodyAndMind;
    _medicationAndTherapy = AppLocalizations.of(context)!.medicationAndTherapy;
    _letsStart = AppLocalizations.of(context)!.letsStart;
  }

  Future<PatientProfile> _getPatientProfile() async {
    PatientProfile patientProfile = const PatientProfile(
      weightBMIEnabled: true,
      heartFrequencyEnabled: true,
      bloodPressureEnabled: true,
      bloodSugarLevelsEnabled: true,
      walkDistanceEnabled: true,
      sleepDurationEnabled: true,
      sleepQualityEnabled: true,
      painEnabled: true,
      phq4Enabled: true,
      medicationEnabled: true,
      therapyEnabled: true,
      doctorsVisitEnabled: true,
      patientObjectId: '',
      doctorObjectId: '',
    );

    try {
      dynamic responsePatient = await Backend.getEntry(
        PatientProfile.databaseTable,
        'Patient',
        Backend.user.objectId!,
      );
      dynamic element = responsePatient?.results?.first;

      if (element != null) {
        patientProfile = PatientProfile(
          weightBMIEnabled: element['Weight_BMI'],
          heartFrequencyEnabled: element['HeartRate'],
          bloodPressureEnabled: element['BloodPressure'],
          bloodSugarLevelsEnabled: element['BloodSugar'],
          walkDistanceEnabled: element['WalkingDistance'],
          sleepDurationEnabled: element['SleepDuration'],
          sleepQualityEnabled: element['SISQS'],
          painEnabled: element['Pain'],
          phq4Enabled: element['PHQ4'],
          medicationEnabled: element['Medication'],
          therapyEnabled: element['Therapies'],
          doctorsVisitEnabled: element['Stays'],
          patientObjectId: element['Patient']['objectId'],
          doctorObjectId: element['Doctor']['objectId'],
          objectId: element['objectId'],
          createdAt: element['createdAt'],
          updatedAt: element['updatedAt'],
        );
      }
    } catch (e) {
      rethrow;
    }
    return patientProfile;
  }

  Future<int?> _getBodyHeight() async {
    double? bodyHeight;

    try {
      dynamic responsePatientData = await Backend.getEntry(
        PatientData.databaseTable,
        'Patient',
        Backend.user.objectId!,
      );
      dynamic element = responsePatientData?.results?.first;

      bodyHeight = element?['BodyHeight']?.toDouble();
    } catch (e) {
      Stream<int?>.error(e);
    }

    return bodyHeight?.toInt();
  }

  Future<void> _initPages(
    void Function() previousPage,
    void Function() nextPage,
  ) async {
    PatientProfile patientProfile = await _getPatientProfile();
    Map<String, dynamic> responseRandomTip =
        (await Backend.callEndpoint('getRandTip')).first['result'];
    int? bodyHeight;

    if ((dailyInput.weeklyDay && patientProfile.weightBMIEnabled == true) ||
        patientProfile.heartFrequencyEnabled == true ||
        patientProfile.bloodPressureEnabled == true ||
        patientProfile.bloodSugarLevelsEnabled == true) {
      bodyHeight = await _getBodyHeight();
      pages.add(
        Cover(
          title: _vitalValues!,
          image: 'assets/Vitalwerte_neg.svg',
          nextFunction: nextPage,
          backFunction: previousPage,
          textNext: _letsStart,
        ),
      );
      titles.add(_myEntries!);
      if (dailyInput.weeklyDay && patientProfile.weightBMIEnabled == true) {
        pages.add(
          Weight(
            initialBmi: selectedBMI,
            initialValue: selectedBodyWeight,
            previousPage: previousPage,
            nextPage: nextPage,
            onChangedBodyWeight: (double? weight, double? bmi) {
              selectedBodyWeight = weight;
              selectedBMI = bmi;
            },
            bodyHeight: bodyHeight,
          ),
        );
        titles.add(_vitalValues!);
      }
      if (patientProfile.heartFrequencyEnabled == true) {
        pages.add(
          HeartFrequency(
            initialValue: selectedHeartFrequency,
            previousPage: previousPage,
            nextPage: nextPage,
            onChanged: (String value) {
              int? intValue = int.tryParse(value);

              if (intValue == null && value.isNotEmpty) {
                intValue = int.tryParse(value.split('.')[0]);
              }

              selectedHeartFrequency = intValue;
            },
          ),
        );
      }
      if (patientProfile.bloodPressureEnabled == true) {
        pages.add(
          BloodPressure(
            initialDias: selectedDias,
            initialSyst: selectedSyst,
            previousPage: previousPage,
            nextPage: nextPage,
            onChangedSyst: (String value) {
              selectedSyst = int.tryParse(value);
            },
            onChangedDias: (String value) {
              selectedDias = int.tryParse(value);
            },
          ),
        );
      }
      if (patientProfile.bloodSugarLevelsEnabled == true) {
        pages.add(
          BloodSugar(
            previousPage: previousPage,
            nextPage: nextPage,
            onChanged: (String? value, String? valueMol) {
              selectedBloodSugar = value == null ? null : int.tryParse(value);
              selectedBloodSugarMol =
                  valueMol == null ? null : double.tryParse(valueMol);
            },
            initialValue: selectedBloodSugar,
            initialValueMol: selectedBloodSugarMol,
          ),
        );
      }

      for (int i = 0; i < 3; i++) {
        titles.add(_vitalValues!);
      }
    }

    if ((dailyInput.weeklyDay && patientProfile.walkDistanceEnabled == true) ||
        patientProfile.sleepDurationEnabled == true ||
        (dailyInput.weeklyDay && patientProfile.sleepQualityEnabled == true)) {
      pages.add(
        Cover(
          title: _activityAndRest!,
          image: 'assets/Aktivitaet+Ruhe_neg.svg',
          backFunction: previousPage,
          nextFunction: nextPage,
        ),
      );
      titles.add(_myEntries!);
      if (dailyInput.weeklyDay && patientProfile.walkDistanceEnabled == true) {
        pages.add(
          QuestionairePage(
            backFunction: previousPage,
            nextFunction: nextPage,
            child: TextFieldCard(
              initialValue: selectedWalkDistance,
              label: _possibleWalkDistance!,
              hint: 'Meter',
              onChanged: (String value) {
                selectedWalkDistance = int.tryParse(value);
              },
            ),
          ),
        );
        titles.add(_activityAndRest!);
      }
      if (patientProfile.sleepDurationEnabled == true) {
        pages.add(
          Sleep(
            previousPage: previousPage,
            nextPage: nextPage,
            onChangedSleepDuration: (double? value) {
              selectedSleepDuration = value;
            },
            initialValue: selectedSleepDuration,
          ),
        );
      }

      titles.add(_activityAndRest!);
      if (dailyInput.weeklyDay && patientProfile.sleepQualityEnabled == true) {
        pages.add(
          QuestionairePage(
            backFunction: previousPage,
            nextFunction: nextPage,
            child: SleepQualityCard(
              initialValue: selectedSleepQuality,
              callBack: (dynamic value) {
                selectedSleepQuality = value;
              },
              label: _sleepQuality7Days!,
            ),
          ),
        );
        titles.add(_activityAndRest!);
      }
    }
    if (patientProfile.painEnabled == true ||
        patientProfile.phq4Enabled == true) {
      pages.add(
        Cover(
          title: _bodyAndMind!,
          image: 'assets/Koerper+Psyche_neg.svg',
          backFunction: previousPage,
          nextFunction: nextPage,
        ),
      );
      titles.add(_myEntries!);
      if (patientProfile.painEnabled == true) {
        pages.add(
          QuestionairePage(
            backFunction: previousPage,
            nextFunction: nextPage,
            child: PainScaleCard(
              initialValue: selectedPain,
              label: _pain!,
              callBack: (dynamic value) {
                selectedPain = value as int;
              },
            ),
          ),
        );
      }

      titles.add(_bodyAndMind!);
      if (dailyInput.phq4Day && patientProfile.phq4Enabled == true) {
        pages.add(
          BodyAndMind(
            initialValue: selectedQuestionA,
            previousPage: previousPage,
            nextPage: nextPage,
            onChangedInterest: (dynamic value) {
              selectedQuestionA = value as int;
            },
            questionType: _lowInterest!,
          ),
        );
        pages.add(
          BodyAndMind(
            initialValue: selectedQuestionB,
            previousPage: previousPage,
            nextPage: nextPage,
            onChangedInterest: (dynamic value) {
              selectedQuestionB = value as int;
            },
            questionType: _dejection!,
          ),
        );
        pages.add(
          BodyAndMind(
            initialValue: selectedQuestionC,
            previousPage: previousPage,
            nextPage: nextPage,
            onChangedInterest: (dynamic value) {
              selectedQuestionC = value as int;
            },
            questionType: _nervousness!,
          ),
        );
        pages.add(
          BodyAndMind(
            initialValue: selectedQuestionD,
            previousPage: previousPage,
            nextPage: nextPage,
            onChangedInterest: (dynamic value) {
              selectedQuestionD = value as int;
            },
            questionType: _worries!,
          ),
        );

        for (int i = 0; i < 4; i++) {
          titles.add(_bodyAndMind!);
        }
      }
    }

    if (patientProfile.medicationEnabled == true ||
        patientProfile.therapyEnabled == true) {
      pages.add(
        Cover(
          title: _medicationAndTherapy!,
          image: 'assets/Medikation+Therapie_neg.svg',
          backFunction: previousPage,
          nextFunction: nextPage,
        ),
      );

      if (patientProfile.medicationEnabled == true) {
        redirectingPages['medicationPage'] = pages.length;
        pages.add(
          QuestionairePage(
            backFunction: previousPage,
            nextFunction: nextPage,
            child: RadioSelectCard(
              callback: (dynamic value) {
                medicationChanged = value;
                medicationUpdated = false;
              },
              label: PicosLabel(_changedMedication!),
              options: _medicationAndTherapyValues!,
            ),
          ),
        );
      }

      if (patientProfile.therapyEnabled == true) {
        redirectingPages['therapyPage'] = pages.length;
        pages.add(
          QuestionairePage(
            backFunction: previousPage,
            nextFunction: nextPage,
            child: RadioSelectCard(
              callback: (dynamic value) {
                therapyChanged = value;
                therapyUpdated = false;
              },
              label: PicosLabel(_changedTherapy!),
              options: _medicationAndTherapyValues!,
            ),
          ),
        );
      }
    }
    if (patientProfile.doctorsVisitEnabled == true) {
      redirectingPages['doctorPage'] = pages.length;
      pages.add(
        QuestionairePage(
          backFunction: previousPage,
          nextFunction: nextPage,
          child: DoctorCard(
            callback: (dynamic value) {
              doctorVisited = value;
              doctorVisitedUpdated = false;
            },
            radioOptions: _medicationAndTherapyValues!,
          ),
        ),
      );
    }

    pages.add(
      Cover(
        title: _ready!,
        image: 'assets/Fertig_Smiley_neg.svg',
        backFunction: previousPage,
        nextFunction: nextPage,
        healthTip: responseRandomTip['text']!.toString(),
      ),
    );

    titles.add(_myEntries!);
    for (int i = 0; i < 3; i++) {
      titles.add(_medicationAndTherapy!);
    }
    titles.add(_myEntries!);
  }
}
