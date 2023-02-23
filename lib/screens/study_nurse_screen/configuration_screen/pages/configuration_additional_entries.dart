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
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:queen_validators/queen_validators.dart';

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
  TextEditingController datePickerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PicosBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PicosLabel(label: AppLocalizations.of(context)!.caseNumber),
          PicosTextField(
            hint: AppLocalizations.of(context)!.caseNumber,
            onChanged: (String? newValue) {
              widget.callbackAdditionalEntries('entryCaseNumber', newValue!);
            },
            validator: qValidator(
              <TextValidationRule>[
                IsRequired(AppLocalizations.of(context)!.enterCaseNumber),
              ],
            ),
          ),
          PicosLabel(label: AppLocalizations.of(context)!.patientID),
          PicosTextField(
            hint: AppLocalizations.of(context)!.patientID,
            onChanged: (String? newValue) {
              widget.callbackAdditionalEntries('entryPatientID', newValue!);
            },
            validator: qValidator(
              <TextValidationRule>[
                IsRequired(AppLocalizations.of(context)!.enterPatientID),
              ],
            ),
          ),
          PicosLabel(label: AppLocalizations.of(context)!.weight),
          PicosTextField(
            hint: AppLocalizations.of(context)!.weight,
            onChanged: (String? newValue) {
              widget.callbackAdditionalEntries('entryWeight', newValue!);
            },
            validator: qValidator(
              <TextValidationRule>[
                IsRequired(AppLocalizations.of(context)!.enterWeight),
              ],
            ),
          ),
          PicosLabel(label: AppLocalizations.of(context)!.height),
          PicosTextField(
            hint: AppLocalizations.of(context)!.height,
            onChanged: (String? newValue) {
              widget.callbackAdditionalEntries('entryHeight', newValue!);
            },
            validator: qValidator(
              <TextValidationRule>[
                IsRequired(AppLocalizations.of(context)!.enterHeight),
              ],
            ),
          ),
          PicosLabel(label: AppLocalizations.of(context)!.bloodPressure),
          PicosTextField(
            hint: AppLocalizations.of(context)!.bloodPressure,
            onChanged: (String? newValue) {
              widget.callbackAdditionalEntries('entryBloodPressure', newValue!);
            },
            validator: qValidator(
              <TextValidationRule>[
                IsRequired(AppLocalizations.of(context)!.enterBloodPressure),
              ],
            ),
          ),
          PicosLabel(label: AppLocalizations.of(context)!.bloodSugar),
          PicosTextField(
            hint: AppLocalizations.of(context)!.bloodSugar,
            onChanged: (String? newValue) {
              widget.callbackAdditionalEntries('entryBloodSugar', newValue!);
            },
            validator: qValidator(
              <TextValidationRule>[
                IsRequired(AppLocalizations.of(context)!.enterBloodSugar),
              ],
            ),
          ),
          PicosLabel(label: AppLocalizations.of(context)!.dischargeDate),
          PicosTextField(
            hint: AppLocalizations.of(context)!.dischargeDate,
            controller: datePickerController,
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              DateTime? date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate:
                    DateTime.now().subtract(const Duration(days: 365 * 10)),
                lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
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
                datePickerController.text = date.day.toString() +
                    date.month.toString() +
                    date.year.toString();
                widget.callbackAdditionalEntries(
                  'entryDischargeDate',
                  date.toString(),
                );
              }
            },
            readOnly: true,
            validator: qValidator(
              <TextValidationRule>[
                IsRequired(AppLocalizations.of(context)!.enterDischargeDate),
              ],
            ),
          ),
          PicosLabel(label: AppLocalizations.of(context)!.instituteKey),
          PicosTextField(
            hint: AppLocalizations.of(context)!.instituteKey,
            onChanged: (String? newValue) {
              widget.callbackAdditionalEntries('entryInstituteKey', newValue!);
            },
            validator: qValidator(
              <TextValidationRule>[
                IsRequired(AppLocalizations.of(context)!.enterInstituteKey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
