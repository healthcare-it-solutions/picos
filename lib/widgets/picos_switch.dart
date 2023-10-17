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

/// Creates a switch for [bool] values;
class PicosSwitch extends StatefulWidget {
  /// Creates a PicosSwitch.
  const PicosSwitch({
    required this.onChanged,
    Key? key,
    this.initialValue,
    this.title,
    this.shape,
  }) : super(key: key);

  /// The initial value.
  final bool? initialValue;

  /// The function to be called on changing values.
  final void Function(bool value)? onChanged;

  /// Switch title.
  final String? title;

  /// Switch shape.
  final ShapeBorder? shape;

  @override
  State<PicosSwitch> createState() => _PicosSwitchState();
}

class _PicosSwitchState extends State<PicosSwitch> {
  bool _value = false;

  @override
  void initState() {
    super.initState();

    if (widget.initialValue != null) {
      _value = widget.initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _value,
      onChanged: widget.onChanged == null
          ? null
          : (bool value) {
              setState(() {
                _value = value;
              });

              widget.onChanged!(value);
            },
      title: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Text(
          widget.title ?? '',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      shape: widget.shape,
    );
  }
}
