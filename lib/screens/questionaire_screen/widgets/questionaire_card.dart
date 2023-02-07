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

import '../../../widgets/picos_label.dart';

/// Card item for displaying some input for use inside the QuestionaireScreen.
class QuestionaireCard extends StatefulWidget {
  /// Creates a QuestionaireCard.
  const QuestionaireCard({
    required this.child,
    this.label,
    this.padding,
    Key? key,
  }) : super(key: key);

  /// The label of the questionaire card.
  final Widget? label;

  /// The title of the input field.
  final Widget child;

  /// Possible custom padding.
  final EdgeInsetsGeometry? padding;

  @override
  State<QuestionaireCard> createState() => _QuestionaireCardState();
}

class _QuestionaireCardState extends State<QuestionaireCard>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Padding(
          padding: widget.padding ??
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              widget.label ?? const PicosLabel(label: ''),
              const SizedBox(height: 15),
              widget.child,
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
