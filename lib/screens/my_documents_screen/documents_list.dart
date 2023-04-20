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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picos/models/abstract_database_object.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../api/backend_documents_api.dart';
import '../../models/document.dart';
import '../../state/objects_list_bloc.dart';
import 'document_item.dart';

/// A List with all documents.
class DocumentsList extends StatefulWidget {
  /// Creates DocumentsList.
  const DocumentsList({Key? key}) : super(key: key);

  @override
  State<DocumentsList> createState() => _DocumentsListState();
}

class _DocumentsListState extends State<DocumentsList> {
  static String? _importantDocuments;
  static String? _documentsSortedDesc;

  List<Widget>? _importantList;
  List<Widget>? _sortedList;

  void _createLists(List<AbstractDatabaseObject> list) {
    const Padding separator = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Divider(
        thickness: 1,
        height: 0,
      ),
    );

    _importantList = <Widget>[];
    _sortedList = <Widget>[];

    list = _sortList(list);

    for (AbstractDatabaseObject element in list) {
      DocumentItem documentItem = DocumentItem(element as Document);

      if (element.important) {
        _importantList!.add(documentItem);
        _importantList!.add(separator);
        continue;
      }

      _sortedList!.add(documentItem);
      _sortedList!.add(separator);
    }
  }

  List<AbstractDatabaseObject> _sortList(List<AbstractDatabaseObject> list) {
    list.sort((AbstractDatabaseObject a, AbstractDatabaseObject b) {
      return (b as Document).date.compareTo((a as Document).date);
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    if (_importantDocuments == null) {
      _importantDocuments = AppLocalizations.of(context)!.importantDocuments;
      _documentsSortedDesc = AppLocalizations.of(context)!.documentsSortedDesc;
    }

    return BlocBuilder<ObjectsListBloc<BackendDocumentsApi>, ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        if (state.objectsList.isEmpty &&
            state.status == ObjectsListStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == ObjectsListStatus.failure) {
          return const Center(
            child: Text('Error'),
          );
        }

        _createLists(state.objectsList);

        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: PicosLabel(_importantDocuments!),
            ),
            Column(
              children: _importantList!,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 50),
              child: PicosLabel(_documentsSortedDesc!),
            ),
            Column(
              children: _sortedList!,
            ),
          ],
        );
      },
    );
  }
}
