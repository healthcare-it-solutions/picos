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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Creates a horizontal radio selection for
class PicosFormOfAddress extends StatefulWidget {
  /// PicosFormOfAddress constructor.
  const PicosFormOfAddress({
    required this.callBackFunction,
    Key? key,
  }) : super(key: key);

  /// The function that is executed when an item gets selected.
  final Function(FormOfAddress value) callBackFunction;

  @override
  State<PicosFormOfAddress> createState() => _PicosFormOfAddressState();
}

/// Enumeration for FormOfAddress-variable.
enum FormOfAddress {
  /// Element for denoting 'male'.
  male,

  /// Element for denoting 'female'.
  female,

  /// Element for denoting 'diverse'.
  diverse,
}

/// Converter methods for [FormOfAddress].
extension FormOfAddressConverter on FormOfAddress {
  /// Takes [value] and returns the corresponding [FormOfAddress].
  static FormOfAddress stringToFormOfAddress(String value) {
    return FormOfAddress.values
        .firstWhere((FormOfAddress element) => describeEnum(element) == value);
  }

  /// Returns the correct [String] representation of [FormOfAddress].
  String toForm(BuildContext context) {
    switch (this) {
      case FormOfAddress.female:
        return AppLocalizations.of(context)!.mrs;
      case FormOfAddress.male:
        return AppLocalizations.of(context)!.mr;
      case FormOfAddress.diverse:
        return '';
    }
  }
}

class _PicosFormOfAddressState extends State<PicosFormOfAddress> {
  static String? _mrs;
  static String? _mr;
  static String? _diverse;

  FormOfAddress? _groupValue;

  void _updateState(FormOfAddress value) {
    widget.callBackFunction(value);

    setState(() {
      _groupValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double fontSize = 18;
    const double paddingBetween = 5;
    const double paddingEnd = 10;

    if (_mrs == null) {
      _mrs = AppLocalizations.of(context)!.mrs;
      _mr = AppLocalizations.of(context)!.mr;
      _diverse = AppLocalizations.of(context)!.diverse;
    }

    return Row(
      children: <InkWell>[
        InkWell(
          child: Row(
            children: <Widget>[
              const SizedBox(width: paddingBetween),
              Radio<FormOfAddress>(
                visualDensity: VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.standard.vertical,
                ),
                value: FormOfAddress.female,
                groupValue: _groupValue,
                onChanged: (FormOfAddress? value) {
                  _updateState(value!);
                },
              ),
              const SizedBox(width: paddingBetween),
              Text(_mrs!, style: const TextStyle(fontSize: fontSize)),
              const SizedBox(width: paddingEnd),
            ],
          ),
          onTap: () {
            _updateState(FormOfAddress.female);
          },
        ),
        InkWell(
          child: Row(
            children: <Widget>[
              const SizedBox(width: paddingBetween),
              Radio<FormOfAddress>(
                visualDensity: VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.standard.vertical,
                ),
                value: FormOfAddress.male,
                groupValue: _groupValue,
                onChanged: (FormOfAddress? value) {
                  _updateState(value!);
                },
              ),
              const SizedBox(width: paddingBetween),
              Text(_mr!, style: const TextStyle(fontSize: fontSize)),
              const SizedBox(width: paddingEnd),
            ],
          ),
          onTap: () {
            _updateState(FormOfAddress.male);
          },
        ),
        InkWell(
          child: Row(
            children: <Widget>[
              const SizedBox(width: paddingBetween),
              Radio<FormOfAddress>(
                visualDensity: VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.standard.vertical,
                ),
                value: FormOfAddress.diverse,
                groupValue: _groupValue,
                onChanged: (FormOfAddress? value) {
                  _updateState(value!);
                },
              ),
              const SizedBox(width: paddingBetween),
              Text(_diverse!, style: const TextStyle(fontSize: fontSize)),
              const SizedBox(width: paddingEnd),
            ],
          ),
          onTap: () {
            _updateState(FormOfAddress.diverse);
          },
        ),
      ],
    );
  }
}
