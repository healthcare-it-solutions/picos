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
import 'package:picos/themes/global_theme.dart';

/// the class for Tiles in the health section
class Tile extends StatelessWidget {
  /// Tile constructor
  const Tile({
    required this.imageName,
    required this.sectionName,
    required this.routeName,
    Key? key,
  }) : super(key: key);

  /// The path of the image is specified here.
  final String imageName;

  /// The name of the section is specified here.
  final String sectionName;

  /// The name of the route is specified here.
  final String routeName;

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    Color gradientColor1 = theme.green1!;
    Color gradientColor2 = theme.green2!;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        gradient: LinearGradient(
          colors: <Color>[
            gradientColor1,
            gradientColor2,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      width: 180 - (MediaQuery.of(context).size.width / 32),
      height: 180,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(routeName),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
                child: Image.asset(imageName),
              ),
            ),
            Flexible(
              flex: 2,
              child: Center(
                child: Text(
                  sectionName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
