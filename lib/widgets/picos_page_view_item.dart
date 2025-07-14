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
import 'package:picos/widgets/picos_body.dart';

/// Creates a standardized page item.
class PicosPageViewItem extends StatefulWidget {
  /// PicosPageViewItem constructor.
  const PicosPageViewItem({
    required this.child,
    Key? key,
  }) : super(key: key);

  /// The body of the page.
  final Widget child;

  @override
  State<PicosPageViewItem> createState() => _PicosPageViewItemState();
}

class _PicosPageViewItemState extends State<PicosPageViewItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PicosBody(
      child: widget.child,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
