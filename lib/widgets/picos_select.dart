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

/// A pre configured selection widget.
class PicosSelect extends StatefulWidget {
  /// Creates a select-dropdown-widget.
  const PicosSelect({
    required this.selection,
    required this.callBackFunction,
    Key? key,
    this.hint,
    this.disabled = false,
  }) : super(key: key);

  /// The array of items selectable in the dropdown.
  final List<String> selection;

  /// The function that is executed when an item gets selected.
  final Function(String value) callBackFunction;

  /// The hint shown in the select.
  final String? hint;

  /// Determines if the select box is disabled.
  final bool disabled;

  @override
  State<PicosSelect> createState() => _PicosSelectState();
}

class _PicosSelectState extends State<PicosSelect> {
  String? _dropdownValue;

  List<DropdownMenuItem<String>> _createItemList() {
    return widget.selection
        .map<DropdownMenuItem<String>>(
          (String e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(7);

    Color borderColor = Colors.grey.shade400;

    Border border = Border.all(color: borderColor);

    if (widget.disabled) {
      borderColor = Theme.of(context).disabledColor;
      border = Border.all(
        color: borderColor,
        width: 0.35,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(4),
      child: AbsorbPointer(
        absorbing: widget.disabled,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: border,
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
                borderRadius: borderRadius,
                value: _dropdownValue,
                iconSize: 30,
                icon: const Icon(Icons.keyboard_arrow_down),
                hint: Text(widget.hint ?? ''),
                onChanged: (String? newValue) {
                  setState(() {
                    final String value = newValue ?? '';

                    widget.callBackFunction(value);
                    _dropdownValue = value;
                  });
                },
                items: _createItemList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
