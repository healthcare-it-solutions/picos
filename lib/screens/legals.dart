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
class LegalsPage extends StatelessWidget {
  /// PicosMenu constructor
  const LegalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PicosScreenFrame(
      title: AppLocalizations.of(context)!.legals,
      appBarElevation: 4,
      body: PicosBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              '''Das Projekt DISTANCE ist einer der vom Bundesministerium für Bildung und Forschung (BMBF) geförderten Digitalen FortschrittsHubs Gesundheit im Rahmen der Medizin-Informatikinitiative.''',
            ),
            Text('\n'),
            Text('Angaben gem. § 5 TMG:\n'),
            Text(
              'Healthcare IT Solutions GmbH\n',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Sitz:\n',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Pauwelsstraße 30'),
            Text('52074 Aachen\n'),
            Text(
              'Postanschrift:\n',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Karl-Friedrich-Straße 74'),
            Text('52072 Aachen\n'),
            Text('Tel.: +49 241 99753311'),
            Text('E-Mail: info@hit-solutions.de'),
            Text('Website: www.hit-solutions.de\n'),
            Text(
              '''Umsatzsteuer-Identifikationsnummer gemäß § 27a Umsatzsteuergesetz:''',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('DE14NRW00000098851\n'),
            Text(
              'Bildnachweise:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Meine Eingaben: © Megan Rexazin | pixabay.com'),
            Text('Meine Therapie: © Mohamed Hassan | pixabay.com'),
            Text('Arzt-/Krankenhausbesuche: © Aryo Hadi | istockphoto.com'),
            Text('Meine BehandlerInnen: © lu94007 | pixabay.com'),
            Text('Meine Angehörigen: © harishs | pixabay.com'),
            Text('Meine Dokumente: © Megan Rexazin | pixabay.com'),
            Text('Kontaktaufnahme: © Megan Rexazin | pixabay.com'),
          ],
        ),
      ),
    );
  }
}
