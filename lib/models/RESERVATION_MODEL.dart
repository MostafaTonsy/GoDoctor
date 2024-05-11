// ignore_for_file: non_constant_identifier_names

class RESERVATION_MODEL {
  final String RESERVATION_ID;
  final DateTime RESERVATION_TIME;
  final String PATIENT_ID;
  final String DOCTOR_PROFILE_PIC_URL;
  final String PATIENT_PROFILE_PIC_URL;
  final String PATIENT_NAME;
  final String DOCTOR_PHONE_NUMBER;
  final String PATIENT_PHONE_NUMBER;
  final String DOCTOR_ID;
  final String DOCTOR_NAME;

  const RESERVATION_MODEL({
    required this.RESERVATION_ID,
    required this.RESERVATION_TIME,
    required this.PATIENT_ID,
    required this.DOCTOR_PHONE_NUMBER,
    required this.DOCTOR_PROFILE_PIC_URL,
    required this.PATIENT_PROFILE_PIC_URL,
    required this.PATIENT_PHONE_NUMBER,
    required this.PATIENT_NAME,
    required this.DOCTOR_ID,
    required this.DOCTOR_NAME,
  });

  Map<String, dynamic> toMap() {
    return {
      'RESERVATION_ID': RESERVATION_ID,
      'RESERVATION_TIME': RESERVATION_TIME.millisecondsSinceEpoch,
      'PATIENT_ID': PATIENT_ID,
      'PATIENT_NAME': PATIENT_NAME,
      'DOCTOR_ID': DOCTOR_ID,
      'DOCTOR_NAME': DOCTOR_NAME,
      'DOCTOR_PROFILE_PIC_URL': DOCTOR_PROFILE_PIC_URL,
      'PATIENT_PROFILE_PIC_URL': PATIENT_PROFILE_PIC_URL,
      'DOCTOR_PHONE_NUMBER': DOCTOR_PHONE_NUMBER,
      'PATIENT_PHONE_NUMBER': PATIENT_PHONE_NUMBER,
    };
  }

  factory RESERVATION_MODEL.fromMap(Map<String, dynamic> map) {
    return RESERVATION_MODEL(
      RESERVATION_ID: map['RESERVATION_ID'] ?? '',
      RESERVATION_TIME:
          DateTime.fromMillisecondsSinceEpoch(map['RESERVATION_TIME']),
      PATIENT_ID: map['PATIENT_ID'] ?? '',
      PATIENT_NAME: map['PATIENT_NAME'] ?? '',
      DOCTOR_ID: map['DOCTOR_ID'] ?? '',
      DOCTOR_PHONE_NUMBER: map['DOCTOR_PHONE_NUMBER'] ?? '',
      DOCTOR_PROFILE_PIC_URL: map['DOCTOR_PROFILE_PIC_URL'] ?? '',
      PATIENT_PROFILE_PIC_URL: map['PATIENT_PROFILE_PIC_URL'] ?? '',
      PATIENT_PHONE_NUMBER: map['PATIENT_PHONE_NUMBER'] ?? '',
      DOCTOR_NAME: map['DOCTOR_NAME'] ?? '',
    );
  }
}
