import "package:doctor_reservation/Custom/colors.dart";
import "package:doctor_reservation/Custom/custom_text_field.dart";
import "package:doctor_reservation/Custom/laoding_container.dart";
import "package:doctor_reservation/Custom/show_snackbar.dart";
import "package:doctor_reservation/FEATURES/Auth&getting_info/AUTH/AUTH_CONTROLLER/AUTH_CONTROLLER.dart";
import "package:doctor_reservation/FEATURES/PATIENT_PAGES/pateint_main_page.dart";
import "package:doctor_reservation/FEATURES/PATIENT_PAGES/patients_auth_VIEWS/FORGOT_PASSWORD_VIEW.dart";
import "package:doctor_reservation/FEATURES/PATIENT_PAGES/patients_auth_VIEWS/register_view_page.dart";
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:get/get.dart";

class patient_login_view_page extends ConsumerStatefulWidget {
  const patient_login_view_page({super.key});

  @override
  ConsumerState<patient_login_view_page> createState() =>
      _login_view_page_state();
}

class _login_view_page_state extends ConsumerState<patient_login_view_page> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  bool isloading = false;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: isloading
          ? loading_container()
          : Stack(
              children: [
                Opacity(
                  opacity: 0.2,
                  child: Container(
                      height: size.height,
                      child: Image.asset('assets/DOCTOR.jpg')),
                ),
                Form(
                  canPop: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: size.height * 0.07,
                          child: custom_text_field(
                            onchanged: null,
                            Label: 'Enter Your E-Mail',
                            maxlines: 1,
                            obscure_text: false,
                            EditingController: _email,
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
                            EditingController: _password,
                            textInputType: TextInputType.text,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextButton(
                            onPressed: () async {
                              setState(() {
                                isloading = true;
                              });
                              final email = _email.text;
                              final password = _password.text;
                              await ref.watch(AUTH_CONTROLLER_provider).login(
                                  email: email,
                                  password: password,
                                  context: context);

                              bool is_patient = await ref
                                  .watch(AUTH_CONTROLLER_provider)
                                  .check_patient_user();

                              var user = FirebaseAuth.instance.currentUser;
                              if (user != null &&
                                  user.emailVerified &&
                                  is_patient == true) {
                                // setState(() {
                                //   isloading = false;
                                // });
                                Get.to(() => PATIENT_main_page());
                              } else if (user != null && !user.emailVerified) {
                                await user.sendEmailVerification();

                                ShowSnackbar(
                                    ERROR:
                                        'User not verified we sent an email verification to verify your accont',
                                    context: context);

                                setState(() {
                                  isloading = false;
                                });
                              } else if (user != null &&
                                  user.emailVerified &&
                                  is_patient == false) {
                                ShowSnackbar(
                                    ERROR:
                                        'You Only Have A Doctor Account , You can\'t login unless you register a patient account',
                                    context: context);
                                setState(() {
                                  isloading = false;
                                });
                              } else {
                                setState(() {
                                  isloading = false;
                                });
                              }
                            },
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black),
                            child: const Text('LOGIN')),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => patient_register_complete_info(),
                                transition: Transition.downToUp);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 60, 0, 97)),
                          child: const Text(
                            'NOT registered? REGISTER Here!',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const patient_FORGOT_PASSWROD_VIEW(),
                            ));
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.yellow),
                          child: const Text(
                            'FORGOT PASSWORD? PRESS HERE',
                            style: TextStyle(color: blue),
                          ),
                        ),
                        /*      Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextButton(
                      onPressed: () async {
                        ref
                            .watch(AUTH_CONTROLLER_provider)
                            .login_with_facebook(context: context);
          
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PATIENT_main_page(),
                        ));
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: blue,
                          maximumSize: const Size(double.infinity, 50)),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.facebook,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Facebook'),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextButton(
                      onPressed: () async {
                        ref
                            .watch(AUTH_CONTROLLER_provider)
                            .login_with_google(context: context);
          
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PATIENT_main_page(),
                        ));
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: blue,
                          maximumSize: const Size(double.infinity, 50)),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.g_mobiledata_rounded,
                            color: Colors.white,
                          ),
                          Text('Google'),
                        ],
                      )),
                )*/
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
