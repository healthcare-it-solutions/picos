/*
*  This file is part of Picos, a health tracking mobile app
*  Copyright (C) 2022 Healthcare IT Solutions GmbH
*
*  This program is free software: you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation, either version 3 of the License, or
*  (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  You should have received a copy of the GNU General Public License
*  along with this program. If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:picos/gen_l10n/app_localizations.dart';
import 'package:picos/api/backend_values_api.dart';
import 'package:picos/models/daily.dart';
import 'package:picos/models/values.dart';
import 'package:picos/models/weekly.dart';
import 'package:picos/screens/home_screen/overview/widgets/section.dart';
import 'package:picos/util/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../themes/global_theme.dart';
import '../../../../widgets/picos_chart_column.dart';
import '../../../../widgets/picos_ink_well_button.dart';
import '../../../../widgets/picos_chart_line.dart';
import '../../../../widgets/picos_chart_two_columns.dart';
import '../../../questionnaire_screen/questionnaire_screen.dart';

/// Options related to how values in a chart are displayed or configured.
enum ValuesChartOptions {
  /// The patients heart frequency.
  heartFrequency,

  /// The patients blood sugar value in Mg unit.
  bloodSugar,

  /// The patients blood sugar value in MMol unit.
  bloodSugarMol,

  /// The patients blood pressure.
  bloodPressure,

  /// The patients sleep duration.
  sleepDuration,

  /// The patients body weight and BMI.
  bodyWeightAndBMI,

  /// The patients walking distance.
  walkingDistance,
}

/// Widget to display a section with graphs.
class GraphSection extends StatefulWidget {
  /// Creates a [GraphSection].
  const GraphSection({Key? key}) : super(key: key);

  @override
  State<GraphSection> createState() => _GraphState();
}

class _GraphState extends State<GraphSection> {
  final Map<String, bool> _preferences = <String, bool>{
    'weight_bmi': false,
    'heart_frequency': false,
    'blood_pressure': false,
    'blood_sugar': false,
    'walk_distance': false,
    'sleep_duration': false,
  };

  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      for (String key in _preferences.keys) {
        _preferences[key] = prefs.getBool(key) ?? false;
      }
    });
  }

  @override
  initState() {
    super.initState();
    loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    double screenHeight = MediaQuery.of(context).size.height;
    int trueCount = _preferences.values.where((bool value) => value).length;
    double calculatedHeight = (screenHeight) * trueCount;
    if (trueCount == 0) {
      return Section(
        title: AppLocalizations.of(context)!.myMedicalData,
        titleColor: theme.blue,
        child: PicosInkWellButton(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          text: AppLocalizations.of(context)!.manageValues,
          onTap: () {
            Navigator.pushNamed(
              context,
              '/my-values_screen/my-values',
            ).then((_) {
              setState(() {
                loadPreferences();
              });
            });
          },
          fontSize: 20,
        ),
      );
    }
    return ValueListenableBuilder<bool>(
      valueListenable: rebuildGraphNotifier,
      builder: (BuildContext context, bool value, Widget? child) {
        return Section(
          title: AppLocalizations.of(context)!.myMedicalData,
          titleColor: theme.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height:
                    kIsWeb ? calculatedHeight * 0.5 : calculatedHeight * 0.4,
                child: FutureBuilder<Values?>(
                  future: BackendValuesApi.getMyValues(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<Values?> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return _buildGraphsWithData(snapshot.data!);
                      } else {
                        return Center(
                          child: Text(
                            AppLocalizations.of(context)!.noDataAvailable,
                          ),
                        );
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
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

  Widget _buildGraphsWithData(Values? values) {
    return Column(
      children: _buildGraphsChildren(values),
    );
  }

  List<Widget> _buildGraphsChildren(Values? values) {
    List<Daily>? dailyList = values?.dailyList;
    List<Weekly>? weeklyList = values?.weeklyList;

    List<Widget> widgets = <Widget>[];

    if (_preferences['blood_sugar'] == true) {
      widgets
        ..add(
          Expanded(
            child: PicosChartColumn(
              dataList: dailyList,
              title: AppLocalizations.of(context)!.bloodSugar,
              valuesChartOptions: Backend.user.get('unitMg')
                  ? ValuesChartOptions.bloodSugar
                  : ValuesChartOptions.bloodSugarMol,
            ),
          ),
        )
        ..add(const SizedBox(height: 20));
    }

    if (_preferences['heart_frequency'] == true) {
      widgets
        ..add(
          Expanded(
            child: PicosChartLine(
              dailyList: dailyList,
              title: AppLocalizations.of(context)!.heartFrequency,
            ),
          ),
        )
        ..add(const SizedBox(height: 20));
    }

    if (_preferences['sleep_duration'] == true) {
      widgets
        ..add(
          Expanded(
            child: PicosChartColumn(
              dataList: dailyList,
              title: AppLocalizations.of(context)!.sleepDuration,
              valuesChartOptions: ValuesChartOptions.sleepDuration,
            ),
          ),
        )
        ..add(const SizedBox(height: 20));
    }

    if (_preferences['blood_pressure'] == true) {
      widgets
        ..add(
          Expanded(
            child: PicosChartTwoColumns(
              dataList: dailyList,
              title: AppLocalizations.of(context)!.bloodPressure,
              valuesChartOptions: ValuesChartOptions.bloodPressure,
            ),
          ),
        )
        ..add(const SizedBox(height: 20));
    }

    if (_preferences['walk_distance'] == true) {
      widgets
        ..add(
          Expanded(
            child: PicosChartColumn(
              dataList: weeklyList,
              title: AppLocalizations.of(context)!.walkDistance,
              valuesChartOptions: ValuesChartOptions.walkingDistance,
              isWeekly: true,
            ),
          ),
        )
        ..add(const SizedBox(height: 20));
    }

    if (_preferences['weight_bmi'] == true) {
      widgets
        ..add(
          Expanded(
            child: PicosChartTwoColumns(
              dataList: weeklyList,
              title: AppLocalizations.of(context)!.bodyWeight,
              valuesChartOptions: ValuesChartOptions.bodyWeightAndBMI,
              isWeekly: true,
            ),
          ),
        )
        ..add(const SizedBox(height: 20));
    }

    widgets.add(
      PicosInkWellButton(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        text: AppLocalizations.of(context)!.manageValues,
        onTap: () {
          Navigator.pushNamed(
            context,
            '/my-values_screen/my-values',
          ).then((_) {
            setState(() {
              loadPreferences();
            });
          });
        },
        fontSize: 20,
      ),
    );

    return widgets;
  }
}
