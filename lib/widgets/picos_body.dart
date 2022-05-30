import 'package:flutter/material.dart';

/// A body with preconfigured padding for using on non scrollable screens.
class PicosBody extends StatelessWidget {
  /// Creates the PicosBody.
  const PicosBody({required this.child, Key? key}) : super(key: key);

  /// Creates a child Widget inside the PicosBody.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: child,
      padding: const EdgeInsets.all(10),
    );
  }
}
