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
import 'package:picos/util/backend.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_ink_well_button.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/widgets/picos_text_field.dart';

// We don't reference provider directly but
// to invoke context.read<T>()
// ignore: depend_on_referenced_packages, unused_import
// import 'package:provider/provider.dart';

///Displays the login screen.
class LoginScreen extends StatefulWidget {
  ///LoginScreen constructor.
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// TODO: make the text widgets go red on login failure
// TODO: display an animated toast

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

  late final TextEditingController _loginController;
  late final TextEditingController _passwordController;

  bool _loginfailure = false;

  Future<void> _submitHandler(
    String login,
    String password,
    BuildContext con,
  ) async {
    Backend();
    bool res = await Backend.login(login, password);
    String route = await Backend.getRole();

    // This belongs here, because of context usage in async
    if (!mounted) return;
    if (res) {
      Navigator.of(con).pushReplacementNamed(route);
    } else {
      setState(() {
        _loginfailure = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PicosScreenFrame(
      body: Center(
        child: PicosBody(
          child: Column(
            children: <Widget>[
              const Image(
                image: AssetImage('assets/PICOS_Logo_RGB.png'),
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    height: 2,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          '${AppLocalizations.of(context)!.welcomeToPICOS},\n',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!
                          .thankYouForParticipation,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 200,
                child: PicosTextField(
                  controller: _loginController,
                  hint: AppLocalizations.of(context)!.username,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                child: PicosTextField(
                  controller: _passwordController,
                  hint: AppLocalizations.of(context)!.password,
                  obscureText: true,
                ),
              ),
              SizedBox(
                width: 200,
                child: PicosInkWellButton(
                  onTap: () => _submitHandler(
                    _loginController.text,
                    _passwordController.text,
                    context,
                  ),
                  text: AppLocalizations.of(context)!.submit,
                ),
              ),
              _loginfailure
                  ? Text(AppLocalizations.of(context)!.wrongCredentials)
                  : const Text(''),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Expanded(
                    child: Image(
                      image: AssetImage('assets/BMBF.png'),
                    ),
                  ),
                  Expanded(
                    child: Image(
                      image: AssetImage('assets/Logo_MII.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
