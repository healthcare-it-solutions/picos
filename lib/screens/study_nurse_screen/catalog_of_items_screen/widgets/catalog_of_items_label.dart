import 'package:flutter/material.dart';
import 'package:picos/widgets/picos_label.dart';

/// Reusable label for the catalog of items.
class CatalogOfItemsLabel extends StatelessWidget {
  /// Creates CatalogOfItemsLabel
  const CatalogOfItemsLabel(
    this.label, {
    Key? key,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  /// The label to be shown.
  final String label;

  /// Custom font weight.
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return PicosLabel(
      label,
      fontSize: 15,
      fontWeight: fontWeight,
    );
  }
}
