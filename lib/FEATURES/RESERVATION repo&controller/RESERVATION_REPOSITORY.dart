import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_reservation/Custom/show_snackbar.dart';
import 'package:doctor_reservation/models/RESERVATION_MODEL.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final RESERVATION_REPO_PROVIDER = Provider(
  (ref) => RESERVATION_REPO(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance),
);

class RESERVATION_REPO {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  const RESERVATION_REPO({required this.firestore, required this.auth});

  Future<void> book_reservation(
      {required String patient_name,
      required doctor_id,
      required doctor_name,
      required doctor_photourl,
      required patient_photourl,
      required doctor_phone_number,
      required DateTime time,
      required patient_phone_number,
      required BuildContext context}) async {
    final id = auth.currentUser!.uid;
    try {
      final reservationId = const Uuid().v1();
      final reservation = RESERVATION_MODEL(
          DOCTOR_PROFILE_PIC_URL: doctor_photourl,
          PATIENT_PROFILE_PIC_URL: patient_photourl,
          DOCTOR_PHONE_NUMBER: doctor_phone_number,
          PATIENT_PHONE_NUMBER: patient_phone_number,
          RESERVATION_ID: reservationId,
          RESERVATION_TIME: time,
          PATIENT_ID: id,
          PATIENT_NAME: patient_name,
          DOCTOR_ID: doctor_id,
          DOCTOR_NAME: doctor_name);

      await firestore
          .collection('reservations')
          .doc(reservationId)
          .set(reservation.toMap());
    } catch (e) {
      ShowSnackbar(ERROR: e.toString(), context: context);
    }
  }

  Future<List<RESERVATION_MODEL>> get_all_reservations_for_doctor() async {
    final reservationsSnapshots = await firestore
        .collection('reservations')
        .where('DOCTOR_ID', isEqualTo: auth.currentUser!.uid)
        .get();

    final List<RESERVATION_MODEL> reservationsList = [];

    for (var doc in reservationsSnapshots.docs) {
      final reservation = RESERVATION_MODEL.fromMap(doc.data());
      reservationsList.add(reservation);
    }
    return reservationsList;
  }

  Future<List<RESERVATION_MODEL>> get_all_reservations_for_patient() async {
    final reservationsSnapshots = await firestore
        .collection('reservations')
        .where('PATIENT_ID', isEqualTo: auth.currentUser!.uid)
        .get();

    final List<RESERVATION_MODEL> reservationsList = [];

    for (var doc in reservationsSnapshots.docs) {
      final reservation = RESERVATION_MODEL.fromMap(doc.data());
      reservationsList.add(reservation);
    }
    return reservationsList;
  }

  Future<void> delete_reservation({required RESERVATION_ID}) async {
    await firestore.collection('reservations').doc(RESERVATION_ID).delete();
  }
}
