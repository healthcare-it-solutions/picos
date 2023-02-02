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

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/widgets/picos_body.dart';

import '../../../themes/global_theme.dart';
import '../../../widgets/picos_add_button_bar.dart';
import '../../../widgets/picos_ink_well_button.dart';

/// A cover for the different sections of the questionaire.
class Cover extends StatelessWidget {
  /// Constructs the cover page.
  const Cover({
    this.title = '',
    this.image = '',
    this.infoText,
    Key? key,
    this.backFunction,
    this.nextFunction,
  }) : super(key: key);

  /// The title cover.
  final String title;

  /// Contains the annotation for the image.
  final String image;

  /// Contains the info text for the end screen.
  final List<InlineSpan>? infoText;

  /// Function for getting a page back.
  final void Function()? backFunction;

  /// Function for getting the next page.
  final void Function()? nextFunction;

  @override
  Widget build(BuildContext context) {
    final String back = AppLocalizations.of(context)!.back;
    final String next = AppLocalizations.of(context)!.next;
    final String start = AppLocalizations.of(context)!.letsStart;
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    final double height = MediaQuery.of(context).size.height -
        kToolbarHeight -
        MediaQuery.of(context).viewPadding.top;
    double sizedBoxHeight = height / 10;
    double fontSize = 30;

    Widget picosBody = GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: PicosBody(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: height / 8,
            ),
            Image(
              image: AssetImage(image),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: sizedBoxHeight,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.white,
                          height: 2,
                        ),
                        children: infoText,
                      ),
                    ),
                  ),
                  const Positioned(
                    top: -22,
                    right: 20,
                    child: Image(
                      image: AssetImage('assets/Tipp.png'),
                      height: 50,
                      width: 50,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    if (backFunction == null && nextFunction != null) {
      sizedBoxHeight = height / 3;
      fontSize = 40;
      picosBody = PicosBody(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: height / 8,
            ),
            Image(
              image: AssetImage(image),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: sizedBoxHeight,
            ),
            PicosInkWellButton(
              text: start,
              onTap: nextFunction!,
            ),
          ],
        ),
      );
    } else if (backFunction != null || nextFunction != null) {
      if (title == AppLocalizations.of(context)!.medicationAndTherapy) {
        sizedBoxHeight = height / 3.7;
      } else {
        sizedBoxHeight = height / 3;
      }
      fontSize = 40;
      picosBody = PicosBody(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: height / 8,
            ),
            Image(
              image: AssetImage(image),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: sizedBoxHeight,
            ),
            PicosAddButtonBar(
              shadows: false,
              leftButton: PicosInkWellButton(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 13,
                  top: 15,
                  bottom: 10,
                ),
                text: back,
                onTap: backFunction!,
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
                onTap: nextFunction!,
              ),
            )
          ],
        ),
      );
    }

    return Container(
      height: height,
      color: theme.darkGreen1,
      child: picosBody,
    );
  }
}
