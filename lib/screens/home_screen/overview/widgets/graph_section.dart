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

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/api/backend_values_api.dart';
import 'package:picos/models/daily.dart';
import 'package:picos/models/myValues.dart';
import 'package:picos/screens/home_screen/overview/widgets/section.dart';

import '../../../../themes/global_theme.dart';
import '../../../../widgets/picos_chart_frame.dart';
import '../../../../widgets/picos_ink_well_button.dart';

/// Widget which shows a graph
class GraphSection extends StatefulWidget {
  /// GraphSection constructor
  const GraphSection({Key? key}) : super(key: key);

  @override
  State<GraphSection> createState() => _GraphState();
}

class _GraphState extends State<GraphSection> {
  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    return Section(
      title: AppLocalizations.of(context)!.myMedicalData,
      titleColor: theme.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 175 * 2, //Zwei Graphen.
            child: FutureBuilder<MyValues?>(
              future: BackendValuesApi.getMyValues(),
              builder: (
                BuildContext context,
                AsyncSnapshot<MyValues?> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child:
                              _BloodSugarChart(data: snapshot.data?.dailyList),
                        ),
                        const SizedBox(height: 15 * 2), // Abstand dazwischen.
                        Expanded(
                          child:
                              _HeartRateChart(data: snapshot.data?.dailyList),
                        ),
                        const SizedBox(height: 15 * 2), // Abstand dazwischen.
                        PicosInkWellButton(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          text: AppLocalizations.of(context)!.manageValues,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/my-values_screen/my-values',
                            );
                          },
                          fontSize: 20,
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: Text('Keine Daten verfügbar.'));
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
  }
}

// This helper class holds methods and properties that are common
// between _BloodSugarChart and _HeartRateChart to avoid repetition.
///
class ChartHelper {
  ///
  static double width = 1.0;

  ///
  static Color colorBlack = Colors.black;

  ///
  static Widget getTitles(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: colorBlack,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mn';
        break;
      case 1:
        text = 'Te';
        break;
      case 2:
        text = 'Wd';
        break;
      case 3:
        text = 'Tu';
        break;
      case 4:
        text = 'Fr';
        break;
      case 5:
        text = 'St';
        break;
      case 6:
        text = 'Sn';
        break;
      default:
        text = '';
        break;
    }
    return Text(text, style: style);
  }

  ///
  static FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  ///
  static FlBorderData get borderData => FlBorderData(
        show: false,
      );
}

class _BloodSugarChart extends StatelessWidget {
  const _BloodSugarChart({Key? key, this.data}) : super(key: key);
  final List<Daily>? data;

  List<BarChartGroupData> prepareChartData(
    List<Daily>? data,
    GlobalTheme theme,
  ) {
    List<BarChartGroupData> chartData = <BarChartGroupData>[];

    if (data == null) return chartData;

    int length = data.length;
    for (int i = 0; i < length; i++) {
      double? bloodSugar = data[length - i - 1].bloodSugar?.toDouble();

      if (bloodSugar != null) {
        chartData.add(
          BarChartGroupData(
            x: i,
            barRods: <BarChartRodData>[
              BarChartRodData(
                toY: bloodSugar,
                gradient: _barsGradient(theme),
                borderRadius: BorderRadius.zero,
              ),
            ],
            showingTooltipIndicators: <int>[0],
          ),
        );
      }
    }

    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    List<BarChartGroupData> barChartData = prepareChartData(data, theme);

    return PicosChartFrame(
      title: AppLocalizations.of(context)!.bloodSugar,
      chart: BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: ChartHelper.titlesData,
          borderData: ChartHelper.borderData,
          barGroups: barChartData,
          gridData: FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: 500,
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              TextStyle(
                color: ChartHelper.colorBlack,
              ),
            );
          },
        ),
      );

  LinearGradient _barsGradient(GlobalTheme theme) {
    return LinearGradient(
      colors: <Color>[
        theme.blue!,
        theme.blue!,
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );
  }
}

class _HeartRateChart extends StatelessWidget {
  const _HeartRateChart({Key? key, this.data}) : super(key: key);
  final List<Daily>? data;

  List<FlSpot> prepareLineChartData(List<Daily>? data) {
    List<FlSpot> chartData = <FlSpot>[];

    if (data == null) return chartData;

    int length = data.length;
    for (int i = 0; i < length; i++) {
      double? heartFrequency =
          data[length - i - 1].heartFrequency?.toDouble(); // Umkehren hier

      if (heartFrequency != null) {
        chartData.add(FlSpot(i.toDouble(), heartFrequency));
      }
    }

    return chartData;
  }

  List<LineChartBarData> lineBarsData(List<FlSpot> spots, GlobalTheme theme) {
    return <LineChartBarData>[
      LineChartBarData(
        spots: spots,
        color: theme.blue,
        barWidth: 2,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    List<FlSpot> lineChartData = prepareLineChartData(data);

    return PicosChartFrame(
      title: AppLocalizations.of(context)!.heartFrequency,
      chart: LineChart(
        LineChartData(
          lineBarsData: lineBarsData(lineChartData, theme),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          minX: 0,
          maxX: 7,
          minY: 0,
          maxY: 150,
        ),
      ),
    );
  }
}
