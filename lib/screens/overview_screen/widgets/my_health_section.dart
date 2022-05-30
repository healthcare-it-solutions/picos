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

/// Widget which displays health-related information
class MyHealthSection extends StatelessWidget {
  // ignore: public_member_api_docs
  const MyHealthSection({Key? key}) : super(key: key);

  // final double h = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Meine Gesundheit',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          // This is a horizontal line
          // be my guest to make it better if you know how
          SizedBox(
            height: 1,
            child: Container(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                Container(
                  color: Colors.lime,
                  width: 180,
                  height: 180,
                ),
                Container(
                  color: Colors.black26,
                  width: 180,
                  height: 180,
                ),
                Container(
                  color: Colors.black45,
                  width: 180,
                  height: 180,
                ),
                Container(
                  color: Colors.black87,
                  width: 180,
                  height: 180,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
