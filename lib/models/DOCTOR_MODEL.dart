// ignore_for_file: non_constant_identifier_names

class DOCTOR_MODEL {
  final String ID;
  final String NAME;
  final String JOB_TITLE;
  final String OTHER_DETAILS;
  final String CLINIC_ADDRESS;
  final String WORKING_HOURS;
  final String PROFILE_PIC;
  final String PHONE_NUMBER;
  final double average_rating;

  const DOCTOR_MODEL(
      {required this.ID,
      required this.NAME,
      required this.JOB_TITLE,
      required this.OTHER_DETAILS,
      required this.CLINIC_ADDRESS,
      required this.WORKING_HOURS,
      required this.PROFILE_PIC,
      required this.PHONE_NUMBER,
      required this.average_rating});

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'NAME': NAME,
      'JOB_TITLE': JOB_TITLE,
      'OTHER_DETAILS': OTHER_DETAILS,
      'CLINIC_ADDRESS': CLINIC_ADDRESS,
      'WORKING_HOURS': WORKING_HOURS,
      'PROFILE_PIC': PROFILE_PIC,
      'PHONE_NUMBER': PHONE_NUMBER,
      'average_rating': average_rating
    };
  }

  factory DOCTOR_MODEL.fromMap(Map<String, dynamic> map) {
    return DOCTOR_MODEL(
        ID: map['ID'] ?? '',
        NAME: map['NAME'] ?? '',
        JOB_TITLE: map['JOB_TITLE'] ?? '',
        OTHER_DETAILS: map['OTHER_DETAILS'] ?? '',
        CLINIC_ADDRESS: map['CLINIC_ADDRESS'] ?? '',
        WORKING_HOURS: map['WORKING_HOURS'] ?? '',
        PROFILE_PIC: map['PROFILE_PIC'] ?? '',
        PHONE_NUMBER: map['PHONE_NUMBER'] ?? '',
        average_rating: double.parse(map['average_rating'].toString()));
  }
}
