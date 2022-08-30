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

class _QuestionaireCardState extends State<QuestionaireCard> {
  int? _selectedElement;

  Iterable<Widget> _genReplies() sync* {
    for (MapEntry<int, String> answer in widget.answers.entries) {
      yield RadioListTile<int>(
        title: Text(answer.value),
        value: answer.key,
        groupValue: _selectedElement,
        onChanged: (int? newSelection) {
          setState(
            () {
              _selectedElement = newSelection;
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              widget.question,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          //Text(widget.question),
          ..._genReplies()
        ],
      ),
    );
  }
}

/// This is a widget that returns a [Card].
class QuestionaireCard extends StatefulWidget {
  /// The constructor accepts a question string and a [Map] of answers.
  /// The answers must be in the following format
  /// 1: 'answer1'
  /// 2: 'answer2'
  const QuestionaireCard({
    required this.question,
    required this.answers,
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionaireCard> createState() => _QuestionaireCardState();

  /// This is the question text rendered on the card the user has to answer
  final String question;

  /// These are the possible replies the user can choose from.
  final Map<int, String> answers;
}
