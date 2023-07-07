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

//TODO: Localizations

import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:picos/util/backend.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_ink_well_button.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:picos/widgets/picos_text_field.dart';

/// This is the screen for the user's profile information.
class ProfileScreen extends StatefulWidget {
  /// Constructor for Profile Screen.
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String errorMessage = '';
  String successMessage = '';

  TextEditingController newPassword = TextEditingController();
  TextEditingController newPasswordRepeat = TextEditingController();

  bool isStrongPassword(String password) {
    if (password.length < 8) {
      return false;
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return false;
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false;
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PicosScreenFrame(
      title: 'Profil',
      body: PicosBody(
        child: Column(
          children: <Widget>[
            const PicosLabel('Neues Passwort'),
            PicosTextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              controller: newPassword,
            ),
            const PicosLabel('Neues Passwort wiederholen'),
            PicosTextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              controller: newPasswordRepeat,
            ),
            PicosInkWellButton(
              text: 'Passwort ändern',
              onTap: () async {
                ParseUser currentUser = Backend.user;
                if (newPassword.text.isNotEmpty &&
                    newPasswordRepeat.text.isNotEmpty) {
                  if (newPassword.text != newPasswordRepeat.text) {
                    setState(() {
                      errorMessage = 'Neue Passwörter stimmen nicht überein!';
                      successMessage = '';
                    });
                  } else {
                    if (!isStrongPassword(newPassword.text)) {
                      setState(() {
                        errorMessage =
                            'Ihr Passwort muss aus Groß-, Kleinbuchstaben, '
                            'Sonderzeichen, Zahlen und insgesamt aus mindestens'
                            '8 Zeichen bestehen!';
                        successMessage = '';
                      });
                      return;
                    }
                    currentUser.password = newPassword.text;
                    ParseResponse responseSaveNewPassword =
                        await currentUser.save();
                    if (responseSaveNewPassword.success) {
                      setState(() {
                        errorMessage = '';
                        successMessage =
                            'Neues Passwort wurde erfolgreich gespeichert!';
                      });
                    }
                  }
                }
              },
            ),
            errorMessage != ''
                ? Text(
                    errorMessage,
                    style: const TextStyle(color: Color(0xFFe63329)),
                  )
                : successMessage != ''
                    ? Text(
                        successMessage,
                        style: const TextStyle(color: Colors.lightGreen),
                      )
                    : const Text(' '),
          ],
        ),
      ),
    );
  }
}
