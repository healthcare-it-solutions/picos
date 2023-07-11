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
import 'package:picos/api/backend_patients_list_api.dart';
import 'package:picos/screens/study_nurse_screen/catalog_of_items_screen/catalog_of_items_page_storage.dart';
import 'package:picos/state/objects_list_bloc.dart';
import 'package:picos/util/page_view_navigation.dart';
import 'package:picos/widgets/picos_page_view_button_bar.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A catalog of items containing patient data as a form.
class CatalogOfItemsScreen extends StatefulWidget {
  /// Creates CatalogOfItemsScreen.
  const CatalogOfItemsScreen({Key? key}) : super(key: key);

  @override
  State<CatalogOfItemsScreen> createState() => _CatalogOfItemsScreenState();
}

class _CatalogOfItemsScreenState extends State<CatalogOfItemsScreen>
    with PageViewNavigation {
  static String? _back;
  static String? _next;

  // All values can be accessed here.
  CatalogOfItemsPageStorage? pageStorage;

  //TODO: Create next page callback for saving the values inside pages.

  @override
  Widget build(BuildContext context) {
    if (pages.isEmpty) {
      buildContext = context;

      _back = AppLocalizations.of(context)!.back;
      _next = AppLocalizations.of(context)!.next;

      pageStorage = CatalogOfItemsPageStorage(context);
      pages = pageStorage!.pages;
    }

    return BlocBuilder<ObjectsListBloc<BackendPatientsListApi>,
            ObjectsListState>(
        builder: (BuildContext context, ObjectsListState state) {
      return PicosScreenFrame(
        title: 'Catalog of items',
        body: PageView(
          controller: controller,
          children: pages,
        ),
        bottomNavigationBar: PicosPageViewButtonBar(
          nextPage: nextPage,
          previousPage: previousPage,
          nextTitle: _next,
          previousTitle: _back,
        ),
      );
    },);
  }
}
