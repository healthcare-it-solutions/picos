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
  @override
  Widget build(BuildContext context) {
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

        return ListView.separated(
          itemCount: state.objectsList.length,
          itemBuilder: (BuildContext context, int index) {
            return DocumentItem(state.objectsList[index] as Document);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                thickness: 1,
                height: 0,
              ),
            );
          },
        );
      },
    );
  }
}
