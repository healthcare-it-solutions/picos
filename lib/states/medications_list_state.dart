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

part of 'medications_list_bloc.dart';

/// Possible states for the list can contain.
enum MedicationsListStatus {
  /// The initial state on creation.
  initial,

  /// State for loading or processing.
  loading,

  /// State when loading was successful.
  success,

  /// State when loading failed.
  failure
}

/// Handles the MedicationsListState.
class MedicationsListState extends Equatable {
  /// MedicationsListState constructor.
  const MedicationsListState({
    this.medicationsList = const <Medication>[],
    this.status = MedicationsListStatus.initial,
  });

  /// The current [MedicationsListStatus].
  final MedicationsListStatus status;

  /// The current [medicationsList] containing all medications.
  final List<Medication> medicationsList;

  /// Creates a copy with updated values.
  MedicationsListState copyWith({
    List<Medication>? medicationsList,
    MedicationsListStatus? status,
    bool? hasReachedMax,
  }) {
    return MedicationsListState(
      status: status ?? this.status,
      medicationsList: medicationsList ?? this.medicationsList,
    );
  }

  @override
  List<Object> get props => <Object>[status, medicationsList];
}
