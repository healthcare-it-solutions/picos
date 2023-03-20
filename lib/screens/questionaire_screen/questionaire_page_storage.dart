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
import 'package:picos/models/phq4.dart';
import 'package:picos/screens/questionaire_screen/pages/blood_pressure.dart';
import 'package:picos/screens/questionaire_screen/pages/body_and_mind.dart';
import 'package:picos/screens/questionaire_screen/pages/weight.dart';
import 'package:picos/screens/questionaire_screen/widgets/cover.dart';
import 'package:picos/screens/questionaire_screen/widgets/doctor_card.dart';
import 'package:picos/screens/questionaire_screen/widgets/pain_scale_card.dart';
import 'package:picos/screens/questionaire_screen/widgets/questionaire_page.dart';
import 'package:picos/screens/questionaire_screen/widgets/radio_select_card.dart';
import 'package:picos/screens/questionaire_screen/widgets/sleep_quality_card.dart';
import 'package:picos/screens/questionaire_screen/widgets/text_field_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/daily.dart';
import '../../models/patient_registration_data.dart';
import '../../models/weekly.dart';
import '../../util/backend.dart';

import '../../widgets/picos_label.dart';

/// Manages the state of the questionaire pages.
class QuestionairePageStorage {
  QuestionairePageStorage._create(
    BuildContext context,
    Daily? daily,
    Weekly? weekly,
    PHQ4? phq4,
  ) {
    _initValues(daily, weekly, phq4);
    _initStrings(context);
  }

  /// Constructs QuestionairePageState.
  static Future<QuestionairePageStorage> create(
    void Function() previousPage,
    void Function() nextPage,
    BuildContext context,
    Daily? daily,
    Weekly? weekly,
    PHQ4? phq4,
  ) async {
    QuestionairePageStorage qps = QuestionairePageStorage._create(
      context,
      daily,
      weekly,
      phq4,
    );
    await qps._initPages(previousPage, nextPage);
    return qps;
  }

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

  /// The selected walk distance.
  int? selectedWalkDistance;

  /// The selected sleep duration.
  int? selectedSleepDuration;

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

  //Static Strings
  static String? _myEntries;
  static String? _vitalValues;
  static String? _activityAndRest;
  static String? _bodyAndMind;
  static String? _medicationAndTherapy;
  static String? _ready;
  static String? _heartFrequency;
  static String? _bloodSugar;
  static String? _possibleWalkDistance;
  static String? _sleepDuration;
  static String? _hrs;
  static String? _sleepQuality7Days;
  static String? _pain;
  static String? _lowInterest;
  static String? _dejection;
  static String? _nervousness;
  static String? _worries;
  static String? _changedMedication;
  static String? _changedTherapy;
  static Map<String, dynamic>? _medicationAndTherapyValues;
  static String? _tips;
  static String? _drinkEnough;

  static int? _bodyHeight;

  late final bool _daily;
  late final bool _weekly;
  late final bool _phq4;

  void _initValues(Daily? daily, Weekly? weekly, PHQ4? phq4) {
    _daily = daily != null && daily.hasNullValues ? true : false;
    _weekly = weekly != null && weekly.hasNullValues ? true : false;
    _phq4 = phq4 != null && phq4.hasNullValues ? true : false;

    selectedBodyWeight = weekly?.bodyWeight;
    selectedBMI = weekly?.bmi;
    selectedHeartFrequency = daily?.heartFrequency;
    selectedSyst = daily?.bloodSystolic;
    selectedDias = daily?.bloodDiastolic;
    selectedBloodSugar = daily?.bloodSugar;
    selectedWalkDistance = weekly?.walkingDistance;
    selectedSleepDuration = daily?.sleepDuration;
    selectedSleepQuality = weekly?.sleepQuality;
    selectedPain = daily?.pain;
    selectedQuestionA = phq4?.a;
    selectedQuestionB = phq4?.b;
    selectedQuestionC = phq4?.c;
    selectedQuestionD = phq4?.d;
  }

