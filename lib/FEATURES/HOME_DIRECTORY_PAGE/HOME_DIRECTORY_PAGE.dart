import 'package:doctor_reservation/FEATURES/DOCTOR_PAGES/doctor_auth_VIEWS/login_view_page.dart';
import 'package:doctor_reservation/FEATURES/PATIENT_PAGES/patients_auth_VIEWS/login_view_page.dart';
import 'package:flutter/material.dart';

class HOME_DIRECTORY_PAGE extends StatefulWidget {
  const HOME_DIRECTORY_PAGE({super.key});

  @override
  State<HOME_DIRECTORY_PAGE> createState() => _HOME_DIRECTORY_PAGEState();
}

class _HOME_DIRECTORY_PAGEState extends State<HOME_DIRECTORY_PAGE> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Form(
        canPop: false,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 253, 253, 253),
              borderRadius: BorderRadius.circular(25),
            ),
            height: size.height * 0.42,
            width: size.width * 0.92,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Choose Your User Account',
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                            radius: 60,
                            
                            backgroundImage: AssetImage('assets/DOCTOR.jpg')),
                        const SizedBox(
                          height: 30,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const login_view_page(),
                              ));
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: const Text('Doctor\'s Page',
                                style: TextStyle(
                                  color: Colors.yellow,
                                ))),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage('assets/patient.png')),
                        const SizedBox(
                          height: 30,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const patient_login_view_page(),
                              ));
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: const Text('Patient\'s Page',
                                style: TextStyle(
                                  color: Colors.yellow,
                                ))),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
