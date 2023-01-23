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
import 'package:picos/widgets/picos_ink_well_button.dart';

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
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

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
      Navigator.of(con).pushNamed(route);
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
    _controller.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                const Image(
                  image: AssetImage('assets/PICOS_Logo_RGB.png'),
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      height: 2,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Herzlich Willkommen bei PICOS,\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            '''Vielen Dank, dass Sie sich für die Teilnahme an dem Projekt DISTANCE entschieden haben. Wir wünschen viel Freude bei der Nutzung der PICOS App!''',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _loginController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Login',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Passwort',
                    ),
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
                    text: 'Einloggen',
                  ),
                ),
                _loginfailure
                    ? const Text('Falsches Passwort')
                    : const Text(''),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Image(
                      image: AssetImage('assets/BMBF.png'),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Image(
                      image: AssetImage('assets/Logo_MII.png'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
