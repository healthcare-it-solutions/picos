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
import 'package:flutter_svg/svg.dart';

import '../themes/global_theme.dart';

/// Instantiates a widget that renders an SVG picture from an AssetBundle.
class PicosSvgIcon extends StatelessWidget {
  /// PicosSvgIcon constructor.
  const PicosSvgIcon({
    required this.assetName,
    Key? key,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);

  /// Path to the asset.
  final String assetName;

  /// If specified, the height to use for the SVG. If unspecified, the SVG will
  /// take the height of its parent.
  final double? height;

  /// If specified, the height to use for the SVG. If unspecified, the SVG will
  /// take the width of its parent.
  final double? width;

  /// Color for the colorFilter.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return SvgPicture.asset(
      assetName,
      height: height,
      width: width,
      colorFilter:
          ColorFilter.mode(color ?? theme.darkGreen1!, BlendMode.srcIn),
    );
  }
}
