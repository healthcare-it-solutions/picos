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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(1.5, 0.0),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ),
  );

  late final TextEditingController _loginController;
  late final TextEditingController _passwordController;

  bool _loginfailure = false;

  void _submitHandler(String login, String password, BuildContext context) {
    if (login == 'Funkner' && password == 'Funkner') {
      Navigator.of(context).pushNamed('/mainscreen');
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
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _controller.forward();
                // Navigator.of(context).pushNamed('/mainscreen');
              },
              child: const Text('log in'),
            ),
            SlideTransition(
              position: _offsetAnimation,
              child: FadeTransition(
                opacity: _controller,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _loginController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Login',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _submitHandler(_loginController.text,
                          _passwordController.text, context),
                      child: Text('Submit'),
                    ),
                    _loginfailure ? Text('Wrong Password') : Text('')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
