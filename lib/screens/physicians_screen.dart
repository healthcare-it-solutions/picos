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
import 'package:picos/widgets/picos_add_mono_button_bar.dart';

import '../widgets/picos_list_card.dart';

/// builds 'Column' as a parent widget for the given cards
class MyCard extends StatelessWidget {
  /// MyCard constructor
  const MyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Declaration of the List-variable 'cards' for building
    /// the main components of the UI of this screen
    List<CustomCard> cards;

    /// A fixed list of Strings denoting the type of physicians
    List<String> physicianType = <String>[
      AppLocalizations.of(context)!.familyDoctor,
      AppLocalizations.of(context)!.cardiologist,
      AppLocalizations.of(context)!.nephrologist,
      AppLocalizations.of(context)!.neurologist,
    ];

    /// generates a list of CustomCard-Widgets
    cards = List<CustomCard>.generate(
      4,
      (int index) => CustomCard(
        physicianType: physicianType.elementAt(index),
      ),
    );

    return Column(
      children: cards,
    );
  }
}

/// This class serves for customizing the card properties showing information
/// about the corresponding physicians
class CustomCard extends StatelessWidget {
  /// CustomCard constructor
  const CustomCard({
    required this.physicianType,
    Key? key,
  }) : super(key: key);

  /// initialized physicianType-variable which is used to
  /// show the physician type
  final String physicianType;

  @override
  Widget build(BuildContext context) {
    return PicosListCard(
      title: physicianType,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${AppLocalizations.of(context)!.practice} xyz',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${AppLocalizations.of(context)!.mr}/${AppLocalizations.of(context)!.mrs} Dr. Vorname Nachname',
            ),
            const Text('Musterstraße 1'),
            const Text('00000 Musterstadt'),
            const Text('Tel. +49 000 12 34 56'),
            const Text('name@webmail.de'),
            const Text('www.praxis-name.de')
          ],
        ),
      ),
    );
  }
}

/// This is the screen in which a user will see a list of his physicians
class PhysiciansScreen extends StatelessWidget {
  /// Physicians constructor
  const PhysiciansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myPhysicians),
        backgroundColor: const Color.fromRGBO(
          25,
          102,
          117,
          1.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromRGBO(
            232,
            241,
            243,
            1,
          ),
          child: const MyCard(),
        ),
      ),
      bottomNavigationBar: const PicosAddMonoButtonBar(
        route: '/add-physician',
      ),
    );
  }
}
