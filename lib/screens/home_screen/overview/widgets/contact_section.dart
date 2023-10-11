/*
*  This file is part of Picos, a health tracking mobile app
*  Copyright (C) 2022 Healthcare IT Solutions GmbH
*
*  This program is free software: you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation, either version 3 of the License, or
*  (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  You should have received a copy of the GNU General Public License
*  along with this program. If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/screens/home_screen/overview/widgets/section.dart';
import 'package:picos/themes/global_theme.dart';
import 'package:url_launcher/url_launcher.dart';

/// A Flutter widget representing the contact section of the app.
class ContactSection extends StatelessWidget {
  /// ContactSection constructor
  const ContactSection({Key? key}) : super(key: key);

  void _launchURL(BuildContext context) async {
    final Uri url = Uri.parse(
      'https://hit-solutions.de/media/1170/benutzerhandbuch-picos_fuer-patienten_v160.pdf',
    );
    final ScaffoldMessengerState scaffoldMessenger =
        ScaffoldMessenger.of(context);
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            context.mounted ? AppLocalizations.of(context)!.couldNotLaunch : '',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;

    return Section(
      titleColor: theme.blue,
      title: AppLocalizations.of(context)!.contact,
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Expanded>[
              const Expanded(
                flex: 35,
                child: SizedBox(),
              ),
              Expanded(
                flex: 65,
                child: Image.asset('assets/Feedbackgespraech.png'),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Expanded>[
                  Expanded(
                    flex: 55,
                    child: Text(AppLocalizations.of(context)!.needHelp),
                  ),
                  const Expanded(
                    flex: 45,
                    child: SizedBox(),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Expanded>[
                  Expanded(
                    flex: 55,
                    child: GestureDetector(
                      onTap: () => _launchURL(context),
                      child: Text(
                        AppLocalizations.of(context)!.handbook,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 11,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Expanded>[
                  Expanded(
                    flex: 55,
                    child: Text('E-Mail:\npicos@hit-solutions.de'),
                  ),
                  Expanded(
                    flex: 45,
                    child: SizedBox(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
