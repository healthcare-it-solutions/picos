import 'package:flutter/material.dart';

/// Creates a simple label.
class PicosLabel extends StatelessWidget {
  /// Creates the label.
  const PicosLabel(
    this.label, {
    this.fontSize = 17,
    Key? key,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  /// The label to be shown.
  final String label;

  /// The size of glyphs (in logical pixels) to use when painting the text.
  final double fontSize;

  /// The typeface thickness to use when painting the text (e.g., bold).
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      child: Text(
        label,
        style: TextStyle(fontWeight: fontWeight, fontSize: fontSize),
      ),
    );
  }
}
