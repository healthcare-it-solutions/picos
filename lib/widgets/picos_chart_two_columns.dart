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

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/screens/home_screen/overview/widgets/graph_section.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../models/daily.dart';
import '../models/abstract_database_object.dart';
import '../models/weekly.dart';
import '../themes/global_theme.dart';

/// Widget to display blood sugar values in a column chart.
class PicosChartTwoColumns extends StatelessWidget {
  /// Creates a [PicosChartTwoColumns].
  const PicosChartTwoColumns({
    Key? key,
    this.dataList,
    this.title,
    this.valuesChartOptions,
    this.isWeekly,
  }) : super(key: key);

  /// A list of data items, potentially of varying types.
  final List<dynamic>? dataList;

  /// An optional title, used for a chart name.
  final String? title;

  /// Options related to how values in a chart are displayed or configured.
  final ValuesChartOptions? valuesChartOptions;

  /// A flag indicating if the data or display is based on a weekly timeframe.
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
              (Weekly weekly) => ChartHelper.isWithinWeek(weekly.date, date),
            )
          : (dataList as List<Daily>?)?.firstWhereOrNull(
              (Daily daily) => ChartHelper.isSameDay(daily.date, date),
            );

      double? y;
      double? y1;
      if (valuesChartOptions == ValuesChartOptions.bodyWeightAndBMI) {
        y = (matchingData as Weekly?)?.bodyWeight?.toDouble();
        double? expressionY1 = (matchingData)?.bmi?.toDouble();
        y1 = expressionY1 != null
            ? (expressionY1 * 100).round() / 100.0
            : expressionY1;
      } else if (valuesChartOptions == ValuesChartOptions.bloodPressure) {
        y = (matchingData as Daily?)?.bloodSystolic?.toDouble();
        y1 = (matchingData)?.bloodDiastolic?.toDouble();
      }

      return ChartSampleData(
        x: dayShortText,
        y: y,
        y1: y1,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<ChartSampleData> chartDataList = _prepareChartData();
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    TooltipBehavior tooltipBehavior = TooltipBehavior(
      enable: true,
      textStyle: const TextStyle(
        fontSize: kIsWeb ? 18 : 14,
      ),
    );
    final DateTime now = DateTime.now();
    final DateTime sevenDayBefore = now.subtract(const Duration(days: 7));
    final String titleText =
        '$title  ${sevenDayBefore.day.toString().padLeft(2, '0')}.'
        '${sevenDayBefore.month.toString().padLeft(2, '0')}.'
        '- ${now.day.toString().padLeft(2, '0')}'
        '.${now.month.toString().padLeft(2, '0')}.${now.year}';

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
          axisLine:  AxisLine(
            color: theme.blue,
          ),
        ),
        primaryYAxis: NumericAxis(isVisible: false),
        tooltipBehavior: tooltipBehavior,
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.top,
        ),
        series: <ColumnSeries<ChartSampleData, String>>[
          ColumnSeries<ChartSampleData, String>(
            dataSource: chartDataList,
            width: 1,
            spacing: 0.4,
            xValueMapper: (ChartSampleData point, _) => point.x,
            yValueMapper: (ChartSampleData point, _) => point.y,
            name: valuesChartOptions == ValuesChartOptions.bodyWeightAndBMI
                ? AppLocalizations.of(context)!.bodyWeight
                : AppLocalizations.of(context)!.systolic,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.outer,
            ),
          ),
          ColumnSeries<ChartSampleData, String>(
            dataSource: chartDataList,
            width: 1,
            spacing: 0.4,
            xValueMapper: (ChartSampleData point, _) => point.x as String,
            yValueMapper: (ChartSampleData point, _) => point.y1,
            name: valuesChartOptions == ValuesChartOptions.bodyWeightAndBMI
                ? AppLocalizations.of(context)!.bmi
                : AppLocalizations.of(context)!.diastolic,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.outer,
            ),
          ),
        ],
      ),
    );
  }
}
