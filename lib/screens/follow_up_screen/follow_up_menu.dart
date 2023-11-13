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
import 'package:picos/widgets/picos_screen_frame.dart';

import '../../api/backend_follow_up_api.dart';
import '../../models/follow_up.dart';
import 'follow_up_item.dart';

/// This is the screen a user should see when prompted to provide some
/// information about their health status.
class FollowUpMenu extends StatelessWidget {
  /// PicosMenu constructor
  const FollowUpMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int itemCount = 4;
    const double labelPadding = 10;

    return FutureBuilder<List<FollowUp>>(
      future: BackendFollowUpApi.getFollowUps(),
      builder: (BuildContext context, AsyncSnapshot<List<FollowUp>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return PicosScreenFrame(
          title: 'Follow Up',
          body: Column(
            children: <Widget>[
              const Padding(
                padding:
                    EdgeInsets.only(left: labelPadding, bottom: labelPadding),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: itemCount,
                  itemBuilder: (BuildContext context, int index) {
                    return FollowUpItem(snapshot.data![index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
