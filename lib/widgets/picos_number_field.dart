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
import 'package:flutter/services.dart';
import 'package:picos/widgets/picos_text_field.dart';

/// Creates a text field for entering a number.
class PicosNumberField extends StatelessWidget {
  /// Creates PicosNumberField.
  const PicosNumberField({
    this.hint = '',
    Key? key,
    this.initialValue,
    this.onChanged,
    this.digitsOnly = false,
  }) : super(key: key);

  /// Initial value.
  final String? initialValue;

  /// Hint shown when empty.
  final String hint;

  /// Callback function when the value changes.
  final dynamic Function(String value)? onChanged;

  /// If true prevents [double]. Only [int].
  final bool digitsOnly;

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatter = <TextInputFormatter>[];

    if (digitsOnly) {
      inputFormatter = <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ];
    }

    return PicosTextField(
      onChanged: onChanged,
      initialValue: initialValue,
      hint: hint,
      inputFormatters: inputFormatter,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
    );
  }
}
