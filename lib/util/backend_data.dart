/// enumeration for gender-variable.
enum Gender {
  /// element for denoting the title of men
  male,

  /// element for denoting the title of women
  female,
}

// TODO: is there a better approach?

/// class for personal data variables.
class PersonalData {
  /// stores the first name of the patient;
  static String firstName = '';

  /// stores the last name of the patient.
  static String familyName = '';

  /// stores the email-address of the patient.
  static String email = '';

  /// stores the phone number of the patient.
  static String number = '';

  /// stores the address of the patient.
  static String address = '';

  /// contains the Gender of the patient.
  static Gender gender = Gender.female;
}

/// class for parameter variables.
class Parameters {
  /// contains patient's weight.
  static bool weightBMIEnabled = false;

  /// contains patient's heart frequency.
  static bool heartFrequencyEnabled = false;

  /// contains patient's blood pressure.
  static bool bloodPressureEnabled = false;

  /// contains patient's blood sugar level.
  static bool bloodSugarLevelsEnabled = false;

  /// contains patient's walk distance.
  static bool walkDistanceEnabled = false;

  /// contains patient's sleep duration.
  static bool sleepDurationEnabled = false;

  /// contains patient's sleep quality.
  static bool sleepQualityEnabled = false;

  /// contains patient's pain.
  static bool painEnabled = false;

  /// contains patient's PHQ-4.
  static bool phq4Enabled = false;

  /// contains patient's medication.
  static bool medicationEnabled = false;

  /// contains patient's therapy.
  static bool therapyEnabled = false;

  /// contains patient's doctor's visit.
  static bool doctorsVisitEnabled = false;
}
