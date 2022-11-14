import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../themes/global_theme.dart';
import '../../../widgets/picos_add_button_bar.dart';
import '../../../widgets/picos_body.dart';
import '../../../widgets/picos_ink_well_button.dart';

/// Shows a single page for the questionaire.
class QuestionairePage extends StatelessWidget {
  /// Creates QuestionairePage.
  const QuestionairePage({
    required this.child,
    Key? key,
    this.backFunction,
    this.nextFunction,
  }) : super(key: key);

  /// The body of the page.
  final PicosBody child;
  /// Function for getting a page back.
  final void Function()? backFunction;
  /// Function for getting the next page.
  final void Function()? nextFunction;

  @override
  Widget build(BuildContext context) {
    final String back = AppLocalizations.of(context)!.back;
    final String next = AppLocalizations.of(context)!.next;
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        child,
        PicosAddButtonBar(
          leftButton: PicosInkWellButton(
            padding: const EdgeInsets.only(
              left: 30,
              right: 13,
              top: 15,
              bottom: 10,
            ),
            text: back,
            onTap: backFunction ?? () {},
            buttonColor1: theme.grey3,
            buttonColor2: theme.grey1,
          ),
          rightButton: PicosInkWellButton(
            padding: const EdgeInsets.only(
              right: 30,
              left: 13,
              top: 15,
              bottom: 10,
            ),
            text: next,
            onTap: nextFunction ?? () {},
          ),
        )
      ],
    );
  }
}
