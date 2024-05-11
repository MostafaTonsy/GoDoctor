import 'package:doctor_reservation/Custom/colors.dart';
import 'package:doctor_reservation/Custom/laoding_container.dart';
import 'package:doctor_reservation/FEATURES/PATIENT_PAGES/DRAWER_PAGES_patient/EDIT_PROFILE_patient.dart';
import 'package:doctor_reservation/FEATURES/PATIENT_PAGES/patient_user_GET_info-repo_controller/patient_get_info_controller.dart';
import 'package:doctor_reservation/models/PATIENT_MODEL.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class PATIENT_PROFILE extends ConsumerStatefulWidget {
  const PATIENT_PROFILE({super.key});

  @override
  ConsumerState<PATIENT_PROFILE> createState() => _PATIENT_PROFILEState();
}

class _PATIENT_PROFILEState extends ConsumerState<PATIENT_PROFILE> {
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
          foregroundColor: Color.fromARGB(255, 217, 255, 0),
          title: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(18)),
            child: Text(
              'Profile',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: ref
              .watch(patient_get_info_controller__provider)
              .get_current_patient_Data(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final patient = snapshot.data as PATIENT_MODEL;

                String patient_image_url = (patient.PROFILE_PIC_URL ==
                        "https://firebasestorage.googleapis.com/v0/b/doctorreservation-ee8c6.appspot.com/o/patient.png?alt=media&token=88fc5136-1794-4df5-8c4c-af7eff23d420")
                    ? "https://firebasestorage.googleapis.com/v0/b/doctorreservation-ee8c6.appspot.com/o/patient.png?alt=media&token=88fc5136-1794-4df5-8c4c-af7eff23d420"
                    : patient.PROFILE_PIC_URL;
                return Container(
                  padding: EdgeInsets.all(15),
                  height: size.height * 0.9,
                  width: size.width * 0.95,
                  margin: EdgeInsets.only(left: 30, top: 18, right: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 241, 240, 139),
                  ),
                  child: SingleChildScrollView(
                    dragStartBehavior: DragStartBehavior.start,
                    scrollDirection: Axis.vertical,
                    child: Container(
                      height: size.height * 0.8,
                      padding: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(patient_image_url),
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
                                patient.NAME,
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
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                patient.PHONE_NUMBER,
                                style: const TextStyle(
                                    color: blue_f, fontSize: 17),
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
                                  Get.to(() => edit_profile_patient(),
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
                return Container();
              }
            } else {
              return Center(child: loading_container());
            }
          },
        ));
  }
}
