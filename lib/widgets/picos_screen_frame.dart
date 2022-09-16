import 'package:flutter/material.dart';

import '../themes/global_theme.dart';

/// Creates a standardized frame useful for most picos screens.
class PicosScreenFrame extends StatelessWidget {
  /// Creates PicosScreenFrame.
  const PicosScreenFrame({
    Key? key,
    this.bottomNavigationBar,
    this.title,
    this.body,
  }) : super(key: key);

  /// A Navigation bar displayed at the bottom.
  final Widget? bottomNavigationBar;
  /// The title of the screen.
  final String? title;
  /// The content inside the frame to display.
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return Container(
      color: theme.darkGreen1,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: bottomNavigationBar,
          appBar: AppBar(
            centerTitle: true,
            title: Text(title ?? ''),
          ),
          body: body,
        ),
      ),
    );
  }
}
