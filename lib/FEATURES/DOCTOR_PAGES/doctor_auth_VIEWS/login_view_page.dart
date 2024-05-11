import "package:doctor_reservation/Custom/colors.dart";
import "package:doctor_reservation/Custom/custom_text_field.dart";
import "package:doctor_reservation/Custom/laoding_container.dart";
import "package:doctor_reservation/Custom/show_snackbar.dart";
import "package:doctor_reservation/FEATURES/Auth&getting_info/AUTH/AUTH_CONTROLLER/AUTH_CONTROLLER.dart";
import "package:doctor_reservation/FEATURES/DOCTOR_PAGES/DOCTORS_main_page.dart";
import "package:doctor_reservation/FEATURES/DOCTOR_PAGES/doctor_auth_VIEWS/FORGOT_PASSWORD_VIEW.dart";
import "package:doctor_reservation/FEATURES/DOCTOR_PAGES/doctor_auth_VIEWS/register_complete_info.dart";
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:get/get.dart";

class login_view_page extends ConsumerStatefulWidget {
  const login_view_page({super.key});

  @override
  ConsumerState<login_view_page> createState() => _login_view_page_state();
}

class _login_view_page_state extends ConsumerState<login_view_page> {
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: isloading
          ? loading_container()
          : Form(
              canPop: false,
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.2,
                    child: Container(
                        height: size.height,
                        child: Image.asset('assets/DOCTOR.jpg')),
                  ),
                  Center(
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
                              final email = _email.text;
                              final password = _password.text;

                              setState(() {
                                isloading = true;
                              });
                              await ref.watch(AUTH_CONTROLLER_provider).login(
                                  email: email,
                                  password: password,
                                  context: context);

                              bool is_doctor = await ref
                                  .watch(AUTH_CONTROLLER_provider)
                                  .check_doctor_user();

                              var user = FirebaseAuth.instance.currentUser;
                              if (user != null && user.emailVerified) {
                                Get.to(() => DOCTORS_main_page());
                              } else if (user != null && !user.emailVerified) {
                                await user.sendEmailVerification();
                                ShowSnackbar(
                                    ERROR:
                                        'user not verified we sent an email verification to verify your accont',
                                    context: context);

                                setState(() {
                                  isloading = false;
                                });
                              } else if (user != null &&
                                  user.emailVerified &&
                                  is_doctor == false) {
                                ShowSnackbar(
                                    ERROR:
                                        'You Only Have A Patient Account , You can\'t login unless you register a doctor account',
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
                                backgroundColor:
                                    const Color.fromARGB(255, 61, 0, 72)),
                            child: const Text('Login')),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => REGISTER_COMPLETE_INFO(),
                                transition: Transition.downToUp);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 0, 0, 0)),
                          child: const Text(
                            'Not registered? Register Here!',
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
                                  const FORGOT_PASSWROD_VIEW(),
                            ));
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.yellow),
                          child: const Text(
                            'Forgot Password? Press Here',
                            style: TextStyle(color: blue),
                          ),
                        ),
                        /*    Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextButton(
                      onPressed: () async {
                        ref
                            .watch(AUTH_CONTROLLER_provider)
                            .login_with_facebook(context: context);
                    
                        Get.to(() => DOCTORS_main_page(),
                            transition: Transition.downToUp);
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
                          builder: (context) => const DOCTORS_main_page(),
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
                ],
              ),
            ),
    );
  }
}
