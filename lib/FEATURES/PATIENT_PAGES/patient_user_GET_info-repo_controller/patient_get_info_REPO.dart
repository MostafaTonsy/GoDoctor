import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_reservation/models/DOCTOR_MODEL.dart';
import 'package:doctor_reservation/models/PATIENT_MODEL.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Patient_get_info_repos_provider = Provider((ref) =>
    Patient_get_info_repos(
        auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class Patient_get_info_repos {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  const Patient_get_info_repos({required this.auth, required this.firestore});

  Future<PATIENT_MODEL> get_current_patient_Data() async {
    var userdata =
        await firestore.collection('patients').doc(auth.currentUser!.uid).get();
    final userpatient = PATIENT_MODEL.fromMap(userdata.data()!);
    return userpatient;
  }

  Future<List<DOCTOR_MODEL>> GET_DOCTORS_LIST() async {
    List<DOCTOR_MODEL> doctorsList = [];
    final doctorsData = await firestore.collection('doctors').get();
    for (var doc in doctorsData.docs) {
      final doctor = DOCTOR_MODEL.fromMap(doc.data());
      doctorsList.add(doctor);
    }
    return doctorsList;
  }

  Future<List<DOCTOR_MODEL>> GET_TOP_RATED_DOCTORS_LIST() async {
    List<DOCTOR_MODEL> doctorsList = [];
    final doctorsData = await firestore
        .collection('doctors')
        .orderBy('average_rating', descending: true)
        .get();
    for (var doc in doctorsData.docs) {
      final doctor = DOCTOR_MODEL.fromMap(doc.data());
      doctorsList.add(doctor);
    }
    return doctorsList;
  }

  Future<void> update_patient_user_Data(
      {required String field_key, required String Fieldvalue}) async {
    await firestore.collection('patients').doc(auth.currentUser!.uid).update({
      '$field_key': Fieldvalue,
    });
  }
}
