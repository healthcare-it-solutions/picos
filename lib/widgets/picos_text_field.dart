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
    this.onChanged,
    Key? key,
    this.disabled = false,
    this.hint = '',
    this.obscureText = false,
    this.autofocus = false,
    this.onTap,
    this.readOnly = false,
    this.height = 55,
    this.maxLines = 1,
    this.contentPadding,
    this.suffixIcon,
    this.initialValue,
    this.keyboardType,
    this.maxLength,
    this.controller,
  }) : super(key: key);

  /// Determines if the text field is disabled.
  final bool disabled;

  /// The hint shown in the text field.
  final String hint;

  /// Determines if content of text field is shown or not (e.g. passwords).
  final bool obscureText;

  /// Determines if the text field should focus itself.
  final bool autofocus;

  /// The function that is executed when the user writes something.
  final Function(String)? onChanged;

  /// The function that is executed when the user taps the field.
  final Function()? onTap;

  /// Whether the text can be changed.
  final bool readOnly;

  /// The text field height.
  final double height;

  /// The maximum number of lines shown.
  final int maxLines;

  /// The padding for the content.
  final EdgeInsetsGeometry? contentPadding;

  /// The suffix icon within the text field. 
  final IconButton? suffixIcon;

  /// Populates the field with an initial value.
  final String? initialValue;

  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;

  /// The maximum number of characters (Unicode scalar values) to allow in the
  /// text field.
  final int? maxLength;

  /// Contains controller for further submissions.
  final TextEditingController? controller;

  static final BorderRadius _borderRadius = BorderRadius.circular(7);

  double _calcHeight() {
    if (maxLength != null) {
      return height + 20;
    }

    return height;
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: _borderRadius,
      borderSide: BorderSide(
        color: Colors.grey.shade400,
      ),
    );

    return Container(
      padding: const EdgeInsets.all(4),
      width: double.infinity,
      height: _calcHeight(),
      child: TextFormField(
        cursorColor: Theme.of(context).focusColor,
        enabled: !disabled,
        decoration: InputDecoration(
          enabledBorder: border,
          border: border,
          focusedBorder: OutlineInputBorder(
            borderRadius: _borderRadius,
            borderSide: BorderSide(
              color: Theme.of(context).focusColor,
              width: 2.5,
            ),
          ),
          hintText: hint,
          contentPadding: contentPadding ?? EdgeInsets.only(
            bottom: height / 2,
            left: 15,
            right: 15,
          ),
          suffixIcon: suffixIcon,
        ),
        obscureText: obscureText,
        autofocus: autofocus,
        onChanged: onChanged ?? (_) {},
        onTap: onTap ?? () {},
        readOnly: readOnly,
        maxLines: maxLines,
        initialValue: initialValue,
        keyboardType: keyboardType ?? TextInputType.text,
        maxLength: maxLength,
        controller: controller,
      ),
    );
  }
}
