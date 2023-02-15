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

/// An custom card specifically for sleep quality.
class SleepQualityCard extends StatefulWidget {
  /// Creates a SleepQualityCard.
  const SleepQualityCard({
    required this.callBack,
    Key? key,
    this.label = '',
  }) : super(key: key);

  /// The label for the card.
  final String label;

  /// The function that is executed when an item gets selected.
  final Function(dynamic value) callBack;

  @override
  State<SleepQualityCard> createState() => _SleepQualityCardState();
}

class _SleepQualityCardState extends State<SleepQualityCard> {
  //Static Strings
  static String? _excellent;
  static String? _good;
  static String? _medium;
  static String? _bad;
  static String? _terrible;

  static final Map<String, int> _options = <String, int>{
    '10': 10,
    '9': 9,
    '8': 8,
    '7': 7,
    '6': 6,
    '5': 5,
    '4': 4,
    '3': 3,
    '2': 2,
    '1': 1,
    '0': 0,
  };

  int? groupValue;
  static const double tileHeight = 55;

  void _initStrings(BuildContext context) {
    _excellent = AppLocalizations.of(context)!.excellent;
    _good = AppLocalizations.of(context)!.good;
    _medium = AppLocalizations.of(context)!.medium;
    _bad = AppLocalizations.of(context)!.bad;
    _terrible = AppLocalizations.of(context)!.terrible;
  }

  String _generateTileTitle(String row) {
    switch (row) {
      case '10':
        return _excellent!;
      case '8':
        return _good!;
      case '5':
        return _medium!;
      case '2':
        return _bad!;
      case '0':
        return _terrible!;
    }

    return '';
  }

  Ink _generateTitleWidget(String row) {
    Color backgroundColor = const Color.fromRGBO(216, 238, 215, 1);

    if (row == '9' || row == '8' || row == '7') {
      backgroundColor = const Color.fromRGBO(234, 243, 210, 1);
    }

    if (row == '6' || row == '5' || row == '4') {
      backgroundColor = const Color.fromRGBO(254, 240, 214, 1);
    }

    if (row == '3' || row == '2' || row == '1') {
      backgroundColor = const Color.fromRGBO(250, 220, 210, 1);
    }

    if (row == '0') {
      backgroundColor = const Color.fromRGBO(247, 194, 191, 1);
    }

    return Ink(
      height: tileHeight,
      color: backgroundColor,
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 50,
          ),
          Expanded(
            child: Center(
              child: Text(
                _generateTileTitle(row),
                style: const TextStyle(
                  color: Color.fromRGBO(168, 175, 177, 1),
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _generateDivider() {
    List<Widget> divider = <Widget>[];
    const Color dividerColor = Color.fromRGBO(145, 151, 156, 1);

    for (int i = 0; i < _options.length; i++) {
      divider.add(
        const SizedBox(
          height: tileHeight,
        ),
      );

      if (i == _options.length - 1) {
        continue;
      }

      if (i == 0 || i == 3 || i == 6 || i == 9) {
        divider.add(
          const Divider(
            thickness: 3,
            height: 0,
            color: dividerColor,
          ),
        );
        continue;
      }

      divider.add(
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Divider(
              thickness: 1,
              height: 0,
              color: dividerColor,
              endIndent: constraints.maxWidth - 120,
            );
          },
        ),
      );
    }

    return divider;
  }

  @override
  Widget build(BuildContext context) {
    if (_good == null) {
      _initStrings(context);
    }

    List<Widget> children = <Widget>[];

    double cardContentPadding = 15;

    _options.forEach(
      (String key, int value) {
        children.add(
          InkWell(
            onTap: () {
              setState(() {
                groupValue = value;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: cardContentPadding),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SizedBox(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          key.length < 2 ? '  $key' : key,
                          style: const TextStyle(
                            fontSize: 20,
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
                        value: value,
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
            width: 50,
            height: tileHeight * 11,
            left: 85,
            child: Ink(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.green,
                    Colors.orange,
                    Colors.red,
                  ],
                ),
              ),
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
