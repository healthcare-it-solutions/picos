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
  BuildContext? _buildContext;

  /// Callback that executes on [nextPage].
  void Function()? nextPageCallback;

  /// Callback that executes on [previousPage].
  void Function()? previousPageCallback;

  /// Provides access to the [_pages] list.
  List<PicosPageViewItem> pages = <PicosPageViewItem>[];

  /// Provides access to the [PageController].
  PageController get controller {
    return _controller;
  }

  set buildContext(BuildContext context) {
    _buildContext ??= context;
  }

  /// Returns the current page of the controller.
  double get page {
    try {
      return _controller.page!;
    } catch (e) {
      return 0;
    }
  }

  /// Goes to the previous page. Executes [previousPageCallback] if set.
  void previousPage() {
    if (_buildContext == null) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    if (_controller.page == 0) {
      Navigator.of(_buildContext!).pop();
      return;
    }

    controller.previousPage(
      duration: _controllerDuration,
      curve: _controllerCurve,
    );

    if (previousPageCallback != null) {
      previousPageCallback!();
    }
  }

  /// Goes to the next page. Executes [nextPageCallback] if set.
  void nextPage() {
    if (_buildContext == null) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

   if (_controller.page == pages.length - 1) {
     Navigator.of(_buildContext!).pop();
     return;
   }

    controller.nextPage(
      duration: _controllerDuration,
      curve: _controllerCurve,
    );

    if (nextPageCallback != null) {
      nextPageCallback!();
    }
  }
}
