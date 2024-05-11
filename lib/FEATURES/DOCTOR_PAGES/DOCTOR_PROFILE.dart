import 'package:doctor_reservation/Custom/colors.dart';
import 'package:doctor_reservation/Custom/laoding_container.dart';
import 'package:doctor_reservation/FEATURES/DOCTOR_PAGES/DOC_INFO_REPO_controller_reservation/Doc_info__controller.dart';
import 'package:doctor_reservation/FEATURES/DOCTOR_PAGES/DRAWER_PAGES_doctor/EDIT_PROFILE_doctor.dart';
import 'package:doctor_reservation/models/DOCTOR_MODEL.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class DOCTOR_PROFILE extends ConsumerStatefulWidget {
  const DOCTOR_PROFILE({super.key});

  @override
  ConsumerState<DOCTOR_PROFILE> createState() => _PATIENT_PROFILEState();
}

class _PATIENT_PROFILEState extends ConsumerState<DOCTOR_PROFILE> {
  TextEditingController name_controller = TextEditingController();
  TextEditingController phone_number_controller = TextEditingController();
  @override
  Widget build(
    BuildContext context,
  ) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          foregroundColor: Colors.yellow,
          title: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(18)),
            child: Text(
              'Profile',
              style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20),
            ),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future:
              ref.watch(Doc_info_controller_PROVIDER).get_current_doctor_Data(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final DOCTTOR = snapshot.data as DOCTOR_MODEL;
                return Container(
                  padding: EdgeInsets.all(15),
                  width: size.width * 0.95,
                  height: size.height * 0.95,
                  margin: EdgeInsets.only(left: 30, top: 18, right: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 246, 163),
                  ),
                  child: Container(
                    height: size.height * 0.85,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.white,
                    child: SingleChildScrollView(
                      dragStartBehavior: DragStartBehavior.start,
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  NetworkImage(DOCTTOR.PROFILE_PIC),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.yellow,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                DOCTTOR.NAME,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.topic_outlined,
                                color: Colors.yellow,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                DOCTTOR.JOB_TITLE,
                                style: const TextStyle(
                                    color: blue_f, fontSize: 13),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.yellow,
                              ),
                              Text(
                                DOCTTOR.PHONE_NUMBER,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 13),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.topic_outlined,
                                color: Colors.yellow,
                              ),
                              Text(
                                DOCTTOR.OTHER_DETAILS,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 13),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_city_outlined,
                                color: Colors.yellow,
                              ),
                              Text(
                                DOCTTOR.CLINIC_ADDRESS,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 13),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.timelapse,
                                color: Colors.yellow,
                              ),
                              Text(
                                DOCTTOR.WORKING_HOURS,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 13),
                              ),
                            ],
                          ),
                          Center(
                            child: SizedBox(
                              height: size.height * 0.35,
                              child: Image.asset('assets/OIP.jfif'),
                            ),
                          ),
                          Center(
                            child: TextButton(
                                onPressed: () {
                                  Get.to(() => edit_profile_doc(),
                                      transition: Transition.downToUp);
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue),
                                child: Text(
                                  'Edit Profile',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return loading_container();
              }
            } else {
              return Center(child: loading_container());
            }
          },
        ));
  }
}
