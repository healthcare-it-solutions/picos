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
import 'package:picos/widgets/picos_display_card.dart';
import 'package:picos/widgets/picos_label.dart';

/// Shows a page for the [CatalogOfItemsScreen].
class CatalogOfItemsPage extends StatelessWidget {
  /// CatalogOfItemsPage constructor.
  const CatalogOfItemsPage({Key? key, this.title, this.children, this.padding})
      : super(key: key);

  /// The shown title on the page card.
  final String? title;

  /// The single items for the catalog of items.
  final List<Widget>? children;

  /// Defines a custom padding that deviates from the standard.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    String labelString = title ?? '';
    Widget label = PicosLabel(labelString);

    if (padding != null) {
      label = Padding(
        padding: const EdgeInsets.only(top: 15, left: 15).subtract(padding!),
        child: label,
      );
    }

    return PicosDisplayCard(
      padding: padding,
      child: Column(
        children: <Widget>[
          label,
          Column(
            children: children ?? <Widget>[],
          )
        ],
      ),
    );
  }
}
