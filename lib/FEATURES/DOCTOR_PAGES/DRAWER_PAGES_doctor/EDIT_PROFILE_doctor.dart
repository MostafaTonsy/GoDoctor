import 'dart:io';

import 'package:doctor_reservation/Custom/colors.dart';
import 'package:doctor_reservation/Custom/custom_text_field.dart';
import 'package:doctor_reservation/Custom/laoding_container.dart';
import 'package:doctor_reservation/Custom/show_snackbar.dart';
import 'package:doctor_reservation/Custom/size_config.dart';
import 'package:doctor_reservation/FEATURES/DOCTOR_PAGES/DOC_INFO_REPO_controller_reservation/Doc_info__controller.dart';
import 'package:doctor_reservation/FIREBASE_STORAGE/FIREBASE_STORAGE.dart';
import 'package:doctor_reservation/models/DOCTOR_MODEL.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class edit_profile_doc extends ConsumerStatefulWidget {
  const edit_profile_doc({super.key});

  @override
  ConsumerState<edit_profile_doc> createState() => _edit_profile_patient();
}

class _edit_profile_patient extends ConsumerState<edit_profile_doc> {
  TextEditingController name_controller = TextEditingController();
  TextEditingController phone_number_controller = TextEditingController();

  TextEditingController JOB_TITLE_controller = TextEditingController();
  TextEditingController OTHER_DETAILS_controller = TextEditingController();
  TextEditingController CLINIC_ADDRESS_controller = TextEditingController();
  TextEditingController WORKING_HOURS_controller = TextEditingController();

  File? image;

  void SELECT_IMAGE(BuildContext context) async {
    final imagepath =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagepath != null) {
      image = File(imagepath.path);
      final uid = FirebaseAuth.instance.currentUser!.uid;
      String photourl = await ref
          .watch(Firebase_Storage_Provider)
          .SAVE_PROFILE_PIC_TO_FIREBASE_STORAGE(
            profile_pic: image!,
            path: 'profile_pic/doctors/$uid',
          );
      await ref
          .watch(Doc_info_controller_PROVIDER)
          .update_doctor_user_Data(field_key: 'PROFILE_PIC', f_v: photourl);
    }

