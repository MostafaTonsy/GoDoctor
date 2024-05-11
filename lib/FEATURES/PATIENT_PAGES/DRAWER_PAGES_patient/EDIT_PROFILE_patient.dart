import 'dart:io';

import 'package:doctor_reservation/Custom/colors.dart';
import 'package:doctor_reservation/Custom/custom_text_field.dart';
import 'package:doctor_reservation/Custom/laoding_container.dart';
import 'package:doctor_reservation/Custom/show_snackbar.dart';
import 'package:doctor_reservation/Custom/size_config.dart';
import 'package:doctor_reservation/FEATURES/PATIENT_PAGES/patient_user_GET_info-repo_controller/patient_get_info_controller.dart';
import 'package:doctor_reservation/FIREBASE_STORAGE/FIREBASE_STORAGE.dart';
import 'package:doctor_reservation/models/PATIENT_MODEL.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class edit_profile_patient extends ConsumerStatefulWidget {
  const edit_profile_patient({super.key});

  @override
  ConsumerState<edit_profile_patient> createState() => _edit_profile_patient();
}

class _edit_profile_patient extends ConsumerState<edit_profile_patient> {
  TextEditingController name_controller = TextEditingController();
  TextEditingController phone_number_controller = TextEditingController();

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
            path: 'profile_pic/patients/$uid',
          );
      await ref
          .watch(patient_get_info_controller__provider)
          .update_patient_user_Data(
              field_key: 'PROFILE_PIC_URL', Fieldvalue: photourl);
    }

    setState(() {});
  }

  @override
  void dispose() {
    name_controller.dispose();
    phone_number_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          foregroundColor: Colors.yellow,
          title: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(18)),
            child: Text(
              'Edit Profile',
              style: TextStyle(
                  fontSize: 19,
                  color: const Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
          future: ref
              .watch(patient_get_info_controller__provider)
              .get_current_patient_Data(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final patient = snapshot.data as PATIENT_MODEL;
              return Container(
                padding: EdgeInsets.all(15),
                height: size_config.screen_height! * 0.85,
                width: size_config.screen_width!* 0.95,
                margin: EdgeInsets.only(left: 14, top: 18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 255, 240, 174)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    dragStartBehavior: DragStartBehavior.start,
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
                              patient.NAME,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20,
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
                              patient.PHONE_NUMBER,
                              style:
                                  const TextStyle(color: blue_f, fontSize: 15),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: size_config.screen_width!* 0.68,
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
                                      .watch(
                                          patient_get_info_controller__provider)
                                      .update_patient_user_Data(
                                          field_key: 'NAME',
                                          Fieldvalue: name_controller.text);
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
                                color: Colors.yellow,
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
                              height: 50,
                              width: size_config.screen_width!* 0.68,
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
                                      .watch(
                                          patient_get_info_controller__provider)
                                      .update_patient_user_Data(
                                          field_key: 'PHONE_NUMBER',
                                          Fieldvalue:
                                              phone_number_controller.text);
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
                                color: Colors.yellow,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 100,
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
