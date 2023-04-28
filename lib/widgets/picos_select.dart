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
    this.validator,
    this.initialValue,
  }) : super(key: key);

  /// The array of items selectable in the dropdown.
  final Map<String, String> selection;

  /// The function that is executed when an item gets selected.
  final Function(String value) callBackFunction;

  /// The hint shown in the select.
  final String? hint;

  /// Determines if the select box is disabled.
  final bool disabled;

  /// The function that is executed when the validator is triggered.
  final String? Function(String? value)? validator;

  /// An item that is optionally preselected.
  final String? initialValue;

  @override
  State<PicosSelect> createState() => _PicosSelectState();
}

class _PicosSelectState extends State<PicosSelect> {
  String? _dropdownValue;

  List<DropdownMenuItem<String>> _createItemList() {
    List<DropdownMenuItem<String>> dropdownMenuItems =
        <DropdownMenuItem<String>>[];

    widget.selection.forEach((String key, dynamic value) {
      dropdownMenuItems
          .add(DropdownMenuItem<String>(value: key, child: Text(value)));
    });

    return dropdownMenuItems;
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.grey.shade400;
    final BorderRadius borderRadius = BorderRadius.circular(7);

    if (widget.initialValue != null) {
      _dropdownValue = widget.initialValue;
    }

    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor,
      ),
      borderRadius: borderRadius,
    );

    OutlineInputBorder errorInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
      ),
      borderRadius: borderRadius,
    );

    if (widget.disabled) {
      borderColor = Theme.of(context).disabledColor;
      outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.35,
          color: borderColor,
        ),
        borderRadius: borderRadius,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(4),
      child: AbsorbPointer(
        absorbing: widget.disabled,
        child: ButtonTheme(
          alignedDropdown: true,
          child: SizedBox(
            height: widget.validator == null ? null : 75,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                  right: 10,
                ),
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                errorBorder: errorInputBorder,
                focusedErrorBorder: errorInputBorder,
              ),
              borderRadius: borderRadius,
              value: _dropdownValue,
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
              validator: widget.validator,
            ),
          ),
        ),
      ),
    );
  }
}
