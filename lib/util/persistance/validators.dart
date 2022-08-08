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

import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This class contains methods for validations.
class Validators {
  /// delivers methods for validations.
  const Validators({
    required this.context,
  });

  /// Class variable for storing the context.
  final BuildContext context;

  /// returns a message (String)
  /// whether URL validation is successful or not
  String? validateURL(String value) {
    if (!Uri.parse(value).isAbsolute) {
      return AppLocalizations.of(context)!.entryValidWebsite;
    }
    return null;
  }
}
