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
import 'package:picos/widgets/picos_display_card.dart';
import 'package:picos/widgets/picos_info_card.dart';
import 'package:picos/widgets/picos_page_view_item.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/widgets/picos_text_field.dart';

import '../../util/page_view_navigation.dart';

/// Displays a form for filling in hospital and doctors visits.
class VisitsScreen extends StatelessWidget with PageViewNavigation {
  /// Creates StaysScreen
  VisitsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildContext = context;

    pages.add(
      PicosPageViewItem(
        leftFunction: previousPage,
        rightFunction: nextPage,
        child: Column(
          children: <Widget>[
            PicosInfoCard(
              infoText: RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context)!.visitInfoPart1,
                  style: const TextStyle(
                    color: PicosInfoCard.infoTextFontColor,
                    fontSize: PicosInfoCard.infoTextFontSize,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: AppLocalizations.of(context)!.visitInfoPart2,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.visitInfoPart3,
                    ),
                  ],
                ),
              ),
            ),
            PicosDisplayCard(
              child: const PicosTextField(),
            ),
          ],
        ),
      ),
    );
    pages.add(PicosPageViewItem(
      leftFunction: previousPage,
      rightFunction: nextPage,
      child: const Text('fdas'),
    ),);
    pages.add(
      PicosPageViewItem(
        leftFunction: previousPage,
        rightFunction: nextPage,
        rightButtonTitle: AppLocalizations.of(context)!.save,
        child: const Text('hjmgfjkrz'),
      ),
    );

    return PicosScreenFrame(
      title: AppLocalizations.of(context)!.visits,
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
    );
  }
}
