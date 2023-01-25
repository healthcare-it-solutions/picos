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

import 'package:picos/api/medications_api.dart';
import 'package:picos/models/medication.dart';

/// A repository that handles medication related requests.
class MedicationsRepository {
  /// MedicationsRepository constructor.
  const MedicationsRepository({
    required MedicationsApi medicationsApi,
  }) : _medicationsApi = medicationsApi;

  final MedicationsApi _medicationsApi;

  /// Provides a [Stream] of all medications.
  Future<Stream<List<Medication>>> getMedications() {
    return _medicationsApi.getMedications();
  }

  /// Saves or replaces a [medication].
  Future<void> saveMedication(Medication medication) {
    return _medicationsApi.saveMedication(medication);
  }

  /// Removes a given [medication].
  Future<void> removeMedication(Medication medication) {
    return _medicationsApi.removeMedication(medication);
  }

  /// Converts a Medication amount Double to String.
  static String amountToString(double value) {
    List<String> values = value.toString().split('.');
    String intValue = values[0];
    String half = '0';
    if (values.length > 1) {
      half =  values[1];
    }

    if (intValue == '0' && half != '0') {
      return '1/2';
    }

    if (intValue != '0' && half != '0') {
      return '$intValue 1/2';
    }

    return intValue;
  }

  /// Converts a Medication amount String to Double.
  static double amountToDouble(String value) {
    if (value.length == 3 && value.substring(value.length - 3) == '1/2') {
      return 0.5;
    }

    if (value.length >= 4 && value.substring(value.length - 4) == ' 1/2') {
      return double.parse(value.split(' ')[0]) + 0.5;
    }

    return double.parse(value);
  }
}
