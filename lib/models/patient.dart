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

import 'dart:math';

import 'package:picos/models/abstract_database_object.dart';

import '../util/backend.dart';

/// Class with patient information.
class Patient extends AbstractDatabaseObject {
  /// Creates a patient object.
  const Patient({
    required this.firstName,
    required this.familyName,
    required this.email,
    required this.number,
    required this.address,
    required this.formOfAddress,
    this.role = UserRoles.patient,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = '_User';

  /// Stores the first name of the patient;
  final String firstName;

  /// Stores the last name of the patient.
  final String familyName;

  /// Stores the email-address of the patient.
  final String email;

  /// Stores the phone number of the patient.
  final String number;

  /// Stores the address of the patient.
  final String address;

  /// Contains the gender of the patient.
  final String formOfAddress;

  /// Stores the role that is being created.
  final String role;

  @override
  get table {
    return databaseTable;
  }

  /// Returns a copy of this patient with the given values updated.
  @override
  Patient copyWith({
    String? firstName,
    String? familyName,
    String? email,
    String? number,
    String? address,
    String? formOfAddress,
    String? role,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Patient(
      firstName: firstName ?? this.firstName,
      familyName: familyName ?? this.familyName,
      email: email ?? this.email,
      number: number ?? this.number,
      address: address ?? this.address,
      formOfAddress: formOfAddress ?? this.formOfAddress,
      role: role ?? this.role,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[
        firstName,
        familyName,
        email,
        number,
        address,
        formOfAddress,
      ];

  /// Method that returns a random password.
  static String _createPassword() {
    // A non-negative number for determining the length of the password.
    const int length = 8;
    const String letters = 'abcdefghijklmnopqrstuvwxyz';
    const String capitals = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String numbers = '0123456789';
    Random randomString = Random.secure();

    String password = '';
    password += letters[randomString.nextInt(letters.length)];
    password += capitals[randomString.nextInt(capitals.length)];
    password += numbers[randomString.nextInt(numbers.length)];

    String allCharacters = letters + capitals + numbers;
    for (int i = password.length; i < length; i++) {
      password += allCharacters[randomString.nextInt(allCharacters.length)];
    }

    List<int> passwordChars = List<int>.of(password.codeUnits);
    passwordChars.shuffle(randomString);
    return String.fromCharCodes(passwordChars);
  }

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        'username': email,
        'password': _createPassword(),
        'email': email,
        'Form': formOfAddress,
        'Firstname': firstName,
        'Lastname': familyName,
        'PhoneNo': number,
        'Address': address,
        'Role': role,
      };
}
