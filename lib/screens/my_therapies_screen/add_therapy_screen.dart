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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/widgets/picos_add_button_bar.dart';
import 'package:picos/widgets/picos_screen_frame.dart';

import '../../models/therapy.dart';
import '../../state/therapies/therapies_list_bloc.dart';
import '../../themes/global_theme.dart';
import '../../widgets/picos_body.dart';
import '../../widgets/picos_label.dart';
import '../../widgets/picos_text_area.dart';
import '../../widgets/picos_text_field.dart';

/// A screen for adding new therapies.
class AddTherapyScreen extends StatefulWidget {
  /// Creates the AddTherapyScreen.
  const AddTherapyScreen({Key? key}) : super(key: key);

  @override
  State<AddTherapyScreen> createState() => _AddTherapyScreenState();
}

class _AddTherapyScreenState extends State<AddTherapyScreen> {
  /// The therapy to be taken.
  DateTime? _date;

  /// The therapy description.
  String? _therapy;

  DateTime? _dateOld;
  String? _therapyOld;

  Therapy? _therapyEdit;
  String? _title;
  String? _dateHint;
  bool _saveDisabled = true;
  String _dateHintSuffix = '';
  String _emptyDateHint = '';

  bool _checkValues() {
    if (_therapy == null || _date == null) {
      return false;
    }

    if (_therapy == _therapyOld && _date == _dateOld) {
      return false;
    }

    return true;
  }

  String _buildDateHint(DateTime? date) {
    if (date == null) {
      return _emptyDateHint;
    }

    return '${date.day}.${date.month}.${date.year} $_dateHintSuffix';
  }

  @override
  Widget build(BuildContext context) {
    // Init variables.
    if (_title == null) {
      _emptyDateHint = AppLocalizations.of(context)!.selectDate;
      _title = AppLocalizations.of(context)!.addTherapy;
      _dateHint = _buildDateHint(_date);
      _dateHintSuffix = '///// ${AppLocalizations.of(context)!.day}.'
          '${AppLocalizations.of(context)!.month}.'
          '${AppLocalizations.of(context)!.year}';
    }

    Object? therapyEdit = ModalRoute.of(context)!.settings.arguments;

    //Initialize therapyEdit if the therapy is to be edited.
    if (_therapyEdit == null && therapyEdit != null) {
      _therapyEdit = therapyEdit as Therapy;

      _date = _therapyEdit!.date;
      _therapy = _therapyEdit!.therapy;
      _dateOld = _date;
      _therapyOld = _therapy;

      _dateHint = _buildDateHint(_date);

      _title = AppLocalizations.of(context)!.editTherapy;
    }

    return BlocBuilder<TherapiesListBloc, TherapiesListState>(
      builder: (BuildContext context, TherapiesListState state) {
        return PicosScreenFrame(
          title: _title,
          bottomNavigationBar: PicosAddButtonBar(
            disabled: _saveDisabled,
            onTap: () {
              Therapy therapy = _therapyEdit ?? Therapy(
                therapy: _therapy!,
                date: _date!,
              );

              if (_therapyEdit != null) {
                therapy = therapy.copyWith(date: _date, therapy: _therapy);
              }

              context.read<TherapiesListBloc>().add(SaveTherapy(therapy));
              Navigator.of(context).pop(therapy);
            },
          ),
          body: PicosBody(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 25,
                ),
                PicosLabel(
                  label: AppLocalizations.of(context)!.date,
                ),
                PicosTextField(
                  hint: _dateHint!,
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now()
                          .subtract(const Duration(days: 365 * 10)),
                      lastDate:
                          DateTime.now().add(const Duration(days: 365 * 10)),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            dialogBackgroundColor: Theme.of(context)
                                .extension<GlobalTheme>()!
                                .bottomNavigationBar!,
                            colorScheme: ColorScheme.light(
                              primary: Theme.of(context)
                                  .extension<GlobalTheme>()!
                                  .darkGreen1!,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (date != null) {
                      _date = date;
                    }

                    setState(() {
                      _dateHint = _buildDateHint(_date);
                      _saveDisabled = !_checkValues();
                    });
                  },
                  readOnly: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                PicosLabel(
                  label: AppLocalizations.of(context)!.therapy,
                ),
                PicosTextArea(
                  maxLines: 10,
                  initialValue: _therapy,
                  onChanged: (String value) {
                    _therapy = value;

                    setState(() {
                      _saveDisabled = !_checkValues();
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
