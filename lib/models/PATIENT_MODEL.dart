// ignore_for_file: non_constant_identifier_names

class PATIENT_MODEL {
  final String ID;
  final String NAME;
  final String PROFILE_PIC_URL;
  final String PHONE_NUMBER;

  const PATIENT_MODEL({
    required this.ID,
    required this.NAME,
    required this.PROFILE_PIC_URL,
    required this.PHONE_NUMBER,
  });

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'NAME': NAME,
      'PROFILE_PIC_URL': PROFILE_PIC_URL,
      'PHONE_NUMBER': PHONE_NUMBER,
    };
  }

  factory PATIENT_MODEL.fromMap(Map<String, dynamic> map) {
    return PATIENT_MODEL(
      ID: map['ID'] ?? '',
      NAME: map['NAME'] ?? '',
      PROFILE_PIC_URL: map['PROFILE_PIC_URL'] ?? '',
      PHONE_NUMBER: map['PHONE_NUMBER'] ?? '',
    );
  }
}
