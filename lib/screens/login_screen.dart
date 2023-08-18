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
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///Displays the login screen.
class LoginScreen extends StatefulWidget {
  ///LoginScreen constructor.
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _loginController;
  late final TextEditingController _passwordController;

  final SecureStorage _secureStorage = SecureStorage();

  BackendError? _backendError;

  bool _passwordVisible = false;
  bool _sendDisabled = false;

  static const double _sponsorLogoPadding = 30;

  Future<void> fetchSecureStorageData() async {
    _loginController.text = await _secureStorage.getUsername() ?? '';
    _passwordController.text = await _secureStorage.getPassword() ?? '';
  }

  Future<void> _submitHandler(
    String username,
    String password,
    BuildContext con,
  ) async {
    setState(() {
      _sendDisabled = true;
    });

    BackendError? login = await Backend.login(username, password);

    if (login == null) {
      String route = await Backend.getRole();
      // This belongs here, because of context usage in async
      if (!mounted) return;
      Navigator.of(con).pushReplacementNamed(route);
      return;
    }

    setState(() {
      _backendError = login;
      _sendDisabled = false;
    });
  }

  @override
  void initState() {
    super.initState();
    Backend();
    _loginController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
    fetchSecureStorageData();
    _passwordVisible = false;
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
              _backendError != null
                  ? Text(
                      _backendError!.getMessage(context),
                      style: const TextStyle(color: Color(0xFFe63329)),
                    )
                  : const Text(''),
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
                  obscureText: !_passwordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                    ),
                    color: Colors.grey,
                    onPressed: () => setState(() {
                      _passwordVisible = !_passwordVisible;
                    }),
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: PicosInkWellButton(
                  disabled: _sendDisabled,
                  onTap: () {
                    _submitHandler(
                      _loginController.text,
                      _passwordController.text,
                      context,
                    );

                    if (!_sendDisabled) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Passwort speichern'),
                            content: const Text(
                              'Wollen Sie Ihre Zugangsdaten speichern?',
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Speichern'),
                                onPressed: () {
                                  if (_secureStorage.getUsername().toString() !=
                                      _loginController.text) {
                                    _secureStorage
                                        .setUsername(_loginController.text);
                                    _secureStorage
                                        .setPassword(_passwordController.text);
                                  }

                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Nein'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  text: AppLocalizations.of(context)!.submit,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(_sponsorLogoPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Image(
                        image: AssetImage('assets/BMBF.png'),
                      ),
                    ),
                    SizedBox(width: _sponsorLogoPadding),
                    Expanded(
                      child: Image(
                        image: AssetImage('assets/Logo_MII.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Class for flutter secure storage.
class SecureStorage {
  /// Creates the storage.
  final FlutterSecureStorage storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  final String _keyUsername = 'username';
  final String _keyPassword = 'password';

  /// Sets username.
  Future<void> setUsername(String username) async {
    await storage.write(key: _keyUsername, value: username);
  }

  /// Retrieves username.
  Future<String?> getUsername() async {
    return await storage.read(key: _keyUsername);
  }

  /// Sets password.
  Future<void> setPassword(String password) async {
    await storage.write(key: _keyPassword, value: password);
  }

  /// Retrieves password.
  Future<String?> getPassword() async {
    return await storage.read(key: _keyPassword);
  }
}
