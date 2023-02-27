import 'package:flutter/material.dart';
import 'package:picos/widgets/picos_label.dart';

/// Creates a card or a box for displaying any content inside of it.
class PicosDisplayCard extends StatelessWidget {
  /// PicosDisplayBox constructor.
  const PicosDisplayCard({
    required this.child,
    Key? key,
    this.label,
    this.padding,
  }) : super(key: key);

  /// The label of the box.
  final Widget? label;

  /// The content to be displayed.
  final Widget child;

  /// Possible custom padding.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              label ?? const PicosLabel(label: ''),
              const SizedBox(height: 15),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
