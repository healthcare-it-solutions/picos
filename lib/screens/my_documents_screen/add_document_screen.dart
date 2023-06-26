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

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:picos/api/backend_documents_api.dart';
import 'package:picos/models/document.dart';
import 'package:picos/screens/my_documents_screen/document_button.dart';
import 'package:picos/widgets/picos_add_button_bar.dart';
import 'package:picos/widgets/picos_date_picker.dart';
import 'package:picos/widgets/picos_radio_select.dart';
import 'package:picos/widgets/picos_screen_frame.dart';

import '../../state/objects_list_bloc.dart';
import '../../util/backend.dart';
import '../../widgets/picos_label.dart';
import '../../widgets/picos_text_field.dart';

/// A screen for adding new documents.
class AddDocumentScreen extends StatefulWidget {
  /// Creates the AddDocumentScreen.
  const AddDocumentScreen({Key? key}) : super(key: key);

  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  static String? _priority;
  static String? _date;
  static String? _documentTitle;
  static String? _addDocument;
  static String? _editDocument;
  static String? _downloadDocument;
  static String? _delete;
  static final Map<String, bool> _selection = <String, bool>{};

  // State
  String? _title;
  bool? _selectedPriority;
  DateTime? _selectedDate;
  String? _selectedTitle;
  BackendFile? _uploadedDocument;
  bool _saveDisabled = true;
  Document? _document;

  void _checkValues() {
    if (_selectedPriority == null ||
        _selectedDate == null ||
        _selectedTitle == null ||
        _uploadedDocument == null) {
      setState(() {
        _saveDisabled = true;
      });

      return;
    }

    if (_selectedTitle!.isEmpty || _selectedTitle!.trim() == '') {
      setState(() {
        _saveDisabled = true;
      });

      return;
    }

    setState(() {
      _saveDisabled = false;
    });
  }

  List<Widget> _createDocumentButtons() {
    if (_document != null) {
      return <Widget>[
        DocumentButton(
          title: _downloadDocument,
          onPressed: () async {
            PlatformFile file = await _document!.document.download();
            if (!kIsWeb) {
              await OpenFile.open(file.path);
            }
            return false;
          },
        ),
        const SizedBox(height: 35),
        DocumentButton(
          title: _delete,
          onPressed: () async {
            context
                .read<ObjectsListBloc<BackendDocumentsApi>>()
                .add(RemoveObject(_document!));
            Navigator.of(context).pop();
            return false;
          },
        ),
      ];
    }

    return <Widget>[
      DocumentButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();

          if (result != null) {
            _uploadedDocument = BackendFile(result.files.single);
            _checkValues();

            return true;
          }

          return false;
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    const double padding = 10;

    // Init variables.
    if (_selection.isEmpty) {
      _selection.addAll(<String, bool>{
        AppLocalizations.of(context)!.importantDocument: true,
        AppLocalizations.of(context)!.sortByDate: false,
      });

      _priority = AppLocalizations.of(context)!.priority;
      _date = AppLocalizations.of(context)!.date;
      _documentTitle = AppLocalizations.of(context)!.documentTitle;
      _addDocument = AppLocalizations.of(context)!.addDocument;
      _editDocument = AppLocalizations.of(context)!.editDocument;
      _downloadDocument = AppLocalizations.of(context)!.downloadDocument;
      _delete = AppLocalizations.of(context)!.delete;
    }

    _title ??= _addDocument;
    Object? document = ModalRoute.of(context)!.settings.arguments;

    if (_document == null && document != null) {
      _title = _editDocument;
      _document = document as Document;

      _selectedTitle = _document!.filename;
      _selectedDate = _document!.date;
      _selectedPriority = _document!.important;
      _uploadedDocument = _document!.document;
    }

    return BlocBuilder<ObjectsListBloc<BackendDocumentsApi>, ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        return PicosScreenFrame(
          title: _title,
          bottomNavigationBar: PicosAddButtonBar(
            disabled: _saveDisabled,
            onTap: () {
              Document document = _document != null
                  ? _document!.copyWith(
                      date: _selectedDate!,
                      document: _uploadedDocument!,
                      filename: _selectedTitle!,
                      important: _selectedPriority!,
                    )
                  : Document(
                      date: _selectedDate!,
                      document: _uploadedDocument!,
                      filename: _selectedTitle!,
                      important: _selectedPriority!,
                    );

              context
                  .read<ObjectsListBloc<BackendDocumentsApi>>()
                  .add(SaveObject(document));
              Navigator.of(context).pop();
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: padding, left: padding),
                  child: PicosLabel(_priority!),
                ),
                PicosRadioSelect(
                  initialValue: _selectedPriority,
                  selection: _selection,
                  callBack: (dynamic value) {
                    _selectedPriority = value;
                    _checkValues();
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding),
                  child: Column(
                    children: <Widget>[
                      PicosLabel(_date!),
                      PicosDatePicker(
                        initialValue: _selectedDate,
                        callBackFunction: (DateTime value) {
                          _selectedDate = value;
                          _checkValues();
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      PicosLabel(_documentTitle!),
                      PicosTextField(
                        initialValue: _selectedTitle,
                        hint: _documentTitle!,
                        onChanged: (String value) {
                          _selectedTitle = value;
                          _checkValues();
                        },
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      Column(
                        children: _createDocumentButtons(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
