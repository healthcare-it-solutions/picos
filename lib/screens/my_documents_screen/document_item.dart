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

import '../../models/document.dart';
import '../../themes/global_theme.dart';

/// Displays a document item.
class DocumentItem extends StatelessWidget {
  /// Creates DocumentItem.
  const DocumentItem(
    this._document, {
    Key? key,
  }) : super(key: key);

  final Document _document;

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return ListTile(
      title: Text('${_document.filename} - ${_document.filename}'),
      trailing: Padding(
        padding: const EdgeInsets.only(
          right: 10,
        ),
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          color: theme.green2,
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed('/my-documents-screen/add-documents', arguments: _document);
      },
    );
  }
}
