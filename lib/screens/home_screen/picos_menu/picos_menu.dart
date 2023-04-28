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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/screens/home_screen/picos_menu/picos_menu_item.dart';
import 'package:picos/widgets/picos_label.dart';

import '../../../util/backend.dart';

/// This is the screen a user should see when prompted to provide some
/// information about their health status.
class PicosMenu extends StatelessWidget {
  /// PicosMenu constructor
  const PicosMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double labelSize = 17;
    const double sidePadding = 15;
    const double labelPadding = 10;

    List<Widget> items = <Widget>[
      Padding(
        padding:
            const EdgeInsets.only(left: labelPadding, bottom: labelPadding),
        child: PicosLabel(
          AppLocalizations.of(context)!.myHealth,
          fontSize: labelSize,
        ),
      ),
      PicosMenuItem(
        iconPath: 'assets/Medikation.svg',
        title: AppLocalizations.of(context)!.medicationScheme,
        onTap: () => Navigator.of(context)
            .pushNamed('/my-medications-screen/my-medications'),
      ),
      PicosMenuItem(
        iconPath: 'assets/Therapie.svg',
        title: AppLocalizations.of(context)!.therapy,
        onTap: () =>
            Navigator.of(context).pushNamed('/my-therapy-screen/my-therapy'),
      ),
      PicosMenuItem(
        iconPath: 'assets/BehandlerInnen_icon.svg',
        title: AppLocalizations.of(context)!.physicians,
        onTap: () => Navigator.of(context)
            .pushNamed('/physician-list-screen/physicians'),
      ),
      PicosMenuItem(
        iconSize: 20,
        iconPath: 'assets/Angehoerige_icon.svg',
        title: AppLocalizations.of(context)!.familyMembers,
        onTap: () => Navigator.of(context)
            .pushNamed('/family-member-list-screen/family-members'),
      ),
      PicosMenuItem(
        // iconSize: ,
        iconPath: 'assets/Dokumente_icon.svg',
        title: AppLocalizations.of(context)!.documents,
        onTap: () => Navigator.of(context)
            .pushNamed('/my-documents-screen/my-documents'),
      ),
      PicosMenuItem(
        iconPath: 'assets/Krankenhaus.svg',
        title: AppLocalizations.of(context)!.visits,
        onTap: () => Navigator.of(context).pushNamed('/visits-screen/visits'),
      ),
      Padding(
        padding: const EdgeInsets.only(left: labelPadding),
        child: PicosLabel(
          AppLocalizations.of(context)!.more,
          fontSize: labelSize,
        ),
      ),
      PicosMenuItem(
        iconPath: 'assets/Impressum.svg',
        title: AppLocalizations.of(context)!.legals,
        onTap: () => Navigator.of(context).pushNamed('/legals-screen'),
      ),
      PicosMenuItem(
        iconPath: 'assets/Datenschutz.svg',
        title: AppLocalizations.of(context)!.privacyNotice,
        onTap: () => Navigator.of(context).pushNamed('/privacy-notice-screen'),
      ),
      PicosMenuItem(
        iconPath: 'assets/Log-out.svg',
        title: AppLocalizations.of(context)!.logout,
        onTap: () async {
          if (!context.mounted) {
            return;
          }

          if (await Backend.logout()) {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacementNamed('/login-screen');
          }
        },
      ),
    ];

    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        if (index == 6 || index == 7) {
          return const SizedBox(height: labelPadding);
        }

        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: sidePadding),
          child: Divider(color: Colors.grey, height: 0),
        );
      },
      padding: const EdgeInsets.symmetric(vertical: sidePadding),
      itemBuilder: (BuildContext context, int index) {
        return items[index];
      },
      itemCount: items.length,
    );
  }
}
