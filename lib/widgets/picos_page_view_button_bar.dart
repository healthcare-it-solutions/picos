import 'package:flutter/material.dart';
import 'package:picos/widgets/picos_add_button_bar.dart';
import 'package:picos/widgets/picos_ink_well_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../themes/global_theme.dart';

/// A standardized button bar for [PageViewNavigation].
class PicosPageViewButtonBar extends StatelessWidget {
  /// Creates PicosPageViewButtonBar.
  const PicosPageViewButtonBar({
    Key? key,
    this.nextPage,
    this.previousPage,
    this.nextTitle,
    this.previousTitle,
  }) : super(key: key);

  /// Function for the next page button.
  final void Function()? nextPage;

  /// Function for the previous page button.
  final void Function()? previousPage;

  /// Defines a custom title for the next button.
  final String? nextTitle;

  /// Defines a custom title for the previous button.
  final String? previousTitle;

  static GlobalTheme? _theme;
  static String? _back;
  static String? _next;

  @override
  Widget build(BuildContext context) {
    if (_theme == null) {
      _theme = Theme.of(context).extension<GlobalTheme>()!;

      _back = AppLocalizations.of(context)!.back;
      _next = AppLocalizations.of(context)!.next;
    }

    return PicosAddButtonBar(
      leftButton: PicosInkWellButton(
        padding: const EdgeInsets.only(
          left: 30,
          right: 13,
          top: 15,
          bottom: 10,
        ),
        text: previousTitle ?? _back!,
        onTap: previousPage ?? () {},
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
        text: nextTitle ?? _next!,
        onTap: nextPage ?? () {},
      ),
    );
  }
}
