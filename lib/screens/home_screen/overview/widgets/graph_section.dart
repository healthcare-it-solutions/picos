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
import 'package:picos/screens/home_screen/overview/widgets/section.dart';

import '../../../../models/daily_input.dart';
import '../../../../themes/global_theme.dart';

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
            height: 250,
            child: FutureBuilder<List<DailyInput>?>(
              future: BackendValuesApi.getMyValues(),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<DailyInput>?> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        Expanded(child: _BloodSugarChart(data: snapshot.data)),
                        const SizedBox(height: 20), // Abstand dazwischen.
                        Expanded(child: _HeartRateChart(data: snapshot.data)),
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
  static Widget getTitles(double value, TitleMeta meta) {
    const TextStyle style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
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
  final List<DailyInput>? data;

  List<BarChartGroupData> prepareChartData(List<DailyInput>? data) {
    List<BarChartGroupData> chartData = <BarChartGroupData>[];

    if (data == null) return chartData;

    for (int i = 0; i < data.length; i++) {
      double? bloodSugar = data[i].daily?.bloodSugar?.toDouble();

      if (bloodSugar != null) {
        chartData.add(
          BarChartGroupData(
            x: i,
            barRods: <BarChartRodData>[
              BarChartRodData(toY: bloodSugar, gradient: _barsGradient),
            ],
          ),
        );
      }
    }

    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    List<BarChartGroupData> barChartData = prepareChartData(data);

    return Stack(
      children: <Widget>[
        BarChart(
          BarChartData(
            barTouchData: barTouchData,
            titlesData: ChartHelper.titlesData,
            borderData: ChartHelper.borderData,
            barGroups: barChartData,
            gridData: FlGridData(show: false),
            alignment: BarChartAlignment.spaceAround,
            maxY: 0,
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Transform.scale(
              scale: 1.1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: theme.blue!, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ],
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
              const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  final LinearGradient _barsGradient = const LinearGradient(
    colors: <Color>[
      Colors.lightBlueAccent,
      Colors.greenAccent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> get barGroups => <BarChartGroupData>[
        BarChartGroupData(
          x: 0,
          barRods: <BarChartRodData>[
            BarChartRodData(
              toY: 8,
              gradient: _barsGradient,
            ),
          ],
          showingTooltipIndicators: <int>[0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: <BarChartRodData>[
            BarChartRodData(
              toY: 10,
              gradient: _barsGradient,
            ),
          ],
          showingTooltipIndicators: <int>[0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: <BarChartRodData>[
            BarChartRodData(
              toY: 14,
              gradient: _barsGradient,
            ),
          ],
          showingTooltipIndicators: <int>[0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: <BarChartRodData>[
            BarChartRodData(
              toY: 15,
              gradient: _barsGradient,
            ),
          ],
          showingTooltipIndicators: <int>[0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: <BarChartRodData>[
            BarChartRodData(
              toY: 13,
              gradient: _barsGradient,
            ),
          ],
          showingTooltipIndicators: <int>[0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: <BarChartRodData>[
            BarChartRodData(
              toY: 10,
              gradient: _barsGradient,
            ),
          ],
          showingTooltipIndicators: <int>[0],
        ),
      ];
}

class _HeartRateChart extends StatelessWidget {
  const _HeartRateChart({Key? key, this.data}) : super(key: key);
  final List<DailyInput>? data;

  List<FlSpot> prepareLineChartData(List<DailyInput>? data) {
    List<FlSpot> chartData = <FlSpot>[];

    if (data == null) return chartData;

    for (int i = 0; i < data.length; i++) {
      double? heartFrequency = data[i].daily?.heartFrequency?.toDouble();

      if (heartFrequency != null) {
        chartData.add(FlSpot(i.toDouble(), heartFrequency));
      }
    }

    return chartData;
  }

  List<LineChartBarData> lineBarsData(List<FlSpot> spots) {
    return <LineChartBarData>[
      LineChartBarData(
        spots: spots,
        isCurved: true,
        color: Colors.red,
        barWidth: 4,
        isStrokeCapRound: true,
        belowBarData: BarAreaData(show: false),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    List<FlSpot> lineChartData = prepareLineChartData(data);

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LineChart(
              LineChartData(
                lineBarsData: lineBarsData(lineChartData),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 7,
                minY: 0,
                maxY: 150,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Transform.scale(
              scale: 1.1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: theme.blue!, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
