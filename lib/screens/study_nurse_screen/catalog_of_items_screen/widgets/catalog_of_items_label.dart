import 'package:flutter/material.dart';
import 'package:picos/widgets/picos_label.dart';

/// Reusable label for the catalog of items.
class CatalogOfItemsLabel extends StatelessWidget {
  /// Creates CatalogOfItemsLabel
  const CatalogOfItemsLabel(this.label, {Key? key}) : super(key: key);

  /// The label to be shown.
  final String label;

  @override
  Widget build(BuildContext context) {
    return PicosLabel(label, fontSize: 15,);
  }
}
