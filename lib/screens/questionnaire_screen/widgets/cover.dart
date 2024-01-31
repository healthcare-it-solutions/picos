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
import 'package:picos/themes/global_theme.dart';
import 'package:picos/widgets/picos_svg_icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'questionnaire_page.dart';

/// A cover for the different sections of the questionaire.
class Cover extends StatelessWidget {
  /// Constructs the cover page.
  const Cover({
    required this.title,
    required this.image,
    required this.backFunction,
    required this.nextFunction,
    this.textNext,
    this.healthTip,
    Key? key,
  }) : super(key: key);

  /// The title cover.
  final String title;

  /// Contains the annotation for the image.
  final String image;

  /// Function for getting a page back.
  final void Function()? backFunction;

  /// Function for getting the next page.
  final void Function()? nextFunction;

  /// The text for the "Next"-Button.
  final String? textNext;

  /// Random tip for health.
  final String? healthTip;

  @override
  Widget build(BuildContext context) {
    double? height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        kToolbarHeight;
    double? width = MediaQuery.of(context).size.width;
    double? fontSize = 30;

    String titleTips = AppLocalizations.of(context)!.tips;

    GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return QuestionairePage(
      nextFunction: nextFunction,
      backFunction: backFunction,
      textNext: textNext ?? '',
      color: theme.darkGreen1!,
      child: SizedBox(
        width: width,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: height / 8,
            ),
            PicosSvgIcon(
              assetName: image,
              height: 200,
              width: 175,
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
            healthTip != null
                ? SizedBox(
                    height: height / 10,
                  )
                : const SizedBox.shrink(),
            healthTip != null
                ? Container(
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
                              children: <TextSpan>[
                                TextSpan(
                                  text: '$titleTips\n',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: healthTip,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Positioned(
                          top: -20,
                          right: 20,
                          child: PicosSvgIcon(
                            assetName: 'assets/Tipp.svg',
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
