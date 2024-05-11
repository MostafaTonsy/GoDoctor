import 'package:doctor_reservation/FEATURES/DOCTOR_PAGES/DOC_INFO_REPO_controller_reservation/DOC_INFO_REPOSITORY.dart';
import 'package:doctor_reservation/models/DOCTOR_MODEL.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Doc_info_controller_PROVIDER = Provider((ref) {
  final doctorsInfoRepositoryProviderRef =
      ref.watch(DOC_INFO_REPOSITORY_provider);
  return Doc_info_controller(
      doc_INFO_REPOSITORY: doctorsInfoRepositoryProviderRef, ref: ref);
});

class Doc_info_controller {
  final DOC_INFO_REPOSITORY doc_INFO_REPOSITORY;
  final ProviderRef ref;
  const Doc_info_controller(
      {required this.doc_INFO_REPOSITORY, required this.ref});

  Future<List<DOCTOR_MODEL>> GET_DOCTORS_LIST() async {
    return await doc_INFO_REPOSITORY.GET_DOCTORS_LIST();
  }

  Future<List<DOCTOR_MODEL>> GET_TOP_RATED_DOCTORS_LIST() async {
    return await doc_INFO_REPOSITORY.GET_TOP_RATED_DOCTORS_LIST();
  }

  Future<DOCTOR_MODEL> get_current_doctor_Data() async {
    return doc_INFO_REPOSITORY.get_current_doctor_Data();
  }

  Future<void> update_doctor_user_Data(
      {required String field_key, required String f_v}) async {
    await doc_INFO_REPOSITORY.update_doctor_user_Data(
        field_key: field_key, f_v: f_v);
  }

  // Future<double> get_average_Rating_of_doctor({
  //   required String doctor_id,
  // }) async {
  //   return await doc_INFO_REPOSITORY.get_average_Rating_of_doctor(
  //     doctor_id: doctor_id,
  //   );
  // }
}
