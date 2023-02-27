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
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_page_view_item.dart';
import 'package:picos/widgets/picos_radio_select.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../themes/global_theme.dart';
import '../../util/page_view_navigation.dart';
import '../../widgets/picos_add_button_bar.dart';
import '../../widgets/picos_ink_well_button.dart';

/// Displays a form for filling in hospital and doctors visits.
class VisitsScreen extends StatefulWidget {
  /// Creates StaysScreen
  const VisitsScreen({Key? key}) : super(key: key);

  @override
  State<VisitsScreen> createState() => _VisitsScreenState();
}

class _VisitsScreenState extends State<VisitsScreen> with PageViewNavigation {
  static Map<String, String>? _unscheduledSelection;

  static String? _back;
  static String? _next;
  static String? _title;
  static String? _visitInfo1;
  static String? _visitInfo2;
  static String? _visitInfo3;
  static String? _iWasUnscheduled;

  static GlobalTheme? _theme;

  //input
  String? _unplanned;

  //state
  bool _nextDisabled = true;

  PicosPageViewItem _buildRecordingPage() {
    if (_unplanned == 'Hospital') {
      return const PicosPageViewItem(
        child: Text('Krankenhaus'),
      );
    }

    return const PicosPageViewItem(
      child: Text('Arzt'),
    );
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;

    if (_theme == null) {
      _back = AppLocalizations.of(context)!.back;
      _next = AppLocalizations.of(context)!.next;
      _title = AppLocalizations.of(context)!.visits;
      _visitInfo1 = AppLocalizations.of(context)!.visitInfoPart1;
      _visitInfo2 = AppLocalizations.of(context)!.visitInfoPart2;
      _visitInfo3 = AppLocalizations.of(context)!.visitInfoPart3;
      _iWasUnscheduled = AppLocalizations.of(context)!.iWasUnscheduled;
      _theme = Theme.of(context).extension<GlobalTheme>()!;

      _unscheduledSelection = <String, String>{
        AppLocalizations.of(context)!.toSeeAResidentPhysician: 'Physician',
        AppLocalizations.of(context)!.inAHospital: 'Hospital'
      };
    }

    if (pages.isEmpty) {
      pages = <PicosPageViewItem>[
        PicosPageViewItem(
          child: Column(
            children: <Widget>[
              PicosInfoCard(
                infoText: RichText(
                  text: TextSpan(
                    text: _visitInfo1,
                    style: const TextStyle(
                      color: PicosInfoCard.infoTextFontColor,
                      fontSize: PicosInfoCard.infoTextFontSize,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: _visitInfo2,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: _visitInfo3,
                      ),
                    ],
                  ),
                ),
              ),
              PicosDisplayCard(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 0,
                ),
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: PicosLabel(
                    label: _iWasUnscheduled!,
                  ),
                ),
                child: PicosRadioSelect(
                  selection: _unscheduledSelection!,
                  callBack: (dynamic value) {
                    setState(() {
                      _nextDisabled = false;
                    });

                    _unplanned = value;
                    if (pages.length == 1) {
                      pages.add(_buildRecordingPage());
                      return;
                    }
                    pages[1] = _buildRecordingPage();
                  },
                ),
              ),
            ],
          ),
        ),
      ];
    }

    return PicosScreenFrame(
      title: _title!,
      body: PageView.builder(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return pages[index];
        },
      ),
      bottomNavigationBar: PicosAddButtonBar(
        leftButton: PicosInkWellButton(
          padding: const EdgeInsets.only(
            left: 30,
            right: 13,
            top: 15,
            bottom: 10,
          ),
          text: _back!,
          onTap: previousPage,
          buttonColor1: _theme!.grey3,
          buttonColor2: _theme!.grey1,
        ),
        rightButton: PicosInkWellButton(
          disabled: _nextDisabled,
          padding: const EdgeInsets.only(
            right: 30,
            left: 13,
            top: 15,
            bottom: 10,
          ),
          text: _next!,
          onTap: nextPage,
        ),
      ),
    );
  }
}
