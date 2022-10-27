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

import '../../../widgets/picos_text_field.dart';

/// A card with a TextField inside it.
class TextFieldCard extends StatelessWidget {
  /// Creates TextFieldCard.
  const TextFieldCard({
    this.label = '',
    this.hint = '',
    Key? key,
  }) : super(key: key);

  /// The title of the input field.
  final String label;

  /// The hint shown in the text field.
  final String hint;

  @override
  Widget build(BuildContext context) {
    return QuestionaireCard(
      label: label,
      child: PicosTextField(
        hint: hint,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
