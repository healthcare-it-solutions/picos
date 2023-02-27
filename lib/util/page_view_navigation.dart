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

import '../widgets/picos_page_view_item.dart';

/// Implements some standard methods for use with [PageView].
abstract class PageViewNavigation {
  final PageController _controller = PageController();
  static const Duration _controllerDuration = Duration(milliseconds: 300);
  static const Curve _controllerCurve = Curves.ease;
  late final BuildContext? _buildContext;
  final List<PicosPageViewItem> _pages = <PicosPageViewItem>[];

  /// Provides access to the [PageController].
  PageController get controller {
    return _controller;
  }

  set buildContext(BuildContext context) {
    _buildContext = context;
  }

  /// Provides access to the [_pages] list.
  List<PicosPageViewItem> get pages {
    return _pages;
  }

  /// Goes to the previous page.
  void previousPage() {
    if (_buildContext == null) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    if (controller.page == 0) {
      Navigator.of(_buildContext!).pop();
      return;
    }

    controller.previousPage(
      duration: _controllerDuration,
      curve: _controllerCurve,
    );
  }

  /// Goes to the next page.
  void nextPage() {
    if (_buildContext == null) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    if (controller.page == _pages.length - 1) {
      Navigator.of(_buildContext!).pop();
      return;
    }

    controller.nextPage(
      duration: _controllerDuration,
      curve: _controllerCurve,
    );
  }
}