/*   This file is part of Picos, a health trcking mobile app
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

/// This is the screen a user will see a list of his family members
class FamilyMembers extends StatelessWidget {
  // ignore: public_member_api_docs
  const FamilyMembers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Card(
        margin: const EdgeInsets.all(20),
        clipBehavior: Clip.none,
        child: Padding(padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              tileColor: Color.fromRGBO(25, 102, 117, 1.0),
              textColor: Colors.white,
              title: Text('Vater', style: TextStyle(
                fontWeight: FontWeight.bold
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text('Herr Max Mustermann'),
                    Text('Musterstraße 1'),
                    Text('Tel. +49 000 12 34 56'),
                    Text('name@webmail.de')
                  ],
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      //Implement here
                    }, 
                    child: const Text('Bearbeiten'),
                  ),
                  TextButton(
                    onPressed: () {
                    //Implement here
                    },
                    child: const Text('Löschen')
                  )
                ],
              )
            ],
          )  )
      ),
      Card(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        clipBehavior: Clip.none,
        child: Padding(padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              tileColor: Color.fromRGBO(25, 102, 117, 1.0),
              textColor: Colors.white,
              title: Text('Vater', style: TextStyle(
                fontWeight: FontWeight.bold
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text('Herr Max Mustermann'),
                    Text('Musterstraße 1'),
                    Text('Tel. +49 000 12 34 56'),
                    Text('name@webmail.de')
                  ],
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      //Implement here
                    }, 
                    child: const Text('Bearbeiten'),
                  ),
                  TextButton(
                    onPressed: () {
                    //Implement here
                    },
                    child: const Text('Löschen')
                  )
                ],
              )
            ],
          )  
        )
      ),
      Card(
        margin: const EdgeInsets.all(20),
        clipBehavior: Clip.none,
        child: Padding(padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              tileColor: Color.fromRGBO(25, 102, 117, 1.0),
              textColor: Colors.white,
              title: Text('Vater', style: TextStyle(
                fontWeight: FontWeight.bold
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text('Herr Max Mustermann'),
                    Text('Musterstraße 1'),
                    Text('Tel. +49 000 12 34 56'),
                    Text('name@webmail.de')
                  ],
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      //Implement here
                    }, 
                    child: const Text('Bearbeiten'),
                  ),
                  TextButton(
                    onPressed: () {
                    //Implement here
                    },
                    child: const Text('Löschen')
                  )
                ],
              )
            ],
          )  )
      )
    ]
    );
  }
}
