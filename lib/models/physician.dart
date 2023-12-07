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
import 'package:picos/models/abstract_database_object.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Class with physician information.
class Physician extends AbstractDatabaseObject {
  /// Creates a physician object.
  const Physician({
    this.practice,
    this.address,
    this.city,
    this.homepage,
    this.lastName,
    this.mail,
    this.phone,
    this.subjectArea,
    this.firstName,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(objectId: objectId, createdAt: createdAt, updatedAt: updatedAt);

  /// Subject area of the physician.
  final String? subjectArea;

  /// Name of the practice
  final String? practice;

  /// Last name.
  final String? lastName;

  /// E-Mail address.
  final String? mail;

  /// Phone number.
  final String? phone;

  /// Location of the physician.
  final String? address;

  /// City.
  final String? city;

  /// Homepage of the physician.
  final String? homepage;

  /// The first name of the physician.
  final String? firstName;

  /// The database table the objects are stored in.
  static const String databaseTable = 'PICOS_treating';

  @override
  get table {
    return databaseTable;
  }

  /// Returns a copy of this physician with the given values updated.
  @override
  Physician copyWith({
    String? practice,
    String? address,
    String? city,
    String? homepage,
    String? lastName,
    String? mail,
    String? phone,
    String? subjectArea,
    String? firstName,
    String? objectId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Physician(
      firstName: firstName ?? this.firstName,
      practice: practice ?? this.practice,
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
  List<Object> get props => <Object>[];

  @override
  Map<String, dynamic> get databaseMapping => <String, dynamic>{
        'Name': practice,
        'Address': address,
        'City': city,
        'Homepage': homepage,
        'Lastname': lastName,
        'Mail': mail,
        'Tele': phone,
        'SubjectArea': subjectArea,
        'Firstname': firstName,
      };
}

/// The possible subject areas.
enum PhysicianSubjectArea {
  /// Ophthalmology
  ophthalmology,

  /// Gynecology
  gynecology,

  /// Otolaryngology
  otolaryngology,

  /// General practitioner
  generalPractitioner,

  /// Skin and venereal diseases
  skinAndVenerealDiseases,

  /// Internal medicine
  internalMedicine,

  /// Microbiology
  microbiology,

  /// Neurology
  neurology,

  /// Pathology
  pathology,

  /// Pulmonology
  pulmonology,

  /// Psychiatry
  psychiatry,

  /// Urology
  urology,

  /// Other
  other,
}

/// Extension for [PhysicianSubjectArea].
extension PhysicianSubjectAreaConverter on PhysicianSubjectArea {
  /// Takes [value] and returns the corresponding [PhysicianSubjectArea].
  static PhysicianSubjectArea stringToPhysicianSubjectArea(String value) {
    return PhysicianSubjectArea.values.firstWhere(
      (PhysicianSubjectArea element) => element.name == value,
    );
  }

  /// Get the localized name.
  String getLocalization(BuildContext context) {
    switch (this) {
      case PhysicianSubjectArea.ophthalmology:
        return AppLocalizations.of(context)!.ophthalmology;
      case PhysicianSubjectArea.gynecology:
        return AppLocalizations.of(context)!.gynecology;
      case PhysicianSubjectArea.otolaryngology:
        return AppLocalizations.of(context)!.otolaryngology;
      case PhysicianSubjectArea.generalPractitioner:
        return AppLocalizations.of(context)!.generalPractitioner;
      case PhysicianSubjectArea.skinAndVenerealDiseases:
        return AppLocalizations.of(context)!.skinAndVenerealDiseases;
      case PhysicianSubjectArea.internalMedicine:
        return AppLocalizations.of(context)!.internalMedicine;
      case PhysicianSubjectArea.microbiology:
        return AppLocalizations.of(context)!.microbiology;
      case PhysicianSubjectArea.neurology:
        return AppLocalizations.of(context)!.neurology;
      case PhysicianSubjectArea.pathology:
        return AppLocalizations.of(context)!.pathology;
      case PhysicianSubjectArea.pulmonology:
        return AppLocalizations.of(context)!.pulmonology;
      case PhysicianSubjectArea.psychiatry:
        return AppLocalizations.of(context)!.psychiatry;
      case PhysicianSubjectArea.urology:
        return AppLocalizations.of(context)!.urology;
      case PhysicianSubjectArea.other:
        return AppLocalizations.of(context)!.other;
      default:
        return AppLocalizations.of(context)!.other;
    }
  }
}
