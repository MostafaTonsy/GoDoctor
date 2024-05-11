import 'package:doctor_reservation/FEATURES/PATIENT_PAGES/patient_user_GET_info-repo_controller/patient_get_info_controller.dart';
import 'package:doctor_reservation/FEATURES/RESERVATION%20repo&controller/RESERVATION_REPOSITORY.dart';
import 'package:doctor_reservation/models/RESERVATION_MODEL.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservation_controller_provider = Provider((ref) {
  final reservationRepoProviderRef = ref.watch(RESERVATION_REPO_PROVIDER);
  return RESERVATION_CONTROLLER(
      reservation_repo: reservationRepoProviderRef, ref: ref);
});

class RESERVATION_CONTROLLER {
  final RESERVATION_REPO reservation_repo;
  final ProviderRef ref;
  const RESERVATION_CONTROLLER(
      {required this.reservation_repo, required this.ref});

  Future<void> book_reservation(
      {required String doctor_id,
      required String doctor_name,
      required String doctor_phone_number,
      required DateTime time,
      required String doctor_photourl,
      required BuildContext context}) async {
    final patient = await ref
        .watch(patient_get_info_controller__provider)
        .get_current_patient_Data();

    await reservation_repo.book_reservation(
        time: time,
        doctor_photourl: doctor_photourl,
        patient_photourl: patient.PROFILE_PIC_URL,
        doctor_phone_number: doctor_phone_number,
        patient_phone_number: patient.PHONE_NUMBER,
        patient_name: patient.NAME,
        doctor_id: doctor_id,
        doctor_name: doctor_name,
        context: context);
  }

  Future<List<RESERVATION_MODEL>> get_all_reservations_for_doctor() async {
    return await reservation_repo.get_all_reservations_for_doctor();
  }

  Future<List<RESERVATION_MODEL>> get_all_reservations_for_patient() async {
    return await reservation_repo.get_all_reservations_for_patient();
  }

  Future<void> delete_reservation({required RESERVATION_ID}) async {
    await reservation_repo.delete_reservation(RESERVATION_ID: RESERVATION_ID);
  }
}
