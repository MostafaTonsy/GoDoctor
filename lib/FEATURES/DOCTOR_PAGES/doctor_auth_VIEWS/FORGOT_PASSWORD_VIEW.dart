import 'package:doctor_reservation/Custom/custom_text_field.dart';
import 'package:doctor_reservation/FEATURES/Auth&getting_info/AUTH/AUTH_CONTROLLER/AUTH_CONTROLLER.dart';
import 'package:doctor_reservation/FEATURES/DOCTOR_PAGES/doctor_auth_VIEWS/login_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FORGOT_PASSWROD_VIEW extends ConsumerStatefulWidget {
  const FORGOT_PASSWROD_VIEW({super.key});

  @override
  ConsumerState<FORGOT_PASSWROD_VIEW> createState() =>
      _FORGOT_PASSWROD_VIEWState();
}

class _FORGOT_PASSWROD_VIEWState extends ConsumerState<FORGOT_PASSWROD_VIEW> {
  late TextEditingController _text_Controller;

  @override
  void initState() {
    _text_Controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _text_Controller.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
        title: const Text(
          'Forgot Password Page',
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(15)),
              child: const Text(
                'If You Forgot Your Password Write Your EMAIL And We Will Send A password Reset Email To You ',
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: size.height * 0.075,
              child: custom_text_field(
                  onchanged: null,
                  EditingController: _text_Controller,
                  Label: 'Enter Your E-mail Here',
                  maxlines: 1,
                  textInputType: TextInputType.emailAddress,
                  obscure_text: false),
            ),
            SizedBox(
              height: 25,
            ),
            TextButton(
                onPressed: () {
                  final EMAIL = _text_Controller.text;
                  ref.watch(AUTH_CONTROLLER_provider).SEND_PASSWORD_RESET(
                      RESET_EMAIL: EMAIL, context: context);
                },
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue),
                child: const Text('Send New Password')),
            const SizedBox(
              height: 15,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const login_view_page(),
                  ));
                },
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black),
                child: const Text('Back To Login Page')),
          ],
        ),
      ),
    );
  }
}