  void _initStrings(BuildContext context) {
    _heartFrequency = AppLocalizations.of(context)!.heartFrequency;
    _bloodSugar = AppLocalizations.of(context)!.bloodSugar;
    _possibleWalkDistance = AppLocalizations.of(context)!.possibleWalkDistance;
    _sleepDuration = AppLocalizations.of(context)!.sleepDuration;
    _hrs = AppLocalizations.of(context)!.hrs;
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
    _tips = AppLocalizations.of(context)!.tips;
    _drinkEnough = AppLocalizations.of(context)!.drinkEnough;
  }

  Future<void> _initPages(
    void Function() previousPage,
    void Function() nextPage,
  ) async {
    _bodyHeight =
        (await Backend.getAll(PatientRegistrationData.databaseTable))[0]
            ['BodyHeight'];
    if (_weekly || _daily) {
      pages.add(
        Cover(
          title: _vitalValues!,
          image: 'assets/Vitalwerte_neg.png',
          nextFunction: nextPage,
        ),
      );
      titles.add(_myEntries!);
    }
    if (_weekly) {
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
          bodyHeight: _bodyHeight,
        ),
      );
      titles.add(_vitalValues!);
    }
    if (_daily) {
      pages.add(
        QuestionairePage(
          backFunction: previousPage,
          nextFunction: nextPage,
          child: TextFieldCard(
            initialValue: selectedHeartFrequency,
            label: _heartFrequency!,
            hint: 'bpm',
            onChanged: (String value) {
              int? intValue = int.tryParse(value);

              if (intValue == null && value.isNotEmpty) {
                intValue = int.tryParse(value.split('.')[0]);
              }

              selectedHeartFrequency = intValue;
            },
          ),
        ),
      );
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
      pages.add(
        QuestionairePage(
          backFunction: previousPage,
          nextFunction: nextPage,
          child: TextFieldCard(
            initialValue: selectedBloodSugar,
            label: _bloodSugar!,
            hint: 'mg/dL',
            onChanged: (String value) {
              selectedBloodSugar = int.tryParse(value);
            },
          ),
        ),
      );

      for (int i = 0; i < 3; i++) {
        titles.add(_vitalValues!);
      }
    }
    if (_weekly || _daily) {
      pages.add(
        Cover(
          title: _activityAndRest!,
          image: 'assets/Aktivitaet+Ruhe_neg.png',
          backFunction: previousPage,
          nextFunction: nextPage,
        ),
      );
      titles.add(_myEntries!);
    }
    if (_weekly) {
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
    if (_daily) {
      pages.add(
        QuestionairePage(
          backFunction: previousPage,
          nextFunction: nextPage,
          child: TextFieldCard(
            initialValue: selectedSleepDuration,
            label: _sleepDuration!,
            hint: _hrs!,
            onChanged: (String value) {
              selectedSleepDuration = int.tryParse(value);
            },
          ),
        ),
      );
      titles.add(_activityAndRest!);
    }
    if (_weekly) {
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
    if (_daily || _phq4) {
      pages.add(
        Cover(
          title: _bodyAndMind!,
          image: 'assets/Koerper+Psyche_neg.png',
          backFunction: previousPage,
          nextFunction: nextPage,
        ),
      );
      titles.add(_myEntries!);
    }
    if (_daily) {
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
      titles.add(_bodyAndMind!);
    }
    if (_phq4) {
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
    pages.add(
      Cover(
        title: _medicationAndTherapy!,
        image: 'assets/Medikation+Therapie_neg.png',
        backFunction: previousPage,
        nextFunction: nextPage,
      ),
    );
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
    pages.add(
      Cover(
        title: _ready!,
        image: 'assets/Fertig_Smiley_neg.png',
        infoText: <TextSpan>[
          TextSpan(
            text: '$_tips\n',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: _drinkEnough,
          ),
        ],
      ),
    );

    titles.add(_myEntries!);
    for (int i = 0; i < 3; i++) {
      titles.add(_medicationAndTherapy!);
    }
    titles.add(_myEntries!);
  }
}
