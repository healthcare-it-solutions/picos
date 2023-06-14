import 'package:parse_server_sdk/parse_server_sdk.dart';

class PatientJoinResult {
  ParseObject? _patient;
  ParseObject? _patientData;
  ParseObject? _patientProfile;

  PatientJoinResult(this._patient, this._patientData, this._patientProfile);

  ParseObject? getPatient() {
    return _patient;
  }

  ParseObject? getPatientData() {
    return _patientData;
  }

  ParseObject? getPatientProfile() {
    return _patientProfile;
  }

  void setPatient(ParseObject newPatient) {
    _patient = newPatient;
  }

  void setPatientData(ParseObject newPatientData) {
    _patientData = newPatientData;
  }

  void setPatientProfile(ParseObject newPatientProfile) {
    _patientProfile = newPatientProfile;
  }
}
