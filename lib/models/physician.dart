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

/// Class with physician information.
class Physician extends AbstractDatabaseObject {
  /// Creates a physician object.
  const Physician({
    required this.name,
    required this.address,
    required this.city,
    required this.homepage,
    required this.lastName,
    required this.mail,
    required this.phone,
    required this.subjectArea,
    required this.form,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// Subject area of the physician.
  final String subjectArea;

  /// The gender of the physician.
  final String form;

  /// Name of the physician
  final String name;

  /// Last name.
  final String lastName;

  /// E-Mail address.
  final String mail;

  /// Phone number.
  final String phone;

  /// Location of the physician.
  final String address;

  /// City.
  final String city;

  /// Homepage of the physician.
  final String homepage;

  /// The database table the objects are stored in.
  static const String databaseTable = 'PICOS_treating';

  @override
  get table {
    return databaseTable;
  }

  /// Returns a copy of this physician with the given values updated.
  @override
  Physician copyWith({
    String? form,
    String? name,
    String? address,
    String? city,
    String? homepage,
    String? lastName,
    String? mail,
    String? phone,
    String? subjectArea,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Physician(
      form: form ?? this.form,
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      homepage: homepage ?? this.homepage,
      lastName: lastName ?? this.lastName,
      mail: mail ?? this.mail,
      phone: phone ?? this.phone,
      subjectArea: subjectArea ?? this.subjectArea,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => <Object>[
        form,
        name,
        address,
        city,
        homepage,
        lastName,
        mail,
        phone,
        subjectArea,
      ];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        'Form': form,
        'Name': name,
        'Address': address,
        'City': city,
        'Homepage': homepage,
        'Lastname': lastName,
        'Mail': mail,
        'Tele': phone,
        'SubjectArea': subjectArea
      };
}
