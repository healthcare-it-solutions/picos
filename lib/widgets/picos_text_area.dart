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
import 'package:picos/widgets/picos_text_field.dart';

/// A pre configured text field widget for a text area.
class PicosTextArea extends StatelessWidget {
  /// Creates a text field.
  const PicosTextArea({
    this.onChanged,
    Key? key,
    this.disabled = false,
    this.hint = '',
    this.autofocus = false,
    this.onTap,
    this.validator,
    this.readOnly = false,
    this.maxLines = 5,
    this.initialValue,
  }) : super(key: key);

  /// Determines if the text field is disabled.
  final bool disabled;

  /// The hint shown in the text field.
  final String hint;

  /// Determines if the text field should focus itself.
  final bool autofocus;

  /// The function that is executed when the user writes something.
  final Function(String value)? onChanged;

  /// The function that is executed when the user taps the field.
  final Function()? onTap;

  /// The function that is responsible for validation.
  final String? Function(String?)? validator;

  /// Whether the text can be changed.
  final bool readOnly;

  /// The maximum number of lines shown.
  final int maxLines;

  /// Populates the field with an initial value.
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return PicosTextField(
      maxLines: maxLines,
      height: maxLines * 24,
      readOnly: readOnly,
      onTap: onTap,
      validator: validator,
      hint: hint,
      autofocus: autofocus,
      disabled: disabled,
      onChanged: onChanged,
      contentPadding: const EdgeInsets.only(
        bottom: 15,
        left: 15,
        right: 15,
      ),
      initialValue: initialValue,
    );
  }
}
