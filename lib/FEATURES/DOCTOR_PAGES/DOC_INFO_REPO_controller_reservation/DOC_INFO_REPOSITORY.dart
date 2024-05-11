import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_reservation/models/DOCTOR_MODEL.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final get_doctors_list_provider = FutureProvider((ref) {
  final DOC_INFO_REPOSITORY_provider_ref =
      ref.watch(DOC_INFO_REPOSITORY_provider);
  return DOC_INFO_REPOSITORY_provider_ref.GET_DOCTORS_LIST();
});

final DOC_INFO_REPOSITORY_provider = Provider(
  (ref) => DOC_INFO_REPOSITORY(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance),
);

class DOC_INFO_REPOSITORY {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  const DOC_INFO_REPOSITORY({required this.firestore, required this.auth});

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

  Future<DOCTOR_MODEL> get_current_doctor_Data() async {
    var userdata =
        await firestore.collection('doctors').doc(auth.currentUser!.uid).get();
    final user_doctor = DOCTOR_MODEL.fromMap(userdata.data()!);
    return user_doctor;
  }

  Future<void> update_doctor_user_Data(
      {required String field_key, required String f_v}) async {
    await firestore.collection('doctors').doc(auth.currentUser!.uid).update({
      '$field_key': f_v,
    });
  }

  // Future<double> get_average_Rating_of_doctor(
  //     {required String doctor_id}) async {

  // }
}
