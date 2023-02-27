import 'package:flutter/material.dart';

/// Creates a card or a box for displaying any content inside of it.
class PicosDisplayCard extends StatelessWidget {
  /// PicosDisplayBox constructor.
  PicosDisplayCard({
    required this.child,
    Key? key,
    this.label,
    this.padding,
    this.backgroundColor,
  }) : super(key: key);

  /// The label of the box.
  final Widget? label;

  /// The content to be displayed.
  final Widget child;

  /// Possible custom padding.
  final EdgeInsetsGeometry? padding;

  /// The card's background color.
  final Color? backgroundColor;

  final List<Widget> _children = <Widget>[];

  @override
  Widget build(BuildContext context) {
    if (label != null) {
      _children.add(label!);
      _children.add(const SizedBox(height: 15));
    }

    _children.add(child);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _children,
          ),
        ),
      ),
    );
  }
}
