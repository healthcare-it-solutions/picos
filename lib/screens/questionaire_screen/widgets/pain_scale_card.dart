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
  /// Creates a SleepQualityCard.
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

  static final Map<String, String> _fields = <String, String>{
    '0a': '',
    '0': '0',
    '0b': '',
    '1': '1',
    '2': '2',
    '3': '3',
    '3a': '',
    '4': '4',
    '5': '5',
    '6': '6',
    '6a': '',
    '7': '7',
    '8': '8',
    '9': '9',
    '10': '10',
    '10a': ''
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
  static const double tileHeight = 55;

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
  }

  String _generateTileTitle(String row) {
    switch (row) {
      case '0':
        return _painless!;
      case '1':
        return _veryMild!;
      case '2':
        return _unpleasant!;
      case '3':
        return _tolerable!;
      case '4':
        return _disturbing!;
      case '5':
        return _veryDisturbing!;
      case '6':
        return _severe!;
      case '7':
        return _verySevere!;
      case '8':
        return _veryTerrible!;
      case '9':
        return _agonizingUnbearable!;
      case '10':
        return _strongestImaginable!;
    }

    return '';
  }

  Widget _generateTitleWidget(String row) {
    return Ink(
      height: tileHeight,
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 50,
          ),
          Expanded(
            child: Text(
              _generateTileTitle(row),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createSubtitleBox(Color color, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: SizedBox(
        height: 25,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
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

  List<Widget> _generateDivider() {
    List<Widget> divider = <Widget>[];
    const Color dividerColor = Color.fromRGBO(145, 151, 156, 1);

    for (int i = 0; i < _fields.length; i++) {
      if (i == 0 || i == 2 || i == 5 || i == 10) {
        divider.add(
          const SizedBox(
            height: 25,
          ),
        );
      } else if (i == 15) {
        divider.add(
          const SizedBox(
            height: 0,
          ),
        );
      } else {
        divider.add(
          const SizedBox(
            height: tileHeight,
          ),
        );
      }

      if (i == 0 ||
          i == 1 ||
          i == 2 ||
          i == 5 ||
          i == 6 ||
          i == 9 ||
          i == 10 ||
          i == 15) {
        continue;
      }

      if (i != 14) {
        divider.add(
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return const Divider(
                thickness: 1,
                height: 0,
                color: dividerColor,
              );
            },
          ),
        );
      }
    }

    return divider;
  }

  @override
  Widget build(BuildContext context) {
    if (_veryMild == null) {
      _initStrings(context);
    }

    List<Widget> children = <Widget>[];

    double cardContentPadding = 15;

    _fields.forEach(
      (String key, String value) {
        if (key != '0a' &&
            key != '0b' &&
            key != '3a' &&
            key != '6a' &&
            key != '10a') {
          children.add(
            InkWell(
              onTap: () {
                setState(() {
                  groupValue = int.parse(value);
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: cardContentPadding),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: SizedBox(
                        width: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            key.length < 2 ? '  $key' : key,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: _generateTitleWidget(key),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Radio<int>(
                          value: int.parse(value),
                          groupValue: groupValue,
                          onChanged: (int? newValue) {
                            setState(() {
                              widget.callBack(newValue!);
                              groupValue = newValue;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          switch (key) {
            case '0a':
              children.add(
                _createSubtitleBox(
                  const Color.fromRGBO(202, 224, 242, 1),
                  AppLocalizations.of(context)!.noPain,
                ),
              );
              break;
            case '0b':
              children.add(
                _createSubtitleBox(
                  const Color.fromRGBO(180, 223, 209, 1),
                  AppLocalizations.of(context)!.minorPain,
                ),
              );
              break;
            case '3a':
              children.add(
                _createSubtitleBox(
                  const Color.fromRGBO(199, 223, 143, 1),
                  AppLocalizations.of(context)!.moderatePain,
                ),
              );
              break;
            case '6a':
              children.add(
                _createSubtitleBox(
                  const Color.fromRGBO(252, 216, 153, 1),
                  AppLocalizations.of(context)!.strongPain,
                ),
              );
              break;
          }
        }
      },
    );

    return QuestionaireCard(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 0,
      ),
      label: Padding(
        padding: EdgeInsets.symmetric(horizontal: cardContentPadding),
        child: PicosLabel(label: widget.label),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            children: children,
          ),
          Positioned(
            width: 40,
            height: 40,
            top: 33,
            left: 75,
            child: Image(
              image: AssetImage(_sourceEmojis[0]!),
            ),
          ),
          Positioned(
            width: 40,
            height: 40,
            top: 111,
            left: 75,
            child: Image(
              image: AssetImage(_sourceEmojis[1]!),
            ),
          ),
          Positioned(
            width: 40,
            height: 40,
            top: 166,
            left: 75,
            child: Image(
              image: AssetImage(_sourceEmojis[2]!),
            ),
          ),
          Positioned(
            width: 40,
            height: 40,
            top: 221,
            left: 75,
            child: Image(
              image: AssetImage(_sourceEmojis[3]!),
            ),
          ),
          Positioned(
            width: 40,
            height: 40,
            top: 301,
            left: 75,
            child: Image(
              image: AssetImage(_sourceEmojis[4]!),
            ),
          ),
          Positioned(
            width: 40,
            height: 40,
            top: 356,
            left: 75,
            child: Image(
              image: AssetImage(_sourceEmojis[5]!),
            ),
          ),
          Positioned(
            width: 40,
            height: 40,
            top: 411,
            left: 75,
            child: Image(
              image: AssetImage(_sourceEmojis[6]!),
            ),
          ),
          Positioned(
            width: 40,
            height: 40,
            top: 491,
            left: 75,
            child: Image(
              image: AssetImage(_sourceEmojis[7]!),
            ),
          ),
          Positioned(
            width: 40,
            height: 40,
            top: 546,
            left: 75,
            child: Image(
              image: AssetImage(_sourceEmojis[8]!),
            ),
          ),
          Positioned(
            width: 40,
            height: 40,
            top: 601,
            left: 75,
            child: Image(
              image: AssetImage(_sourceEmojis[9]!),
            ),
          ),
          Positioned(
            width: 40,
            height: 40,
            top: 656,
            left: 75,
            child: Image(
              image: AssetImage(_sourceEmojis[10]!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: _generateDivider(),
            ),
          ),
        ],
      ),
    );
  }
}