    setState(() {});
  }

  @override
  void dispose() {
    name_controller.dispose();
    phone_number_controller.dispose();
    JOB_TITLE_controller.dispose();
    OTHER_DETAILS_controller.dispose();
    CLINIC_ADDRESS_controller.dispose();
    WORKING_HOURS_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          foregroundColor: Colors.yellow,
          title: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(18)),
            child: const Text(
              'Edit Profile',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
            ),
          ),
        ),
        body: FutureBuilder(
          future:
              ref.watch(Doc_info_controller_PROVIDER).get_current_doctor_Data(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final doctor = snapshot.data as DOCTOR_MODEL;
              return Container(
                padding: EdgeInsets.all(15),
                height: size_config.screen_height! * 0.85,
                width: size_config.screen_width! * 0.95,
                margin: EdgeInsets.only(left: 14, top: 18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 238, 250, 160)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.yellow,
                            ),
                            Text(
                              doctor.NAME,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 21,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.yellow,
                            ),
                            Text(
                              doctor.PHONE_NUMBER,
                              style:
                                  const TextStyle(color: blue_f, fontSize: 17),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 40,
                              width: size_config.screen_width! * 0.68,
                              child: custom_text_field(
                                Label: 'Edit your Name ',
                                maxlines: 1,
                                obscure_text: false,
                                onchanged: null,
                                EditingController: name_controller,
                                textInputType: TextInputType.text,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                if (name_controller.text.isNotEmpty) {
                                  ref
                                      .watch(Doc_info_controller_PROVIDER)
                                      .update_doctor_user_Data(
                                          field_key: 'NAME',
                                          f_v: name_controller.text);
                                  setState(() {});
                                } else {
                                  ShowSnackbar(
                                      ERROR:
                                          'Field is empty.. Please add a text',
                                      context: context);
                                }
                              },
                              child: Icon(
                                Icons.save,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: size_config.screen_width! * 0.68,
                              height: 40,
                              child: custom_text_field(
                                Label: 'Edit your Phone Number',
                                maxlines: 1,
                                obscure_text: false,
                                onchanged: null,
                                EditingController: phone_number_controller,
                                textInputType: TextInputType.number,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                if (phone_number_controller.text.isNotEmpty) {
                                  ref
                                      .watch(Doc_info_controller_PROVIDER)
                                      .update_doctor_user_Data(
                                          field_key: 'PHONE_NUMBER',
                                          f_v: phone_number_controller.text);
                                  setState(() {});
                                } else {
                                  ShowSnackbar(
                                      ERROR:
                                          'Field is empty.. Please add a text',
                                      context: context);
                                }
                              },
                              child: Icon(
                                Icons.save,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: size_config.screen_width! * 0.68,
                              height: 40,
                              child: custom_text_field(
                                Label: 'Edit your Job Title',
                                maxlines: 1,
                                obscure_text: false,
                                onchanged: null,
                                EditingController: JOB_TITLE_controller,
                                textInputType: TextInputType.text,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                if (JOB_TITLE_controller.text.isNotEmpty) {
                                  ref
                                      .watch(Doc_info_controller_PROVIDER)
                                      .update_doctor_user_Data(
                                          field_key: 'JOB_TITLE',
                                          f_v: JOB_TITLE_controller.text);
                                  setState(() {});
                                } else {
                                  ShowSnackbar(
                                      ERROR:
                                          'Field is empty.. Please add a text',
                                      context: context);
                                }
                              },
                              child: Icon(
                                Icons.save,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: size_config.screen_width! * 0.68,
                              height: 40,
                              child: custom_text_field(
                                Label: 'Edit your Other Details',
                                maxlines: 1,
                                obscure_text: false,
                                onchanged: null,
                                EditingController: OTHER_DETAILS_controller,
                                textInputType: TextInputType.text,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                if (OTHER_DETAILS_controller.text.isNotEmpty) {
                                  ref
                                      .watch(Doc_info_controller_PROVIDER)
                                      .update_doctor_user_Data(
                                          field_key: 'OTHER_DETAILS',
                                          f_v: OTHER_DETAILS_controller.text);
                                  setState(() {});
                                } else {
                                  ShowSnackbar(
                                      ERROR:
                                          'Field is empty.. Please add a text',
                                      context: context);
                                }
                              },
                              child: Icon(
                                Icons.save,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: size_config.screen_width! * 0.68,
                              height: 40,
                              child: custom_text_field(
                                Label: 'Edit your Clinic Address',
                                maxlines: 1,
                                obscure_text: false,
                                onchanged: null,
                                EditingController: CLINIC_ADDRESS_controller,
                                textInputType: TextInputType.text,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                if (CLINIC_ADDRESS_controller.text.isNotEmpty) {
                                  ref
                                      .watch(Doc_info_controller_PROVIDER)
                                      .update_doctor_user_Data(
                                          field_key: 'CLINIC_ADDRESS',
                                          f_v: CLINIC_ADDRESS_controller.text);
                                  setState(() {});
                                } else {
                                  ShowSnackbar(
                                      ERROR:
                                          'Field is empty.. Please add a text',
                                      context: context);
                                }
                              },
                              child: Icon(
                                Icons.save,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: size_config.screen_width! * 0.68,
                              height: 40,
                              child: custom_text_field(
                                Label: 'Edit your Working Hours',
                                maxlines: 1,
                                obscure_text: false,
                                onchanged: null,
                                EditingController: WORKING_HOURS_controller,
                                textInputType: TextInputType.text,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                if (WORKING_HOURS_controller.text.isNotEmpty) {
                                  ref
                                      .watch(Doc_info_controller_PROVIDER)
                                      .update_doctor_user_Data(
                                          field_key: 'WORKING_HOURS',
                                          f_v: WORKING_HOURS_controller.text);
                                  setState(() {});
                                } else {
                                  ShowSnackbar(
                                      ERROR:
                                          'Field is empty.. Please add a text',
                                      context: context);
                                }
                              },
                              child: Icon(
                                Icons.save,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: Image.asset(
                              'assets/project-management-software-1.png'),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: loading_container());
            }
          },
        ));
  }
}
