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

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/api/backend_values_api.dart';
import 'package:picos/models/daily.dart';
import 'package:picos/models/values.dart';
import 'package:picos/models/weekly.dart';
import 'package:picos/screens/home_screen/overview/widgets/section.dart';
import '../../../../themes/global_theme.dart';
import '../../../../widgets/picos_chart_column.dart';
import '../../../../widgets/picos_ink_well_button.dart';
import '../../../../widgets/picos_chart_line.dart';
import '../../../../widgets/picos_chart_two_columns.dart';
import '../../../questionaire_screen/questionaire_screen.dart';

///
enum ValuesChartOptions {
  /// The patients heart frequency.
  heartFrequency,

  /// The patients blood sugar value.
  bloodSugar,

  /// The patients blood pressure.
  bloodPressure,

  /// The patients sleep duration.
  sleepDuration,

  /// The patients body weight.
  bodyWeight,

  /// The patients BMI.
  bmi,

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
  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    double screenHeight = MediaQuery.of(context).size.height;
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
                height: screenHeight*2.0, // Space for two graphs.
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
                        return const Center(
                          child: Text('Keine Daten verfügbar.'),
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

  /// Returns a column widget containing the graphs populated
  /// with the given data.
  Widget _buildGraphsWithData(Values? values) {
    List<Daily>? dailyList = values?.dailyList;
    List<Weekly>? weeklyList = values?.weeklyList;
    return Column(
      children: <Widget>[
        Expanded(
          child: PicosChartColumn(
            dataList: dailyList,
            title: AppLocalizations.of(context)!.bloodSugar,
            valuesChartOptions: ValuesChartOptions.bloodSugar,
          ),
        ),
        const SizedBox(height: 20), // Spacer.
        Expanded(
          child: PicosChartLine(
            dailyList: dailyList,
            title: AppLocalizations.of(context)!.heartFrequency,
          ),
        ),
        const SizedBox(height: 20), // Spacer.
        Expanded(
          child: PicosChartColumn(
            dataList: dailyList,
            title: AppLocalizations.of(context)!.sleepDuration,
            valuesChartOptions: ValuesChartOptions.sleepDuration,
          ),
        ),
        const SizedBox(height: 20), // Spacer.
        Expanded(
          child: PicosChartTwoColumns(
            dailyList: dailyList,
            title: AppLocalizations.of(context)!.bloodPressure,
            valuesChartOptions: ValuesChartOptions.bloodPressure,
          ),
        ),
        const SizedBox(height: 20), // Spacer.
        Expanded(
          child: PicosChartColumn(
            dataList: weeklyList,
            title: AppLocalizations.of(context)!.walkDistance,
            valuesChartOptions: ValuesChartOptions.walkingDistance,
            isWeekly: true,
          ),
        ),
        const SizedBox(height: 20), // Spacer.
        Expanded(
          child: PicosChartColumn(
            dataList: weeklyList,
            title: AppLocalizations.of(context)!.bodyWeight,
            valuesChartOptions: ValuesChartOptions.bodyWeight,
            isWeekly: true,
          ),
        ),
        const SizedBox(height: 20), // Spacer.
        PicosInkWellButton(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          text: AppLocalizations.of(context)!.manageValues,
          onTap: () {
            Navigator.pushNamed(
              context,
              '/my-values_screen/my-values',
            ).then((_) {
              setState(() {});
            });
          },
          fontSize: 20,
        ),
      ],
    );
  }
}

/// Helper class for common chart properties and methods.
class ChartHelper {
  ///
  static const double width = 1.0;

  ///
  static const Color colorBlack = Colors.black;

  ///
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Returns the last seven days of the week.
  static Map<String, DateTime> getLastSevenDaysWithDates() {
    int today = DateTime.now().weekday - 1;
    List<String> weekDays = <String>['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];

    Map<String, DateTime> weekDaysWithDates = <String, DateTime>{};

    for (int i = 6; i >= 0; i--) {
      int dayIndex = (today - i + 7) % 7;
      DateTime dateForDay = DateTime.now().subtract(Duration(days: i));

      weekDaysWithDates[weekDays[dayIndex]] = dateForDay;
    }

    return weekDaysWithDates;
  }

  /// Returns the dates for the last seven weeks starting from today.
  static Map<String, DateTime> getLastSevenWeeksFromToday() {
    DateTime today = DateTime.now();

    Map<String, DateTime> weeksFromToday = <String, DateTime>{};

    for (int i = 6; i >= 0; i--) {
      DateTime dateFromToday = today.subtract(Duration(days: 7 * i));
      weeksFromToday['KW${7 - i}'] = dateFromToday;
    }

    return weeksFromToday;
  }
}

///Chart sample data
class ChartSampleData {
  /// Holds the datapoint values like x, y.
  ChartSampleData({
    this.x,
    this.y,
    this.y1,
  });

  /// Holds x value of the datapoint.
  final dynamic x;

  /// Holds y value of the datapoint.
  final dynamic y;

  /// Holds y value of the datapoint (for 2nd series).
  final dynamic y1;
}
