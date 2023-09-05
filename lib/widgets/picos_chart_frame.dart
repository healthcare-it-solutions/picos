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

import 'package:flutter/material.dart';
import '../screens/home_screen/overview/widgets/graph_section.dart';
import '../themes/global_theme.dart';

///
class PicosChartFrame extends StatelessWidget {
  /// Creates the PicosBody.
  const PicosChartFrame({required this.chart, this.title, Key? key})
      : super(key: key);

  /// Creates a child Widget inside the PicosBody.
  final Widget chart;

  ///
  final String? title;

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    final DateTime now = DateTime.now();
    final DateTime sevenDayBefore = now.subtract(const Duration(days: 7));
    return Stack(
      children: <Widget>[
        chart,
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Transform.scale(
              scaleX: 1.1,
              scaleY: 1.5,
              child: Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: theme.blue!, width: ChartHelper.width),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 5, // Adjust as needed
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: theme.blue!,
                    width: ChartHelper.width,
                  ),
                ),
              ),
              padding: const EdgeInsets.only(bottom: 1.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '$title  ${sevenDayBefore.day.toString().padLeft(2, '0')}.'
                  '${sevenDayBefore.month.toString().padLeft(2, '0')}.'
                  '${sevenDayBefore.year}-${now.day.toString().padLeft(2, '0')}'
                  '.${now.month.toString().padLeft(2, '0')}.${now.year}',
                  style: TextStyle(
                    color: theme.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 100, // Adjust as needed
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: theme.blue!,
                    width: ChartHelper.width,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
