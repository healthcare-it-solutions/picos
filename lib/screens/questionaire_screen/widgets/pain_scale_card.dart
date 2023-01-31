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
    this.description = '',
  }) : super(key: key);

  /// The label for the card.
  final String label;

  /// An optional description for the selection.
  final String description;

  /// The function that is executed when an item gets selected.
  final Function(dynamic value) callBack;

  @override
  State<SleepQualityCard> createState() => _SleepQualityCardState();
}

class _SleepQualityCardState extends State<SleepQualityCard> {
  //Static Strings
  static String? _painFree;
  static String? _veryMild;
  static String? _discomforting;
  static String? _tolerable;
  static String? _distressing;
  static String? _veryDistressing;
  static String? _intense;
  static String? _veryIntense;
  static String? _utterlyHorrible;
  static String? _excruciatingUnbearable;
  static String? _strongestImaginablePain;

  static final Map<String, int> _options = <String, int>{
    '0': 0,
    '1': 1,
    '2': 2,
    '3': 3,
    '4': 4,
    '5': 5,
    '6': 6,
    '7': 7,
    '8': 8,
    '9': 9,
    '10': 10
  };

  int? groupValue;
  static const double tileHeight = 55;

  void _initStrings(BuildContext context) {
    _painFree = AppLocalizations.of(context)!.excellent;
    _veryMild = AppLocalizations.of(context)!.good;
    _discomforting = AppLocalizations.of(context)!.medium;
    _tolerable = AppLocalizations.of(context)!.bad;
    _distressing = AppLocalizations.of(context)!.terrible;
  }

  String _generateTileTitle(String row) {
    switch (row) {
      case '0':
        return _painFree!;
      case '1':
        return _veryMild!;
      case '2':
        return _discomforting!;
      case '3':
        return _tolerable!;
      case '4':
        return _distressing!;
      case '5':
        return _veryDistressing!;
      case '6':
        return _intense!;
      case '7':
        return _veryIntense!;
      case '8':
        return _utterlyHorrible!;
      case '9':
        return _excruciatingUnbearable!;
      case '10':
        return _strongestImaginablePain!;
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
            child: Center(
              child: Text(
                _generateTileTitle(row),
                style: const TextStyle(
                  color: Colors.black,
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

      divider.add(
        const Divider(
          thickness: 3,
          height: 0,
          color: dividerColor,
        ),
      );
      
      continue;
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

    if (widget.description.isNotEmpty) {
      children.add(PicosLabel(label: widget.description, fontSize: 15));
      children.add(const SizedBox(height: 15));
    }

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
