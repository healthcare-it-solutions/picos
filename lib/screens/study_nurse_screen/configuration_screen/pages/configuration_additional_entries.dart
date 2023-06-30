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
import 'package:picos/screens/study_nurse_screen/models/institute_key.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_select.dart';
import 'package:picos/widgets/picos_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Class for additional entries of the configuration pages.
class ConfigurationAdditionalEntries extends StatefulWidget {
  /// Corresponding constructor of the class.
  const ConfigurationAdditionalEntries({
    required this.callbackAdditionalEntries,
    Key? key,
  }) : super(key: key);

  /// Callback function for additional entries.
  final void Function(String, String) callbackAdditionalEntries;

  @override
  State<ConfigurationAdditionalEntries> createState() =>
      _ConfigurationAdditionalEntriesState();
}

class _ConfigurationAdditionalEntriesState
    extends State<ConfigurationAdditionalEntries> {
  @override
  Widget build(BuildContext context) {
    return PicosBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PicosLabel(AppLocalizations.of(context)!.caseNumber),
          PicosTextField(
            hint: AppLocalizations.of(context)!.caseNumber,
            onChanged: (String? newValue) {
              widget.callbackAdditionalEntries('entryCaseNumber', newValue!);
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.enterCaseNumber;
              }
              return null;
            },
          ),
          PicosLabel(AppLocalizations.of(context)!.patientID),
          PicosTextField(
            hint: AppLocalizations.of(context)!.patientID,
            onChanged: (String? newValue) {
              widget.callbackAdditionalEntries('entryPatientID', newValue!);
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.enterPatientID;
              }
              return null;
            },
          ),
          PicosLabel(AppLocalizations.of(context)!.instituteKey),
          PicosSelect(
            selection: InstituteKey.instituteKey,
            callBackFunction: (String? value) {
              widget.callbackAdditionalEntries('entryInstituteKey', value!);
            },
            hint: AppLocalizations.of(context)!.instituteKey,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return '''     ${AppLocalizations.of(context)!.enterInstituteKey}''';
              }
              return null;
            },
          ),
          PicosLabel(AppLocalizations.of(context)!.height),
          PicosTextField(
            hint: '${AppLocalizations.of(context)!.height} (cm)',
            onChanged: (String? newValue) {
              widget.callbackAdditionalEntries('entryHeight', newValue!);
            },
            keyboardType: TextInputType.number,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.enterHeight;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
