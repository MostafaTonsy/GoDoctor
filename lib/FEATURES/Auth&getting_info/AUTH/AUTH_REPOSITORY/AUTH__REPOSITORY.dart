import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_reservation/Custom/show_snackbar.dart';
import 'package:doctor_reservation/FIREBASE_STORAGE/FIREBASE_STORAGE.dart';
import 'package:doctor_reservation/models/DOCTOR_MODEL.dart';
import 'package:doctor_reservation/models/PATIENT_MODEL.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AUTH_REPOSITORY_provider = Provider((ref) => AUTH_REPOSITORY(
      AUTH: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
      ref: ref,
    ));

class AUTH_REPOSITORY {
  final FirebaseAuth AUTH;
  final FirebaseFirestore firestore;
  final ProviderRef ref;

  const AUTH_REPOSITORY(
      {required this.AUTH, required this.firestore, required this.ref});
  Future<void> createUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    var result = await InternetAddress.lookup("google.com");

    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await send_email_verification(context);
      }).catchError((e) {
        ShowSnackbar(ERROR: 'User Already Exists', context: context);
      });
    } else {
      ShowSnackbar(ERROR: 'Internet Connection Error', context: context);
    }
  }

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    var result = await InternetAddress.lookup("google.com");

    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      var user = AUTH.currentUser;
      if (user != null) {
        await AUTH.signOut();
      }
      await AUTH
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {})
          .catchError((e) {
        ShowSnackbar(
            ERROR: 'Email or Password are Incorrect', context: context);
      });
    } else {
      ShowSnackbar(ERROR: 'Internet Connection Error', context: context);
    }
  }

  Future<void> logout({required BuildContext context}) async {
    var result = await InternetAddress.lookup("google.com");

    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await AUTH.signOut();
      } else {
        ShowSnackbar(ERROR: 'You Are Already Logged OUT', context: context);
      }
    } else {
      ShowSnackbar(ERROR: 'Internet Connection Error', context: context);
    }
  }

  Future<void> send_email_verification(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification().then((value) => null).catchError((e) {
        ShowSnackbar(ERROR: 'Error', context: context);
      });
    }
  }

  Future<void> SEND_PASSWORD_RESET(
      {required String RESET_EMAIL, required BuildContext context}) async {
    var result = await InternetAddress.lookup("google.com");

    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
            email: RESET_EMAIL,
          )
          .then((value) => null)
          .catchError((e) {
        ShowSnackbar(ERROR: 'Error', context: context);
      });
    } else {
      ShowSnackbar(ERROR: 'Internet Connection Error', context: context);
    }
  }
/*
  Future<void> login_with_facebook({required BuildContext context}) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await AUTH.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      ShowSnackbar(ERROR: 'Facebook Sign In Error', context: context);
      throw Exception('Facebook Sign In Error');
    }
  }

  Future<void> login_with_google({required BuildContext context}) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await AUTH.signInWithCredential(credential);
    } catch (e) {
      ShowSnackbar(ERROR: 'Google Sign IN Error', context: context);
      throw Exception();
    }
  }*/

  Future<void> save_patient_data_to_firebase({
    required String name,
    required String E_MAIL,
    required String phone_number,
    required File? profile_pic_file,
    required BuildContext context,
  }) async {
    try {
      final uid = AUTH.currentUser!.uid;
      String photourl = '';
      if (profile_pic_file == null) {
        photourl =
            "https://firebasestorage.googleapis.com/v0/b/doctorreservation-ee8c6.appspot.com/o/patient.png?alt=media&token=88fc5136-1794-4df5-8c4c-af7eff23d420";
      } else {
        photourl = await ref
            .watch(Firebase_Storage_Provider)
            .SAVE_PROFILE_PIC_TO_FIREBASE_STORAGE(
                profile_pic: profile_pic_file,
                path: 'profile_pic/patients/$uid');
      }

      final patient = PATIENT_MODEL(
          ID: AUTH.currentUser!.uid,
          NAME: name,
          PROFILE_PIC_URL: photourl,
          PHONE_NUMBER: phone_number);

      await firestore.collection('patients').doc(uid).set(patient.toMap());
    } catch (e) {
      ShowSnackbar(ERROR: e.toString(), context: context);
    }
  }

  Future<bool> check_patient_user() async {
    bool is_patient = false;
    final users_snapshot = await firestore.collection('patients').get();
    for (var doc in users_snapshot.docs) {
      var patient = PATIENT_MODEL.fromMap(doc.data());
      var user = await AUTH.currentUser;
      if (user != null) {
        if (patient.ID == user.uid) {
          is_patient = true;
        }
      }
    }
    return is_patient;
  }

  Future<bool> check_doctor_user() async {
    bool is_doctor = false;
    final users_snapshot = await firestore.collection('doctors').get();
    for (var doc in users_snapshot.docs) {
      var doctor = DOCTOR_MODEL.fromMap(doc.data());
      var user = await AUTH.currentUser;
      if (user != null) {
        if (doctor.ID == user.uid) {
          is_doctor = true;
        }
      }
    }
    return is_doctor;
  }

  Future<void> update_patient_data_to_firebase({
    required String name,
    required String phone_number,
    required File? profile_pic_file,
    required BuildContext context,
    required String E_MAIL,
  }) async {
    try {
      final uid = AUTH.currentUser!.uid;

      var patientdata = await firestore.collection('users').doc(uid).get();
      var patientt = PATIENT_MODEL.fromMap(patientdata.data()!);
      String photourl = '';
      if (profile_pic_file == null) {
        photourl = patientt.PROFILE_PIC_URL;
      } else {
        photourl = await ref
            .watch(Firebase_Storage_Provider)
            .SAVE_PROFILE_PIC_TO_FIREBASE_STORAGE(
                profile_pic: profile_pic_file,
                path: 'profile_pic/patients/$uid');
      }

      final patient = PATIENT_MODEL(
          ID: AUTH.currentUser!.uid,
          NAME: name,
          PROFILE_PIC_URL: photourl,
          PHONE_NUMBER: phone_number);

      await firestore.collection('patients').doc(uid).update(patient.toMap());
    } catch (e) {
      ShowSnackbar(ERROR: e.toString(), context: context);
    }
  }

  Future<void> save_doctor_data_to_firebase({
    required String name,
    required String phone_number,
    required File profile_pic_file,
    required String JOB_TITLE,
    required String OTHER_DETAILS,
    required String CLINIC_ADDRESS,
    required String WORKING_HOURS,
    required String E_MAIL,
    required BuildContext context,
  }) async {
    try {
      final uid = AUTH.currentUser!.uid;
      String photourl = await ref
          .watch(Firebase_Storage_Provider)
          .SAVE_PROFILE_PIC_TO_FIREBASE_STORAGE(
              profile_pic: profile_pic_file, path: 'profile_pic/doctors/$uid');

      final doctor = DOCTOR_MODEL(
          ID: AUTH.currentUser!.uid,
          average_rating: 0,
          NAME: name,
          PHONE_NUMBER: phone_number,
          CLINIC_ADDRESS: CLINIC_ADDRESS,
          JOB_TITLE: JOB_TITLE,
          OTHER_DETAILS: OTHER_DETAILS,
          PROFILE_PIC: photourl,
          WORKING_HOURS: WORKING_HOURS);

      await firestore.collection('doctors').doc(uid).set(doctor.toMap());
    } catch (e) {
      ShowSnackbar(ERROR: e.toString(), context: context);
    }
  }
}
