import 'dart:io';

import 'package:doctor_reservation/Custom/colors.dart';
import 'package:doctor_reservation/Custom/custom_text_field.dart';
import 'package:doctor_reservation/Custom/laoding_container.dart';
import 'package:doctor_reservation/Custom/show_snackbar.dart';
import 'package:doctor_reservation/FEATURES/Auth&getting_info/AUTH/AUTH_CONTROLLER/AUTH_CONTROLLER.dart';
import 'package:doctor_reservation/FEATURES/DOCTOR_PAGES/doctor_auth_VIEWS/login_view_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class REGISTER_COMPLETE_INFO extends ConsumerStatefulWidget {
  const REGISTER_COMPLETE_INFO({super.key});

  @override
  ConsumerState<REGISTER_COMPLETE_INFO> createState() => _DOCTOR_PAGE();
}

class _DOCTOR_PAGE extends ConsumerState<REGISTER_COMPLETE_INFO> {
  TextEditingController EMAIL_CONTROLLER = TextEditingController();
  TextEditingController PASSWORD_CONTROLLER = TextEditingController();
  TextEditingController NAMECONTROLLER = TextEditingController();
  TextEditingController PHONEController = TextEditingController();
  TextEditingController JOB_TITLE_controller = TextEditingController();
  TextEditingController OTHER_DETAILS_controller = TextEditingController();
  TextEditingController CLINIC_ADDRESS_controller = TextEditingController();
  TextEditingController WORKING_HOURS_controller = TextEditingController();
  bool isloading = false;
  File? image;

  void SELECT_IMAGE(BuildContext context) async {
    final imagepath =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    image = File(imagepath!.path);
    setState(() {});
  }

  void register_SAVE_USER_DATA(BuildContext context) async {
    String EMAIL = EMAIL_CONTROLLER.text;
    String PASSWORD = PASSWORD_CONTROLLER.text.trim();
    String name = NAMECONTROLLER.text;
    String phoneNumber = PHONEController.text.trim();
    String jobTitle = JOB_TITLE_controller.text;
    String otherDetails = OTHER_DETAILS_controller.text;
    String clinicAddress = CLINIC_ADDRESS_controller.text;
    String workingHours = WORKING_HOURS_controller.text;

    if (EMAIL_CONTROLLER.text.isNotEmpty &&
        PASSWORD_CONTROLLER.text.isNotEmpty &&
        name.isNotEmpty &&
        PHONEController.text.isNotEmpty &&
        jobTitle.isNotEmpty &&
        otherDetails.isNotEmpty &&
        clinicAddress.isNotEmpty &&
        workingHours.isNotEmpty &&
        image != null) {
      setState(() {
        isloading = true;
      });
      await ref.watch(AUTH_CONTROLLER_provider).createUser(
          email: EMAIL_CONTROLLER.text.trim(),
          password: PASSWORD_CONTROLLER.text,
          context: context);

      ShowSnackbar(
          ERROR:
              'We\'ve sent an email verificaiton message to your email ,Please Check it to verify your email',
          context: context);
      var user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await ref.watch(AUTH_CONTROLLER_provider).save_doctor_data_to_firebase(
              E_MAIL: EMAIL,
              context: context,
              name: name,
              phone_number: phoneNumber,
              profile_pic_file: image!,
              CLINIC_ADDRESS: clinicAddress,
              JOB_TITLE: jobTitle,
              OTHER_DETAILS: otherDetails,
              WORKING_HOURS: workingHours,
            );

        Get.to(() => login_view_page(), transition: Transition.leftToRight);
      }
    } else {
      ShowSnackbar(
          ERROR: 'Please Complete All Fields and Add photo if not added',
          context: context);
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  void dispose() {
    EMAIL_CONTROLLER.dispose();
    PASSWORD_CONTROLLER.dispose();
    NAMECONTROLLER.dispose;
    PHONEController.dispose();
    JOB_TITLE_controller.dispose();
    OTHER_DETAILS_controller.dispose();
    CLINIC_ADDRESS_controller.dispose();
    WORKING_HOURS_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
        title: const Text(
          'Register',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: isloading
          ? loading_container()
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      (image == null)
                          ? CircleAvatar(
                              backgroundImage: AssetImage('assets/DOCTOR.jpg'),
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
                        height: 25,
                      ),
                      SizedBox(
                        height: size.height * 0.07,
                        child: custom_text_field(
                          onchanged: null,
                          Label: 'Enter Your E-Mail',
                          maxlines: 1,
                          obscure_text: false,
                          EditingController: EMAIL_CONTROLLER,
                          textInputType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: size.height * 0.07,
                        child: custom_text_field(
                          onchanged: null,
                          Label: 'Enter Your Password',
                          maxlines: 1,
                          obscure_text: true,
                          EditingController: PASSWORD_CONTROLLER,
                          textInputType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: size.height * 0.07,
                        child: custom_text_field(
                          onchanged: null,
                          EditingController: NAMECONTROLLER,
                          Label: 'Enter Your Name',
                          maxlines: 1,
                          obscure_text: false,
                          textInputType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: size.height * 0.07,
                        child: custom_text_field(
                            maxlines: 1,
                            obscure_text: false,
                            textInputType: TextInputType.number,
                            onchanged: null,
                            EditingController: PHONEController,
                            Label: 'Enter Phone Number With Country Code'),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      custom_text_field(
                          onchanged: null,
                          maxlines: 1,
                          obscure_text: false,
                          textInputType: TextInputType.text,
                          EditingController: JOB_TITLE_controller,
                          Label: 'Enter Your Job Title'),
                      const SizedBox(
                        height: 16,
                      ),
                      custom_text_field(
                          onchanged: null,
                          maxlines: 3,
                          textInputType: TextInputType.multiline,
                          obscure_text: false,
                          EditingController: OTHER_DETAILS_controller,
                          Label: 'Enter Your Job In Details '),
                      const SizedBox(
                        height: 16,
                      ),
                      custom_text_field(
                          onchanged: null,
                          EditingController: CLINIC_ADDRESS_controller,
                          maxlines: 3,
                          obscure_text: false,
                          textInputType: TextInputType.multiline,
                          Label: 'Enter Your Clinic Address'),
                      const SizedBox(
                        height: 16,
                      ),
                      custom_text_field(
                          onchanged: null,
                          maxlines: 3,
                          obscure_text: false,
                          textInputType: TextInputType.multiline,
                          EditingController: WORKING_HOURS_controller,
                          Label: 'Enter Your Working Hours Weekly'),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            register_SAVE_USER_DATA(context);
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color.fromARGB(255, 2, 0, 129)),
                          child: Text('REGISTER')),
                      const SizedBox(
                        height: 16,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => login_view_page(),
                              transition: Transition.rightToLeft);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 54, 0, 61)),
                        child: const Text(
                          'Already registered? Login Here!',
                          style: TextStyle(color: Colors.yellow),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
