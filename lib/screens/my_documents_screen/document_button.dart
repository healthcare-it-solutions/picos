/*   This file is part of Picos, a health tracking mobile app
*    Copyright (C) 2022 Healthcare IT Solutions GmbH
*
*    This program is free software: you can redistribute it and/or modify
*    it under the terms of the GNU General Public License as published by
*    the Free Software Foundation, either version 3 of the License, or
*    (at your option) any later version.
*
*    This program is distributed in the hope that it will be useful,
*    but WITHOUT ANY WARRANTY; without even the implied warranty of
*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*    GNU General Public License for more details.
*
*    You should have received a copy of the GNU General Public License
*    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:flutter/material.dart';

import '../../themes/global_theme.dart';
import 'package:picos/gen_l10n/app_localizations.dart';

/// Creates a light blue form button.
class DocumentButton extends StatefulWidget {
  /// DocumentButton constructor.
  const DocumentButton({Key? key, this.onPressed, this.title})
      : super(key: key);

  /// The action happening when pressing the button.
  final Future<bool> Function()? onPressed;

  /// A title for the button.
  final String? title;

  @override
  State<DocumentButton> createState() => _DocumentButtonState();
}

class _DocumentButtonState extends State<DocumentButton> {
  static String? _uploadDocument;
  static String? _documentSelected;

  //State.
  String buttonTitle = '';

  void setButtonTitle() {
    if (buttonTitle.isNotEmpty) {
      return;
    }

    if (widget.title == null) {
      buttonTitle = _uploadDocument!;
      return;
    }

    buttonTitle = widget.title!;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    if (_uploadDocument == null) {
      _uploadDocument = AppLocalizations.of(context)!.uploadDocument;
      _documentSelected = AppLocalizations.of(context)!.documentSelected;
    }

    setButtonTitle();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: () async {
          if (widget.onPressed == null) {
            return;
          }

          if (await widget.onPressed!()) {
            setState(() {
              buttonTitle = _documentSelected!;
            });
          }
        },
        style: TextButton.styleFrom(
          backgroundColor: theme.cardButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        child: SizedBox(
          height: 32,
          width: double.infinity,
          child: Center(
            child: Text(
              buttonTitle,
              style: TextStyle(color: theme.grey1),
            ),
          ),
        ),
      ),
    );
  }
}
