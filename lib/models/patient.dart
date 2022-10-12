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

import 'package:picos/models/abstract_database_object.dart';
import 'package:random_password_generator/random_password_generator.dart';

/// Enumeration for FormOfAddress-variable.
enum FormOfAddress {
  /// Element for denoting 'male'.
  male,
  /// Element for denoting 'female'.
  female,
}

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
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The database table the objects are stored in.
  static const String databaseTable = '_User';

  /// Stores the role that is being created.
  static const String role = 'Patient';

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
    final RandomPasswordGenerator password = RandomPasswordGenerator();

    return password.randomPassword(
      letters: true,
      uppercase: false,
      numbers: true,
      specialChar: false,
      passwordLength: 6,
    );
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
