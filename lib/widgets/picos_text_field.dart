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

/// A pre configured text field widget.
class PicosTextField extends StatelessWidget {
  /// Creates a text field.
  const PicosTextField({
    required this.onChanged,
    Key? key,
    this.disabled = false,
    this.hint = '',
    this.autofocus = false,
  }) : super(key: key);

  /// Determines if the text field is disabled.
  final bool disabled;

  /// The hint shown in the text field.
  final String hint;

  /// Determines if the text field should focus itself.
  final bool autofocus;

  /// The function hta is executed when the writes something.
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(7);

    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(
        color: Colors.grey.shade400,
      ),
    );

    const double textFieldHeight = 55;

    return Container(
      padding: const EdgeInsets.all(4),
      width: double.infinity,
      height: textFieldHeight,
      child: TextField(
        enabled: !disabled,
        decoration: InputDecoration(
          enabledBorder: border,
          border: border,
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: Theme.of(context).focusColor,
              width: 2.5,
            ),
          ),
          hintText: hint,
          contentPadding: const EdgeInsets.only(
            bottom: textFieldHeight / 2,
            left: 15,
            right: 15,
          ),
        ),
        autofocus: autofocus,
        onChanged: onChanged,
      ),
    );
  }
}
