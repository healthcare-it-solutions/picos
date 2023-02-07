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
import 'package:picos/screens/questionaire_screen/widgets/questionaire_card.dart';
import 'package:picos/widgets/picos_radio_select.dart';

import '../../../widgets/picos_label.dart';

/// An input card with an radio button selection.
class RadioSelectCard extends StatelessWidget {
  /// Creates a RadioSelectCard.
  const RadioSelectCard({
    required this.options,
    required this.callback,
    Key? key,
    this.label = const PicosLabel(label: ''),
    this.description = '',
  }) : super(key: key);

  /// The label for the card.
  final Widget label;

  /// An optional description for the selection.
  final String description;

  /// The Map of selectable items. [String] is what you will see
  /// and [dynamic] is the technical value used behind the scenes.
  final Map<String, dynamic> options;

  /// The function that is executed when an item gets selected.
  final Function(dynamic value) callback;

  static const double _horizontalPadding = 15;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[];

    if (description.isNotEmpty) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
          child: PicosLabel(label: description, fontSize: 15),
        ),
      );
      children.add(const SizedBox(height: 15));
    }

    children.add(
      PicosRadioSelect(
        selection: options,
        callBack: callback,
      ),
    );

    return QuestionaireCard(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 0,
      ),
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: label,
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
