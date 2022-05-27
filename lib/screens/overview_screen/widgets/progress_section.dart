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

class ProgressSection extends StatelessWidget {
  const ProgressSection({Key? key}) : super(key: key);

  final double progressPercentage = 0.95;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text('lorem ipsum dolor sit amet',
                  style: TextStyle(color: Colors.white)),
              ConstrainedBox(
                constraints:
                    const BoxConstraints(minHeight: 20, maxHeight: 100),
              ),
              ElevatedButton(
                  child: const Text('PLACEHOLDER'), onPressed: () => null)
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              const SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                      color: Colors.amber, value: 0.96)),
              Text(
                (progressPercentage * 100).round().toString() + ' %',
                style: const TextStyle(color: Colors.white),
                textScaleFactor: 2,
              )
            ],
          ),
        ],
      ),
    );
  }
}
