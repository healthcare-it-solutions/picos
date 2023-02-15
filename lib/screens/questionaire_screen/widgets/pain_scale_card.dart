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
import 'package:picos/screens/questionaire_screen/widgets/questionaire_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/picos_label.dart';

/// An custom card specifically for pain.
class PainScaleCard extends StatefulWidget {
  /// Creates a PainScaleCard.
  const PainScaleCard({
    required this.callBack,
    Key? key,
    this.label = '',
  }) : super(key: key);

  /// The label for the card.
  final String label;

  /// The function that is executed when an item gets selected.
  final Function(dynamic value) callBack;

  @override
  State<PainScaleCard> createState() => _PainScaleCardState();
}

class _PainScaleCardState extends State<PainScaleCard> {
  //Static Strings
  static String? _painless;
  static String? _veryMild;
  static String? _unpleasant;
  static String? _tolerable;
  static String? _disturbing;
  static String? _veryDisturbing;
  static String? _severe;
  static String? _verySevere;
  static String? _veryTerrible;
  static String? _agonizingUnbearable;
  static String? _strongestImaginable;
  static String? _noPain;
  static String? _minorPain;
  static String? _moderatePain;
  static String? _strongPain;

  static final Map<String, int?> _fields = <String, int?>{
    '0a': null,
    '0': 0,
    '0b': null,
    '1': 1,
    '2': 2,
    '3': 3,
    '3a': null,
    '4': 4,
    '5': 5,
    '6': 6,
    '6a': null,
    '7': 7,
    '8': 8,
    '9': 9,
    '10': 10
  };

  final Map<int, String> _sourceEmojis = <int, String>{
    0: 'assets/painIcons/0_No_Pain.png',
    1: 'assets/painIcons/1_VeryMild.png',
    2: 'assets/painIcons/2_Discomforting.png',
    3: 'assets/painIcons/3_Tolerable.png',
    4: 'assets/painIcons/4_Distressing.png',
    5: 'assets/painIcons/5_VeryDistressing.png',
    6: 'assets/painIcons/6_Intense.png',
    7: 'assets/painIcons/7_VeryIntense.png',
    8: 'assets/painIcons/8_UtterlyHorrible.png',
    9: 'assets/painIcons/9_ExcruciatingUnbearable.png',
    10: 'assets/painIcons/10_UnimaginableUnspeakable.png'
  };

  int? groupValue;
  static const double _cardContentPadding = 15;

  void _initStrings(BuildContext context) {
    _painless = AppLocalizations.of(context)!.painless;
    _veryMild = AppLocalizations.of(context)!.veryMild;
    _unpleasant = AppLocalizations.of(context)!.discomforting;
    _tolerable = AppLocalizations.of(context)!.tolerable;
    _disturbing = AppLocalizations.of(context)!.distressing;
    _veryDisturbing = AppLocalizations.of(context)!.veryDistressing;
    _severe = AppLocalizations.of(context)!.intense;
    _verySevere = AppLocalizations.of(context)!.veryIntense;
    _veryTerrible = AppLocalizations.of(context)!.utterlyHorrible;
    _agonizingUnbearable = AppLocalizations.of(context)!.excruciatingUnbearable;
    _strongestImaginable = AppLocalizations.of(context)!.strongestImaginable;
    _noPain = AppLocalizations.of(context)!.noPain;
    _minorPain = AppLocalizations.of(context)!.minorPain;
    _moderatePain = AppLocalizations.of(context)!.moderatePain;
    _strongPain = AppLocalizations.of(context)!.strongPain;
  }

  String _generateTileTitle(int? row) {
    switch (row) {
      case 0:
        return _painless!;
      case 1:
        return _veryMild!;
      case 2:
        return _unpleasant!;
      case 3:
        return _tolerable!;
      case 4:
        return _disturbing!;
      case 5:
        return _veryDisturbing!;
      case 6:
        return _severe!;
      case 7:
        return _verySevere!;
      case 8:
        return _veryTerrible!;
      case 9:
        return _agonizingUnbearable!;
      case 10:
        return _strongestImaginable!;
    }

    return '';
  }

  Widget _createHeaderBox(Color color, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _cardContentPadding,
      ),
      child: SizedBox(
        height: 25,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 10, top: 2.5),
            child: Text(
              title,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color.fromRGBO(126, 144, 160, 1),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createSelectRow(String key, int value) {
    return InkWell(
      onTap: () {
        setState(() {
          groupValue = value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: _cardContentPadding,
          vertical: 3,
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 45,
              child: Text(
                key.length < 2 ? '  $key' : key,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Image(
              width: 40,
              height: 40,
              image: AssetImage(_sourceEmojis[value]!),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                _generateTileTitle(value),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            Radio<int>(
              value: value,
              groupValue: groupValue,
              onChanged: (int? newValue) {
                setState(() {
                  widget.callBack(newValue!);
                  groupValue = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _generateRow(String key, int? value) {
    switch (key) {
      case '0a':
        return _createHeaderBox(
          const Color.fromRGBO(203, 223, 244, 1),
          _noPain!,
        );
      case '0b':
        return _createHeaderBox(
          const Color.fromRGBO(181, 223, 209, 1),
          _minorPain!,
        );
      case '3a':
        return _createHeaderBox(
          const Color.fromRGBO(201, 224, 143, 1),
          _moderatePain!,
        );
      case '6a':
        return _createHeaderBox(
          const Color.fromRGBO(252, 217, 153, 1),
          _strongPain!,
        );
    }

    return _createSelectRow(key, value!);
  }

  @override
  Widget build(BuildContext context) {
    if (_veryMild == null) {
      _initStrings(context);
    }

    List<Widget> children = <Widget>[];

    _fields.forEach(
      (String key, int? value) {
        children.add(_generateRow(key, value));

        if (value != null &&
            value != 0 &&
            value != 3 &&
            value != 6 &&
            value != 10) {
          children.add(
            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: _cardContentPadding),
              child: Divider(
                thickness: 1,
                height: 0,
                color: Color.fromRGBO(145, 151, 156, 1),
              ),
            ),
          );
        }
      },
    );

    return QuestionaireCard(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 0,
      ),
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _cardContentPadding),
        child: PicosLabel(label: widget.label),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
