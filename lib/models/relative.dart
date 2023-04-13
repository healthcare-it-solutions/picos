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

/// Class with relative information.
class Relative extends AbstractDatabaseObject {
  /// Creates a relative object.
  const Relative({
    required this.type,
    required this.address,
    required this.city,
    required this.lastName,
    required this.mail,
    required this.phone,
    required this.firstName,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// The relative type.
  final String type;

  /// Last name.
  final String lastName;

  /// E-Mail address.
  final String mail;

  /// Phone number.
  final String phone;

  /// Address of the relative.
  final String address;

  /// City.
  final String city;

  /// The first name of the relative.
  final String firstName;

  /// The database table the objects are stored in.
  static const String databaseTable = 'PICOS_relatives';

  @override
  get table {
    return databaseTable;
  }

  /// Returns a copy of this relative with the given values updated.
  @override
  Relative copyWith({
    String? type,
    String? lastName,
    String? mail,
    String? phone,
    String? address,
    String? city,
    String? firstName,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Relative(
      type: type ?? this.type,
      lastName: lastName ?? this.lastName,
      mail: mail ?? this.mail,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      firstName: firstName ?? this.firstName,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[
        address,
        city,
        lastName,
        mail,
        phone,
        firstName,
        type,
      ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        'Address': address,
        'City': city,
        'Lastname': lastName,
        'Mail': mail,
        'Tele': phone,
        'Name': firstName,
        'Type': type,
      };
}
