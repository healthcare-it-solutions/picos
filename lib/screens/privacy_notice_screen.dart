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
import 'package:picos/themes/global_theme.dart';
import 'package:picos/util/url_launcher.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_screen_frame.dart';

/// Shows the Privacy Notice Page of the Picos App.
class PrivacyNoticeScreen extends StatelessWidget {
  /// PicosMenu constructor
  const PrivacyNoticeScreen({Key? key}) : super(key: key);

  Text _caption(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    
    UrlLauncher urlLauncher = UrlLauncher();

    return PicosScreenFrame(
      title: AppLocalizations.of(context)!.privacyNotice,
      body: PicosBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _caption('Rechte des Betroffenen'),
            const Text(
              '''Sie können Ihre Rechte zum Datenschutz jederzeit und unentgeltlich in Anspruch nehmen. Unser Datenschutzbeauftragter überprüft und beantwortet jedes Anliegen individuell. Unseren Datenschutzbeauftragten können Sie per Mail unter dsb@hit-solutions.de  erreichen. \n''',
            ),
            _caption(
              '''Auskunftsrecht (Art. 15 DSGVO, § 17 KDG, § 19 DSG-EKD)''',
            ),
            const Text(
              '''Sie haben das Recht jederzeit unentgeltlich Auskunft darüber zu erhalten, ob wir Daten zu Ihrer Person verarbeiten.:\n''',
            ),
            _caption(
              '''Recht auf Berichtigung (Art. 16 DSGVO, § 18 KDG, § 20 DSG-EKD), Löschung (Art. 17. DSGVO, § 19 KDG, § 21 DSG-EKD), Einschränkung der Verarbeitung (Art. 18 DSGVO, § 20 KDG, § 22 DSG-EKD), Datenübertragung (Art. 20 DSGVO, § 22 KDG, § 24 DSG-EKD) und das Widerspruchsrecht (Art. 21 DSGVO, § 23 KDG, § 25 DSG-EKD)''',
            ),
            const Text(
              '''Weiterhin haben Sie die Möglichkeit die Rechte auf Berichtigung, Löschung oder Einschränkung der Verarbeitung geltend zu machen. Sie können auch jederzeit Widerspruch gegen die Verarbeitung Ihrer Daten gegenüber uns einlegen.\n''',
            ),
            _caption(
              '''Widerruf im Falle einer Einwilligung (Art. 7 Abs. 3 DSGVO, § 8 Abs. 6 KDG, § 11 Abs. 3 DSG-EKD):''',
            ),
            const Text(
              '''Sofern Sie Ihre personenbezogenen Daten auf Grundlage einer Einwilligung abgegeben haben, haben sie das Recht die Einwilligung jederzeit für die Zukunft zu widerrufen. Wir möchten Sie darauf hinweisen, dass durch den Widerruf der Einwilligung die Rechtmäßigkeit, der aufgrund der Einwilligung bis zum Widerruf erfolgten Verarbeitung nicht berührt wird.\n''',
            ),
            _caption('Recht auf Beschwerde bei der Aufsichtsbehörde'),
            const Text(
              '''Sofern Sie der Meinung sind, die Verarbeitung Ihrer personenbezogenen Daten durch die Verantwortlichen erfolge nicht rechtmäßig, haben Sie das jederzeitige Recht, sich mit Ihrer Beschwerde an die zuständige Datenschutzaufsichtsbehörde zu wenden.\n''',
            ),
            _caption('Antrag auf Löschung des PICOS-Kontos'),
            GestureDetector(
              onTap: () {
                urlLauncher.launch(
                  context,
                  'https://www.hit-solutions.de/picos-account-loeschung/',
                );
              },
              child: Text(
                '''Hier können Sie die Löschung Ihres Picos-Kontos beantragen.''',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: theme.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
