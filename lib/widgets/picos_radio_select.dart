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

/// A ready to use list with selectable RadioListTiles.
class PicosRadioSelect extends StatefulWidget {
  /// Creates PicosRadioSelect.
  const PicosRadioSelect({
    required this.selection,
    required this.callBack,
    Key? key,
  }) : super(key: key);

  /// The Map of selectable items. [String] is what you will see and [dynamic]
  /// is the technical value used behind the scenes.
  final Map<String, dynamic> selection;

  /// The function that is executed when an item gets selected.
  final Function(dynamic value) callBack;

  @override
  State<PicosRadioSelect> createState() => _PicosRadioSelectState();
}

class _PicosRadioSelectState extends State<PicosRadioSelect> {
  dynamic _selectValue;

  List<RadioListTile<dynamic>> _createItemList() {
    return widget.selection.entries.map<RadioListTile<dynamic>>(
      (MapEntry<String, dynamic> element) {
        return RadioListTile<dynamic>(
          title: Text(element.key),
          value: element.value,
          groupValue: _selectValue,
          onChanged: (dynamic newValue) {
            setState(() {
              widget.callBack(newValue);
              _selectValue = newValue;
            });
          },
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _createItemList(),
    );
  }
}
