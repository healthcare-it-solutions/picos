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

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:picos/models/abstract_database_object.dart';
import 'package:picos/models/weekly.dart';
import 'package:picos/screens/home_screen/overview/widgets/graph_section.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../models/daily.dart';
import '../themes/global_theme.dart';

/// Widget to display blood sugar values in a column chart.
class PicosChartColumn extends StatelessWidget {
  /// Creates a [PicosChartColumn].
  const PicosChartColumn({
    Key? key,
    this.dataList,
    this.title,
    this.valuesChartOptions,
    this.isWeekly,
  }) : super(key: key);

  ///
  final List<dynamic>? dataList;

  ///
  final String? title;

  ///
  final ValuesChartOptions? valuesChartOptions;

  ///
  final bool? isWeekly;

  List<ChartSampleData> _prepareChartData() {
    Map<String, DateTime> datesWithValues = isWeekly == true
        ? ChartHelper.getLastSevenWeeksFromToday()
        : ChartHelper.getLastSevenDaysWithDates();

    return datesWithValues.entries.map((MapEntry<String, DateTime> entry) {
      String dayShortText = entry.key;
      DateTime date = entry.value;

      AbstractDatabaseObject? matchingData = isWeekly == true
          ? (dataList as List<Weekly>?)?.firstWhereOrNull(
              (Weekly weekly) => ChartHelper.isSameDay(weekly.date, date),
            )
          : (dataList as List<Daily>?)?.firstWhereOrNull(
              (Daily daily) => ChartHelper.isSameDay(daily.date, date),
            );

      double? value;
      if (valuesChartOptions == ValuesChartOptions.bodyWeight) {
        value = (matchingData as Weekly?)?.bodyWeight?.toDouble();
      } else if (valuesChartOptions == ValuesChartOptions.walkingDistance) {
        value = (matchingData as Weekly?)?.walkingDistance?.toDouble();
      } else if (valuesChartOptions == ValuesChartOptions.bloodSugar) {
        value = (matchingData as Daily?)?.bloodSugar?.toDouble();
      } else if (valuesChartOptions == ValuesChartOptions.sleepDuration) {
        value = (matchingData as Daily?)?.sleepDuration?.toDouble();
      }

      return ChartSampleData(
        x: dayShortText,
        y: value,
      );
    }).toList();
  }

  String _formatDateRange(DateTime startDate, DateTime endDate) {
    final DateFormat formatterStartDate = DateFormat('dd.MM.');
    final DateFormat formatterEndDate = DateFormat('dd.MM.yyyy');
    return '$title  ${formatterStartDate.format(startDate)}- '
        '${formatterEndDate.format(endDate)}';
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    final DateTime today = DateTime.now();
    final DateTime startDate = today.subtract(
      Duration(days: isWeekly == true ? 42 : 7),
    );

    final String titleText = _formatDateRange(startDate, today);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.blue!, width: ChartHelper.width),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        title: ChartTitle(
          text: titleText,
          textStyle: TextStyle(
            color: theme.blue,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          alignment: ChartAlignment.near,
        ),
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          labelStyle: const TextStyle(
            color: ChartHelper.colorBlack,
          ),
        ),
        primaryYAxis: NumericAxis(isVisible: false),
        series: <ColumnSeries<ChartSampleData, String>>[
          ColumnSeries<ChartSampleData, String>(
            dataSource: _prepareChartData(),
            xValueMapper: (ChartSampleData point, _) => point.x,
            yValueMapper: (ChartSampleData point, _) => point.y,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.outer,
            ),
          )
        ],
      ),
    );
  }
}
