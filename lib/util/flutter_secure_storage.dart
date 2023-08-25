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

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Class for flutter secure storage.
class SecureStorage {
  /// Creates the storage.
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  static const String _keyUsername = 'username';
  static const String _keyPassword = 'password';
  static const String _keyIsChecked = 'isChecked';

  /// Sets username.
  Future<void> setUsername(String username) async {
    await _storage.write(key: _keyUsername, value: username);
  }

  /// Retrieves username.
  Future<String?> getUsername() async {
    return await _storage.read(key: _keyUsername);
  }

  /// Sets password.
  Future<void> setPassword(String password) async {
    await _storage.write(key: _keyPassword, value: password);
  }

  /// Retrieves password.
  Future<String?> getPassword() async {
    return await _storage.read(key: _keyPassword);
  }

  /// Sets isChecked used for Checkbox.
  Future<void> setIsChecked(bool isChecked) async {
    await _storage.write(key: _keyIsChecked, value: isChecked.toString());
  }

  /// Retrieves isChecked used for Checkbox.
  Future<String?> getIsChecked() async {
    return await _storage.read(key: _keyIsChecked);
  }

  /// Deletes all keys with corresponding values.
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
