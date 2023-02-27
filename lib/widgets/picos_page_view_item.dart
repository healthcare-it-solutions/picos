import 'package:flutter/material.dart';
import 'package:picos/widgets/picos_add_button_bar.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_ink_well_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../themes/global_theme.dart';

/// Creates a standardized page item.
class PicosPageViewItem extends StatelessWidget {
  /// PicosPageViewItem constructor.
  const PicosPageViewItem({
    required this.child,
    Key? key,
    this.leftFunction,
    this.rightFunction,
    this.leftButtonTitle,
    this.rightButtonTitle,
  }) : super(key: key);

  /// The body of the page.
  final Widget child;

  /// Function for the left button.
  final void Function()? leftFunction;

  /// Function for the right button.
  final void Function()? rightFunction;

  /// Title of the left button.
  final String? leftButtonTitle;

  /// Title of the right button.
  final String? rightButtonTitle;

  // Strings
  static String? _back;
  static String? _next;
  static GlobalTheme? _theme;

  @override
  Widget build(BuildContext context) {
    if (_theme == null) {
      _back = AppLocalizations.of(context)!.back;
      _next = AppLocalizations.of(context)!.next;
      _theme = Theme.of(context).extension<GlobalTheme>()!;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: PicosBody(
            child: child,
          ),
        ),
        PicosAddButtonBar(
          leftButton: PicosInkWellButton(
            padding: const EdgeInsets.only(
              left: 30,
              right: 13,
              top: 15,
              bottom: 10,
            ),
            text: leftButtonTitle ?? _back!,
            onTap: leftFunction ?? () {},
            buttonColor1: _theme!.grey3,
            buttonColor2: _theme!.grey1,
          ),
          rightButton: PicosInkWellButton(
            padding: const EdgeInsets.only(
              right: 30,
              left: 13,
              top: 15,
              bottom: 10,
            ),
            text: rightButtonTitle ?? _next!,
            onTap: rightFunction ?? () {},
          ),
        )
      ],
    );
  }
}
