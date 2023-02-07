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
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_screen_frame.dart';

/// Shows the Legal Page of the Picos App.
class LegalsScreen extends StatelessWidget {
  /// PicosMenu constructor
  const LegalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PicosScreenFrame(
      title: AppLocalizations.of(context)!.legals,
      body: PicosBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${AppLocalizations.of(context)!.projectDISTANCE}\n'),
            Text('${AppLocalizations.of(context)!.information5tmg}\n'),
            const Text(
              'Healthcare IT Solutions GmbH\n',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '${AppLocalizations.of(context)!.headOffice}:\n',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('Pauwelsstraße 30'),
            const Text('52074 Aachen\n'),
            Text(
              '${AppLocalizations.of(context)!.postalAddress}:\n',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('Karl-Friedrich-Straße 74'),
            const Text('52072 Aachen\n'),
            const Text('Tel.: +49 241 99753311'),
            const Text('E-Mail: info@hit-solutions.de'),
            const Text('Website: www.hit-solutions.de\n'),
            Text(
              '${AppLocalizations.of(context)!.salesTaxID}:\n',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('DE14NRW00000098851\n'),
            Text(
              '${AppLocalizations.of(context)!.photoCredits}:\n',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '''${AppLocalizations.of(context)!.myEntries}: © Megan Rexazin | pixabay.com''',
            ),
            Text(
              '''${AppLocalizations.of(context)!.myTherapy}: © Mohamed Hassan | pixabay.com''',
            ),
            Text(
              '''${AppLocalizations.of(context)!.doctorsVisit}: © Aryo Hadi | istockphoto.com''',
            ),
            Text(
              '''${AppLocalizations.of(context)!.myPhysicians}: © lu94007 | pixabay.com''',
            ),
            Text(
              '''${AppLocalizations.of(context)!.myFamilyMembers}: © harishs | pixabay.com''',
            ),
            Text(
              '''${AppLocalizations.of(context)!.myDocuments}: © Megan Rexazin | pixabay.com''',
            ),
            Text(
              '''${AppLocalizations.of(context)!.contact}: © Megan Rexazin | pixabay.com''',
            ),
          ],
        ),
      ),
    );
  }
}
