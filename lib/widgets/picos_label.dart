import 'package:flutter/material.dart';

/// Creates a simple label.
class PicosLabel extends StatelessWidget {
  /// Creates the label.
  const PicosLabel({required this.label, Key? key}) : super(key: key);

  /// The label to be shown.
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
    );
  }
}
