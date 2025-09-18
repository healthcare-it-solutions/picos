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
import 'package:picos/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:picos/screens/home_screen/overview/widgets/graph_section.dart';
import 'package:picos/screens/my_values_screen/picos_chart_helper.dart';
import 'package:picos/screens/my_values_screen/picos_chart_sample_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../models/daily.dart';
import '../../models/abstract_database_object.dart';
import '../../models/weekly.dart';
import '../../themes/global_theme.dart';

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

  List<PicosChartSampleData> _prepareChartData() {
    Map<String, DateTime> datesWithValues = isWeekly == true
        ? PicosChartHelper.getLastSevenWeeksFromToday()
        : PicosChartHelper.getLastSevenDaysWithDates();

    return datesWithValues.entries.map((MapEntry<String, DateTime> entry) {
      String dayShortText = entry.key;
      DateTime date = entry.value;

      AbstractDatabaseObject? matchingData = isWeekly == true
          ? (dataList as List<Weekly>?)?.firstWhereOrNull(
              (Weekly weekly) =>
                  PicosChartHelper.isInSameWeek(weekly.date, date),
            )
          : (dataList as List<Daily>?)?.firstWhereOrNull(
              (Daily daily) => PicosChartHelper.isSameDay(daily.date, date),
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

      return PicosChartSampleData(
        x: dayShortText,
        y: y,
        y1: y1,
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
    List<PicosChartSampleData> chartDataList = _prepareChartData();
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    TooltipBehavior tooltipBehavior = TooltipBehavior(
      enable: true,
      textStyle: const TextStyle(
        fontSize: kIsWeb ? 18 : 14,
      ),
    );
    final DateTime today = DateTime.now();
    final DateTime startDate = today.subtract(
      Duration(days: isWeekly == true ? 42 : 7),
    );

    final String titleText = _formatDateRange(startDate, today);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.blue!, width: PicosChartHelper.width),
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
            color: PicosChartHelper.colorBlack,
          ),
          axisLine: AxisLine(
            color: theme.blue,
          ),
        ),
        primaryYAxis: const NumericAxis(isVisible: false),
        tooltipBehavior: tooltipBehavior,
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.top,
        ),
        series: <ColumnSeries<PicosChartSampleData, String>>[
          ColumnSeries<PicosChartSampleData, String>(
            color: theme.blue,
            dataSource: chartDataList,
            width: PicosChartHelper.width,
            spacing: 0.4,
            xValueMapper: (PicosChartSampleData point, _) => point.x,
            yValueMapper: (PicosChartSampleData point, _) => point.y,
            name: valuesChartOptions == ValuesChartOptions.bodyWeightAndBMI
                ? AppLocalizations.of(context)!.bodyWeight
                : AppLocalizations.of(context)!.systolic,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.outer,
            ),
          ),
          ColumnSeries<PicosChartSampleData, String>(
            color: theme.red,
            dataSource: chartDataList,
            width: PicosChartHelper.width,
            spacing: 0.4,
            xValueMapper: (PicosChartSampleData point, _) => point.x as String,
            yValueMapper: (PicosChartSampleData point, _) => point.y1,
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
