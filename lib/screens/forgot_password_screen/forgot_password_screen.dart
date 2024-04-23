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
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/picos_ink_well_button.dart';
import '../../widgets/picos_label.dart';
import '../../widgets/picos_text_field.dart';

/// Displays the forgot password screen.
class ForgotPasswordScreen extends StatefulWidget {
  /// ForgotPasswordScreen constructor.
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static final RegExp emailRegex = RegExp('.+@.+', caseSensitive: false);

  Future<void> resetPassword(String email) async {
    try {
      await ParseUser(null, null, email).requestPasswordReset();
      if (mounted) {
        showSnackBarMessage(AppLocalizations.of(context)!.ifEmailCorrect);
      }
    } on ParseException catch (e) {
      showSnackBarMessage('Error: $e');
    }
  }

  void showSnackBarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void validateAndResetPassword() {
    if (formKey.currentState!.validate()) {
      resetPassword(emailController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PicosScreenFrame(
      title: AppLocalizations.of(context)!.forgotPassword,
      body: PicosBody(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Text(AppLocalizations.of(context)!.enterMailToResetPW),
              const SizedBox(height: 10),
              PicosLabel(AppLocalizations.of(context)!.email),
              emailInputField(),
              resetPasswordButton(),
            ],
          ),
        ),
      ),
    );
  }

  PicosTextField emailInputField() {
    return PicosTextField(
      controller: emailController,
      hint: AppLocalizations.of(context)!.email,
      keyboardType: TextInputType.emailAddress,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.entryEmail;
        } else if (!emailRegex.hasMatch(value)) {
          return AppLocalizations.of(context)!.entryValidEmail;
        }
        return null;
      },
    );
  }

  Widget resetPasswordButton() {
    return PicosInkWellButton(
      text: AppLocalizations.of(context)!.resetPassword,
      onTap: validateAndResetPassword,
    );
  }
}
