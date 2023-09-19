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
import 'package:picos/widgets/picos_chart_helper.dart';
import 'package:picos/widgets/picos_chart_sample_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../models/daily.dart';
import '../themes/global_theme.dart';

/// Widget to display heart rate values in a line chart.
class PicosChartLine extends StatelessWidget {
  /// Creates a [PicosChartLine].
  const PicosChartLine({Key? key, this.dailyList, this.title})
      : super(key: key);

  /// A list of daily items.
  final List<Daily>? dailyList;

  /// An optional title, used for a chart name.
  final String? title;

  List<PicosChartSampleData> _prepareChartData() {
    if (dailyList == null) return <PicosChartSampleData>[];

    Map<String, DateTime> daysWithDates =
        PicosChartHelper.getLastSevenDaysWithDates();

    return daysWithDates.entries.map((MapEntry<String, DateTime> entry) {
      String dayShortText = entry.key;
      DateTime date = entry.value;

      Daily? matchingDaily = dailyList!.firstWhereOrNull(
        (Daily daily) => PicosChartHelper.isSameDay(daily.date, date),
      );

      double? value = matchingDaily?.heartFrequency?.toDouble();

      return PicosChartSampleData(
        x: dayShortText,
        y: value,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
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
          axisLine: AxisLine(
            color: theme.blue,
          ),
          labelStyle: const TextStyle(
            color: PicosChartHelper.colorBlack,
          ),
        ),
        primaryYAxis: NumericAxis(isVisible: false),
        tooltipBehavior: tooltipBehavior,
        series: <LineSeries<PicosChartSampleData, String>>[
          LineSeries<PicosChartSampleData, String>(
            dataSource: _prepareChartData(),
            xValueMapper: (PicosChartSampleData point, _) => point.x,
            yValueMapper: (PicosChartSampleData point, _) => point.y,
            name: title,
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
