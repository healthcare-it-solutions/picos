import 'package:flutter/material.dart';

/// Creates a simple label.
class PicosLabel extends StatelessWidget {
  /// Creates the label.
  const PicosLabel({required this.label, this.fontSize = 17, Key? key})
      : super(key: key);

  /// The label to be shown.
  final String label;

  /// The size of glyphs (in logical pixels) to use when painting the text.
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
      ),
    );
  }
}
