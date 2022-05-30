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
