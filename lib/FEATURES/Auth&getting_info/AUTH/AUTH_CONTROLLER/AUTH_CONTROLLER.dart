import 'dart:io';

import 'package:doctor_reservation/FEATURES/Auth&getting_info/AUTH/AUTH_REPOSITORY/AUTH__REPOSITORY.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AUTH_CONTROLLER_provider = Provider((ref) {
  final authRepositoryProviderRef = ref.watch(AUTH_REPOSITORY_provider);

  return AUTH_CONTROLLER(
    auth_repository: authRepositoryProviderRef,
  );
});

class AUTH_CONTROLLER {
  final AUTH_REPOSITORY auth_repository;

  const AUTH_CONTROLLER({
    required this.auth_repository,
  });

  createUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    return await auth_repository.createUser(
        email: email, password: password, context: context);
  }

  login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    return await auth_repository.login(
        email: email, password: password, context: context);
  }

  Future<void> logout({required BuildContext context}) async {
    await auth_repository.logout(context: context);
  }

  Future<void> send_email_verification({required BuildContext context}) async {
    await auth_repository.send_email_verification(context);
  }

  Future<void> SEND_PASSWORD_RESET(
      {required String RESET_EMAIL, required BuildContext context}) async {
    await auth_repository.SEND_PASSWORD_RESET(
        RESET_EMAIL: RESET_EMAIL, context: context);
  }
/*
  Future<void> login_with_facebook({required BuildContext context}) async {
    await auth_repository.login_with_facebook(context: context);
  }

  Future<void> login_with_google({required BuildContext context}) async {
    await auth_repository.login_with_google(context: context);
  }*/

  Future<void> save_patient_data_to_firebase({
    required String name,
    required String phone_number,
    required String E_MAIL,
    required File? profile_pic_file,
    required BuildContext context,
  }) async {
    await auth_repository.save_patient_data_to_firebase(
        E_MAIL: E_MAIL,
        name: name,
        phone_number: phone_number,
        profile_pic_file: profile_pic_file,
        context: context);
  }

  Future<void> update_patient_data_to_firebase({
    required String name,
    required String phone_number,
    required String E_MAIL,
    required File? profile_pic_file,
    required BuildContext context,
  }) async {
    await auth_repository.update_patient_data_to_firebase(
        E_MAIL: E_MAIL,
        name: name,
        phone_number: phone_number,
        profile_pic_file: profile_pic_file,
        context: context);
  }

  Future<bool> check_patient_user() async {
    return await auth_repository.check_patient_user();
  }

  Future<bool> check_doctor_user() async {
    return await auth_repository.check_doctor_user();
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
    await auth_repository.save_doctor_data_to_firebase(
        E_MAIL: E_MAIL,
        name: name,
        phone_number: phone_number,
        profile_pic_file: profile_pic_file,
        JOB_TITLE: JOB_TITLE,
        OTHER_DETAILS: OTHER_DETAILS,
        CLINIC_ADDRESS: CLINIC_ADDRESS,
        WORKING_HOURS: WORKING_HOURS,
        context: context);
  }
}
