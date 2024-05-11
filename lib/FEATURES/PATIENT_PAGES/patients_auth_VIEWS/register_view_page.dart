import "dart:io";

import "package:doctor_reservation/Custom/colors.dart";
import "package:doctor_reservation/Custom/custom_text_field.dart";
import "package:doctor_reservation/Custom/laoding_container.dart";
import "package:doctor_reservation/Custom/show_snackbar.dart";
import "package:doctor_reservation/FEATURES/Auth&getting_info/AUTH/AUTH_CONTROLLER/AUTH_CONTROLLER.dart";
import "package:doctor_reservation/FEATURES/PATIENT_PAGES/patients_auth_VIEWS/login_view_page.dart";
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:get/get.dart";
import "package:image_picker/image_picker.dart";

class patient_register_complete_info extends ConsumerStatefulWidget {
  const patient_register_complete_info({super.key});

  @override
  ConsumerState<patient_register_complete_info> createState() =>
      _patient_register_complete_info_page();
}

class _patient_register_complete_info_page
    extends ConsumerState<patient_register_complete_info> {
  late final TextEditingController email_controler = TextEditingController();
  late final TextEditingController password_controller =
      TextEditingController();
  late final TextEditingController name_controller = TextEditingController();
  late final TextEditingController phone_number_controller =
      TextEditingController();

  File? image;

  bool isloading = false;

  void SELECT_IMAGE(BuildContext context) async {
    final imagepath =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagepath != null) {
      image = File(imagepath.path);
    }

    setState(() {});
  }

  void register_SAVE_USER_DATA(BuildContext context) async {
    String EMAIL = email_controler.text;
    String PASSWORD = password_controller.text.trim();
    String name = name_controller.text;
    String phoneNumber = phone_number_controller.text.trim();

    if (EMAIL.isNotEmpty &&
        PASSWORD.isNotEmpty &&
        name.isNotEmpty &&
        phoneNumber.isNotEmpty) {
      isloading = true;
      setState(() {});

      await ref.watch(AUTH_CONTROLLER_provider).createUser(
          email: EMAIL.trim(), password: PASSWORD, context: context);

      ShowSnackbar(
          ERROR:
              'We\'ve sent an email verificaiton message to your email ,Please Check it to verify your email',
          context: context);
      var user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await ref.watch(AUTH_CONTROLLER_provider).save_patient_data_to_firebase(
              context: context,
              E_MAIL: email_controler.text,
              name: name,
              phone_number: phoneNumber,
              profile_pic_file: image,
            );

        isloading = false;
        setState(() {});

        Get.to(() => patient_login_view_page(),
            transition: Transition.leftToRight);
      }
    } else {
      ShowSnackbar(ERROR: 'Please Complete All Fields', context: context);
      isloading = false;
      setState(() {});
    }
  }

  @override
  void dispose() {
    email_controler.dispose();
    password_controller.dispose();
    name_controller.dispose();
    phone_number_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
        title: const Text(
          'Register',
        ),
      ),
      body: isloading
          ? loading_container()
          : Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  (image == null)
                      ? CircleAvatar(
                          backgroundImage: AssetImage('assets/patient.png'),
                          radius: 60,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: IconButton(
                              onPressed: () {
                                SELECT_IMAGE(context);
                              },
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: black,
                              ),
                            ),
                          ))
                      : CircleAvatar(
                          backgroundImage: FileImage(image!),
                          radius: 60,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: IconButton(
                              onPressed: () {
                                SELECT_IMAGE(context);
                              },
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Colors.yellow,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                    child: custom_text_field(
                      onchanged: null,
                      Label: 'Enter Your E-Mail',
                      maxlines: 1,
                      obscure_text: false,
                      EditingController: email_controler,
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                    child: custom_text_field(
                      onchanged: null,
                      Label: 'Enter Your Password',
                      maxlines: 1,
                      obscure_text: true,
                      EditingController: password_controller,
                      textInputType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                    child: custom_text_field(
                      onchanged: null,
                      Label: 'Enter Your Name',
                      maxlines: 1,
                      obscure_text: false,
                      EditingController: name_controller,
                      textInputType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                    child: custom_text_field(
                      onchanged: null,
                      Label: 'Enter Your Phone Number',
                      maxlines: 1,
                      obscure_text: false,
                      EditingController: phone_number_controller,
                      textInputType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () async {
                        register_SAVE_USER_DATA(context);
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 8, 0, 122)),
                      child: const Text('REGISTER')),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => patient_login_view_page(),
                          transition: Transition.downToUp);
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 53, 0, 66)),
                    child: const Text(
                      'Already registered? Login Here!',
                      style: TextStyle(color: Colors.yellow),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
