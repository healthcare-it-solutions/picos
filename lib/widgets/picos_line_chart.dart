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
import 'package:syncfusion_flutter_charts/charts.dart';
import '../screens/home_screen/overview/widgets/graph_section.dart';
import '../../../../models/daily.dart';
import '../themes/global_theme.dart';

/// Widget to display heart rate values in a line chart.
class PicosLineChart extends StatelessWidget {
  /// Creates a [PicosLineChart].
  const PicosLineChart({Key? key, this.dailyList, this.title})
      : super(key: key);

  ///
  final List<Daily>? dailyList;

  ///
  final String? title;

  List<ChartSampleData> _prepareChartData() {
    if (dailyList == null) return <ChartSampleData>[];

    Map<String, DateTime> daysWithDates =
        ChartHelper.getLastSevenDaysWithDates();

    return daysWithDates.entries.map((MapEntry<String, DateTime> entry) {
      String dayShortText = entry.key;
      DateTime date = entry.value;

      Daily? matchingDaily = dailyList!.firstWhereOrNull(
        (Daily daily) => ChartHelper.isSameDay(daily.date, date),
      );

      double? value = matchingDaily?.heartFrequency?.toDouble();

      return ChartSampleData(
        x: dayShortText,
        y: value,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
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
        ),
        primaryYAxis: NumericAxis(isVisible: false),
        series: <LineSeries<ChartSampleData, String>>[
          LineSeries<ChartSampleData, String>(
            dataSource: _prepareChartData(),
            xValueMapper: (ChartSampleData point, _) => point.x,
            yValueMapper: (ChartSampleData point, _) => point.y,
            markerSettings: const MarkerSettings(isVisible: true),
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.top,
            ),
            emptyPointSettings: EmptyPointSettings(
              mode: EmptyPointMode.drop,
            ),
          )
        ],
      ),
    );
  }
}
