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

import 'package:picos/gen_l10n/app_localizations.dart';
import 'package:picos/util/backend.dart';

import '../widgets/questionnaire_page.dart';
import '../widgets/text_field_card.dart';

/// Questionnaire blood sugar page.
class BloodSugar extends StatefulWidget {
  /// BloodSugar constructor.
  const BloodSugar({
    required this.previousPage,
    required this.nextPage,
    required this.onChanged,
    Key? key,
    this.initialValue,
    this.initialValueMol,
  }) : super(key: key);

  /// Previous page button function.
  final void Function() previousPage;

  /// Next page button function.
  final void Function() nextPage;

  /// Callback for syst.
  final dynamic Function(String? value, String? valueMol) onChanged;

  /// Initial value.
  final int? initialValue;

  /// Initial value mmol/l.
  final double? initialValueMol;

  @override
  State<BloodSugar> createState() => _BloodSugarState();
}

class _BloodSugarState extends State<BloodSugar> {
  String? _bloodSugar;
  String? _checkValue;
  String? _selectedUnit;
  int? _value;
  double? _valueMol;
  final TextEditingController _textEditingController = TextEditingController();
  final String _mg = 'mg/dL';
  final String _mol = 'mmol/L';

  bool _setDisabledNext() {
    bool bloodSugar = true;
    bool bloodSugarMol = true;

    if (_value == null && _valueMol == null) {
      return false;
    }

    if (_value != null) {
      bloodSugar = _checkBloodSugar();
    }

    if (_valueMol != null) {
      bloodSugarMol = _checkBloodSugarMol();
    }

    return !(bloodSugarMol && bloodSugar);
  }

  bool _checkBloodSugar() {
    return !(_value! < 50 || _value! > 300);
  }

  bool _checkBloodSugarMol() {
    return !(_valueMol! < 2.8 || _valueMol! > 16.6);
  }

  String _setLabel() {
    final String bloodSugarMG = '${_bloodSugar!} ($_mg)';
    if (_value == null) {
      return bloodSugarMG;
    }

    if (_value! < 70 || _value! > 120) {
      return _checkValue!;
    }

    return bloodSugarMG;
  }

  String _setLabelMol() {
    final String bloodSugarMol = '${_bloodSugar!} ($_mol)';

    if (_valueMol == null) {
      return bloodSugarMol;
    }

    if (_valueMol! < 3.9 || _valueMol! > 6.6) {
      return _checkValue!;
    }

    return bloodSugarMol;
  }

  @override
  void initState() {
    _value = widget.initialValue;
    _valueMol = widget.initialValueMol;
    if (_value == null && _valueMol == null) {
      _selectedUnit = Backend.user.get('unitMg') ? _mg : _mol;
    } else {
      _selectedUnit = _valueMol != null ? _mol : _mg;
    }
    _updateTextEditingController();
    super.initState();
  }

  void _updateTextEditingController() {
    num? initialVal =
        _selectedUnit == _mol ? widget.initialValueMol : widget.initialValue;
    _textEditingController.text = initialVal?.toString() ?? '';
  }

  void _handleDropdownChange(String? newValue) {
    if (newValue != null && newValue != _selectedUnit) {
      setState(() {
        _selectedUnit = newValue;
        _updateTextEditingController();
      });
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_bloodSugar == null) {
      _bloodSugar = AppLocalizations.of(context)!.bloodSugar;
      _checkValue = AppLocalizations.of(context)!.checkValue;
    }

    final bool disabledNext = _setDisabledNext();
    final String label = _setLabel();
    final String labelMol = _setLabelMol();

    return QuestionnairePage(
      disabledNext: disabledNext,
      backFunction: widget.previousPage,
      nextFunction: widget.nextPage,
      child: Column(
        children: <Widget>[
          DropdownButton<String>(
            value: _selectedUnit,
            onChanged: _handleDropdownChange,
            items: <String>[_mg, _mol]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          TextFieldCard(
            controller: _textEditingController,
            label: _selectedUnit == _mol ? labelMol : label,
            hint: _selectedUnit!,
            decimalValue: _selectedUnit == _mol,
            onChanged: (String value) {
              setState(() {
                if (_selectedUnit == _mol) {
                  _valueMol = double.tryParse(value);
                  if (_valueMol != null) {
                    _value = (_valueMol! * 18.0182).round();
                    widget.onChanged(_value.toString(), _valueMol.toString());
                  }
                } else {
                  _value = int.tryParse(value);
                  widget.onChanged(_value.toString(), null);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
