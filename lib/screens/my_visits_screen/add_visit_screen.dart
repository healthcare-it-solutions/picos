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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picos/api/backend_stays_api.dart';
import 'package:picos/state/objects_list_bloc.dart';
import 'package:picos/widgets/picos_display_card.dart';
import 'package:picos/widgets/picos_info_card.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_page_view_item.dart';
import 'package:picos/widgets/picos_radio_select.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/widgets/picos_text_area.dart';

import '../../models/stay.dart';
import '../../themes/global_theme.dart';
import '../../util/page_view_navigation.dart';
import '../../widgets/picos_add_button_bar.dart';
import '../../widgets/picos_date_picker.dart';
import '../../widgets/picos_ink_well_button.dart';

/// All options available for unscheduled visits.
enum VisitOptions {
  /// Unscheduled visit in a hospital.
  hospital,

  /// Unscheduled visit for a physician.
  physician,
}

/// Displays a form for filling in hospital and doctors visits.
class AddVisitScreen extends StatefulWidget {
  /// Creates StaysScreen
  const AddVisitScreen({Key? key}) : super(key: key);

  @override
  State<AddVisitScreen> createState() => _AddVisitScreenState();
}

class _AddVisitScreenState extends State<AddVisitScreen>
    with PageViewNavigation {
  static Map<String, VisitOptions>? _unscheduledSelection;

  static String? _back;
  static String? _next;
  static String? _title;
  static String? _visitInfo1;
  static String? _visitInfo2;
  static String? _visitInfo3;
  static String? _iWasUnscheduled;
  static String? _whenDidYouSeeThePhysician;
  static String? _whenWereYouInHospital;
  static String? _dayOfRecording;
  static String? _dayOfDischarge;
  static String? _save;
  static String? _reasonForVisitToTheDoctor;
  static String? _reasonForHospitalization;

  static GlobalTheme? _theme;

  static const double _hospitalFontSize = 15;
  static const FontWeight _hospitalFontWeight = FontWeight.normal;

  //input
  VisitOptions? _unplanned;
  DateTime? _record;
  DateTime? _discharge;
  String? _reason;

  //state
  final List<bool> _disabledNextPages = <bool>[true, true, true];
  bool _nextDisabled = true;
  String _recordHint = '';
  String _dischargeHint = '';
  String _rightButtonTitle = '';

  bool _checkHospitalDates() {
    if (_record == null || _discharge == null) {
      return false;
    }
    if (_record!.isAfter(_discharge!)) {
      return false;
    }
    return true;
  }

  _setSecondPageDisabled() {
    if (_unplanned == VisitOptions.hospital) {
      _disabledNextPages[1] = !_checkHospitalDates();
    }

    if (_unplanned == VisitOptions.physician) {
      _disabledNextPages[1] = false;
    }

    setState(() {
      _nextDisabled = _disabledNextPages[1];
    });
  }

  PicosPageViewItem _buildRecordingPage() {
    if (_record != null) {
      _recordHint = PicosDatePicker.formatDate(_record!);
    }

    if (_discharge != null) {
      _dischargeHint = PicosDatePicker.formatDate(_discharge!);
    }

    if (_unplanned == VisitOptions.hospital) {
      return PicosPageViewItem(
        child: PicosDisplayCard(
          label: PicosLabel(_whenWereYouInHospital!),
          child: Column(
            children: <Widget>[
              PicosLabel(
                _dayOfRecording!,
                fontSize: _hospitalFontSize,
                fontWeight: _hospitalFontWeight,
              ),
              PicosDatePicker(
                dateHint: _recordHint,
                callBackFunction: (DateTime value) {
                  _record = value;
                  _setSecondPageDisabled();
                },
              ),
              const SizedBox(height: 10),
              PicosLabel(
                _dayOfDischarge!,
                fontSize: _hospitalFontSize,
                fontWeight: _hospitalFontWeight,
              ),
              PicosDatePicker(
                dateHint: _dischargeHint,
                callBackFunction: (DateTime value) {
                  _discharge = value;
                  _setSecondPageDisabled();
                },
              ),
            ],
          ),
        ),
      );
    }

    return PicosPageViewItem(
      child: PicosDisplayCard(
        label: PicosLabel(_whenDidYouSeeThePhysician!),
        child: PicosDatePicker(
          dateHint: _recordHint,
          callBackFunction: (DateTime value) {
            _record = value;
            _setSecondPageDisabled();
          },
        ),
      ),
    );
  }

  void _nextPageCallback() {
    int currentPage = page.toInt() + 1;

    if (currentPage == pages.length) {
      if (_unplanned == VisitOptions.physician && _discharge != null) {
        _discharge = null;
      }

      context.read<ObjectsListBloc<BackendStaysApi>>().add(
            SaveObject(
              Stay(
                reason: _reason!,
                record: _record!,
                where: _unplanned!.name,
                discharge: _discharge,
              ),
            ),
          );
      return;
    }

    if (_unplanned == VisitOptions.hospital) {
      _disabledNextPages[1] = !_checkHospitalDates();
    }

    if (_unplanned == VisitOptions.physician && _record != null) {
      _disabledNextPages[1] = false;
    }

    setState(() {
      _nextDisabled = _disabledNextPages[currentPage];

      if (currentPage == pages.length - 1) {
        _rightButtonTitle = _save!;
      }
    });
  }

  void _previousPageCallback() {
    setState(() {
      if (page.toInt() >= 1) {
        _nextDisabled = _disabledNextPages[page.toInt() - 1];
      }

      if (_rightButtonTitle != _next) {
        _rightButtonTitle = _next!;
      }
    });
  }

  PicosPageViewItem _buildReasonPage() {
    String label = '';

    if (_unplanned == VisitOptions.hospital) {
      label = _reasonForHospitalization!;
    }

    if (_unplanned == VisitOptions.physician) {
      label = _reasonForVisitToTheDoctor!;
    }

    return PicosPageViewItem(
      child: PicosDisplayCard(
        label: PicosLabel(label),
        child: PicosTextArea(
          initialValue: _reason,
          maxLines: 20,
          onChanged: (String value) {
            _reason = value;
            _disabledNextPages[2] = _reason!.isEmpty;

            setState(() {
              _nextDisabled = _disabledNextPages[2];
            });
          },
        ),
      ),
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
      _whenDidYouSeeThePhysician =
          AppLocalizations.of(context)!.whenDidYouSeeThePhysician;
      _whenWereYouInHospital =
          AppLocalizations.of(context)!.whenWereYouInHospital;
      _dayOfRecording = AppLocalizations.of(context)!.dayOfRecording;
      _dayOfDischarge = AppLocalizations.of(context)!.dayOfDischarge;
      _save = AppLocalizations.of(context)!.save;
      _reasonForHospitalization =
          AppLocalizations.of(context)!.reasonForHospitalization;
      _reasonForVisitToTheDoctor =
          AppLocalizations.of(context)!.reasonForVisitToTheDoctor;

      _theme = Theme.of(context).extension<GlobalTheme>()!;

      _unscheduledSelection = <String, VisitOptions>{
        AppLocalizations.of(context)!.toSeeAResidentPhysician:
            VisitOptions.physician,
        AppLocalizations.of(context)!.inAHospital: VisitOptions.hospital,
      };
    }

    if (pages.isEmpty) {
      _rightButtonTitle = _next!;

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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: PicosLabel(_iWasUnscheduled!),
                ),
                child: PicosRadioSelect(
                  selection: _unscheduledSelection!,
                  callBack: (dynamic value) {
                    _disabledNextPages[0] = false;

                    setState(() {
                      _nextDisabled = _disabledNextPages[0];
                    });

                    _unplanned = value;
                    if (pages.length == 1) {
                      pages.add(_buildRecordingPage());
                      pages.add(_buildReasonPage());
                      return;
                    }
                    pages[1] = _buildRecordingPage();
                    pages[2] = _buildReasonPage();
                  },
                ),
              ),
            ],
          ),
        ),
      ];

      nextPageCallback = _nextPageCallback;
      previousPageCallback = _previousPageCallback;
    }

    return BlocBuilder<ObjectsListBloc<BackendStaysApi>, ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
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
              text: _rightButtonTitle,
              onTap: nextPage,
            ),
          ),
        );
      },
    );
  }
}
