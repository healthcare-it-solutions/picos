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

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picos/api/backend_daily_inputs_api.dart';
import 'package:picos/models/daily_input.dart';
import 'package:picos/models/phq4.dart';
import 'package:picos/models/weekly.dart';
import 'package:picos/screens/questionaire_screen/questionaire_page_storage.dart';
import 'package:picos/widgets/picos_screen_frame.dart';

import '../../api/backend_medications_api.dart';
import '../../models/daily.dart';
import '../../state/objects_list_bloc.dart';

/// This is the screen a user should see when prompted to provide some
/// information about their health status.
/// Requires an [DailyInput] as argument.
class QuestionaireScreen extends StatefulWidget {
  /// QuestionaireScreen constructor
  const QuestionaireScreen({Key? key}) : super(key: key);

  @override
  State<QuestionaireScreen> createState() => _QuestionaireScreenState();
}

class _QuestionaireScreenState extends State<QuestionaireScreen> {
  QuestionairePageStorage? _pageStorage;
  late Future<bool> _init;
  static final PageController _controller = PageController();
  static const Duration _controllerDuration = Duration(milliseconds: 300);
  static const Curve _controllerCurve = Curves.ease;

  // State
  DailyInput? _dailyInput;
  String? _title;

  void _previousPage() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_controller.page == 0 ||
        _controller.page == _pageStorage!.pages.length - 1) {
      Navigator.of(context).pop();
      return;
    }

    _controller.previousPage(
      duration: _controllerDuration,
      curve: _controllerCurve,
    );
  }

  void _nextPage() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_controller.page == _pageStorage!.pages.length - 1) {
      Navigator.of(context).pop();
      return;
    }

    if (_controller.page == _pageStorage!.redirectingPages['medicationPage'] &&
        _pageStorage!.medicationChanged == true &&
        _pageStorage!.medicationUpdated == false) {
      _pageStorage!.medicationUpdated = true;
      Navigator.of(context).pushNamed('/my-medications-screen/my-medications');
    }

    if (_controller.page == _pageStorage!.redirectingPages['therapyPage'] &&
        _pageStorage!.therapyChanged == true &&
        _pageStorage!.therapyUpdated == false) {
      _pageStorage!.therapyUpdated = true;
      Navigator.of(context).pushNamed('/my-therapy-screen/my-therapy');
    }

    if (_controller.page == _pageStorage!.redirectingPages['doctorPage'] &&
        _pageStorage!.doctorVisited == true &&
        _pageStorage!.doctorVisitedUpdated == false) {
      _pageStorage!.doctorVisitedUpdated = true;
      Navigator.of(context).pushNamed('/visits-screen/visits');
    }

    _controller.nextPage(
      duration: _controllerDuration,
      curve: _controllerCurve,
    );
  }

  // Class init.
  Future<bool> _classInit(BuildContext context) async {
    //Required argument.
    _dailyInput = ModalRoute.of(context)!.settings.arguments as DailyInput;

    if (_pageStorage != null) {
      return true;
    }

    if (!mounted) {
      return false;
    }

    _pageStorage = await QuestionairePageStorage.create(
      _previousPage,
      _nextPage,
      context,
      _dailyInput!,
    );

    return true;
  }

  Weekly? _createWeekly(DateTime date) {
    if (!_dailyInput!.weeklyDay) {
      return null;
    }

    if (_dailyInput!.weekly == null) {
      return Weekly(
        date: date,
        bodyWeight: _pageStorage!.selectedBodyWeight,
        bmi: _pageStorage!.selectedBMI,
        sleepQuality: _pageStorage!.selectedSleepQuality,
        walkingDistance: _pageStorage!.selectedWalkDistance,
      );
    }

    return _dailyInput!.weekly!.copyWith(
      bodyWeight: _pageStorage!.selectedBodyWeight,
      bmi: _pageStorage!.selectedBMI,
      sleepQuality: _pageStorage!.selectedSleepQuality,
      walkingDistance: _pageStorage!.selectedWalkDistance,
    );
  }

  PHQ4? _createPhq4(DateTime date) {
    if (!_dailyInput!.phq4Day) {
      return null;
    }

    if (_dailyInput!.phq4 == null) {
      return PHQ4(
        date: date,
        a: _pageStorage!.selectedQuestionA,
        b: _pageStorage!.selectedQuestionB,
        c: _pageStorage!.selectedQuestionC,
        d: _pageStorage!.selectedQuestionD,
      );
    }

    return _dailyInput!.phq4!.copyWith(
      a: _pageStorage!.selectedQuestionA,
      b: _pageStorage!.selectedQuestionB,
      c: _pageStorage!.selectedQuestionC,
      d: _pageStorage!.selectedQuestionD,
    );
  }

  /// This is used instead of initState() because it would cause an error inside
  /// the [FutureBuilder] due to too early execution of [_title] etc.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_pageStorage == null) {
      _init = _classInit(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObjectsListBloc<BackendMedicationsApi>,
        ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        return FutureBuilder<bool>(
          future: _init,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const CircularProgressIndicator();
            }

            // Instance init.
            _title ??= _pageStorage!.titles[0];

            return PicosScreenFrame(
              appBarElevation: 0.0,
              title: _title,
              body: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (int value) async {
                  if (_title != _pageStorage!.titles[value]) {
                    setState(() {
                      _title = _pageStorage!.titles[value];
                    });
                  }

                  if (value == _pageStorage!.pages.length - 1) {
                    DateTime date = DateTime.now()
                        .subtract(Duration(days: _dailyInput!.day));

                    Daily daily = _dailyInput!.daily == null
                        ? Daily(
                            date: date,
                            bloodDiastolic: _pageStorage!.selectedDias,
                            bloodSugar: _pageStorage!.selectedBloodSugar,
                            bloodSystolic: _pageStorage!.selectedSyst,
                            pain: _pageStorage!.selectedPain,
                            sleepDuration: _pageStorage!.selectedSleepDuration,
                            heartFrequency:
                                _pageStorage!.selectedHeartFrequency,
                            bloodSugarMol: _pageStorage!.selectedBloodSugarMol,
                          )
                        : _dailyInput!.daily!.copyWith(
                            bloodDiastolic: _pageStorage!.selectedDias,
                            bloodSugar: _pageStorage!.selectedBloodSugar,
                            bloodSystolic: _pageStorage!.selectedSyst,
                            pain: _pageStorage!.selectedPain,
                            sleepDuration: _pageStorage!.selectedSleepDuration,
                            heartFrequency:
                                _pageStorage!.selectedHeartFrequency,
                            bloodSugarMol: _pageStorage!.selectedBloodSugarMol,
                          );

                    Weekly? weekly = _createWeekly(date);
                    PHQ4? phq4 = _createPhq4(date);

                    _dailyInput!.copyWith(
                      daily: daily,
                      weekly: weekly,
                      phq4: phq4,
                    );

                    context.read<ObjectsListBloc<BackendDailyInputsApi>>().add(
                          SaveObject(
                            _dailyInput!.copyWith(
                              daily: daily,
                              weekly: weekly,
                              phq4: phq4,
                            ),
                          ),
                        );
                  }
                },
                children: _pageStorage!.pages,
              ),
            );
          },
        );
      },
    );
  }
}
