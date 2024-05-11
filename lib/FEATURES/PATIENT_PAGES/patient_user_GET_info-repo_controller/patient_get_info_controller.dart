import 'package:doctor_reservation/FEATURES/PATIENT_PAGES/patient_user_GET_info-repo_controller/patient_get_info_REPO.dart';
import 'package:doctor_reservation/models/DOCTOR_MODEL.dart';
import 'package:doctor_reservation/models/PATIENT_MODEL.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final patient_get_info_controller__provider = Provider((ref) {
  final patient_get_info_repos_provider_ref =
      ref.watch(Patient_get_info_repos_provider);

  return get_patient_info_controller(
      patient_get_info: patient_get_info_repos_provider_ref);
});

class get_patient_info_controller {
  final Patient_get_info_repos patient_get_info;

  const get_patient_info_controller({required this.patient_get_info});

  Future<PATIENT_MODEL> get_current_patient_Data() async {
    return await patient_get_info.get_current_patient_Data();
  }

  Future<List<DOCTOR_MODEL>> GET_DOCTORS_LIST() async {
    return await patient_get_info.GET_DOCTORS_LIST();
  }

  Future<List<DOCTOR_MODEL>> GET_TOP_RATED_DOCTORS_LIST() async {
    return await patient_get_info.GET_TOP_RATED_DOCTORS_LIST();
  }

  Future<void> update_patient_user_Data(
      {required String field_key, required String Fieldvalue}) async {
    await patient_get_info.update_patient_user_Data(
        field_key: field_key, Fieldvalue: Fieldvalue);
  }
}
