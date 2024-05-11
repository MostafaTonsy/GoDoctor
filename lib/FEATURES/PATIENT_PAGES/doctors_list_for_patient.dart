import 'package:doctor_reservation/Custom/colors.dart';
import 'package:doctor_reservation/Custom/laoding_container.dart';
import 'package:doctor_reservation/FEATURES/Auth&getting_info/AUTH/AUTH_CONTROLLER/AUTH_CONTROLLER.dart';
import 'package:doctor_reservation/FEATURES/HOME_DIRECTORY_PAGE/HOME_DIRECTORY_PAGE.dart';
import 'package:doctor_reservation/FEATURES/PATIENT_PAGES/DOCTOR_DETAILS_PAGE_for_patient.dart';
import 'package:doctor_reservation/FEATURES/PATIENT_PAGES/DRAWER_PAGES_patient/ABOUT_US_patient.dart';
import 'package:doctor_reservation/FEATURES/PATIENT_PAGES/DRAWER_PAGES_patient/EDIT_PROFILE_patient.dart';
import 'package:doctor_reservation/FEATURES/PATIENT_PAGES/TOP_RATED_DOCTORS.dart';
import 'package:doctor_reservation/FEATURES/PATIENT_PAGES/patient_user_GET_info-repo_controller/patient_get_info_controller.dart';
import 'package:doctor_reservation/models/DOCTOR_MODEL.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class DOCTORS_LIST_for_patients extends ConsumerStatefulWidget {
  const DOCTORS_LIST_for_patients({super.key});

  @override
  ConsumerState<DOCTORS_LIST_for_patients> createState() =>
      _DOCTORS_INFO_LISTState();
}

class _DOCTORS_INFO_LISTState extends ConsumerState<DOCTORS_LIST_for_patients> {
  TextEditingController search_controller = TextEditingController();

  bool is_drawer_opened = false;
  String name = '';
  @override
  void dispose() {
    search_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor:
            const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
        drawer: Drawer(
          width: 220,
          backgroundColor: Color.fromARGB(255, 255, 231, 154),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 97, 80, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    onTap: () {
                      Get.to(() => edit_profile_patient(),
                          transition: Transition.downToUp);
                    },
                    title: Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    trailing: Icon(
                      Icons.person,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.yellow,
                thickness: 1,
              ),
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 97, 80, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ABOUT_US_patient(),
                    ));
                  },
                  child: ListTile(
                    title: Text(
                      'About Us',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    trailing: Icon(
                      Icons.help_center_outlined,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.yellow,
                thickness: 1,
              ),
              Divider(
                color: Colors.yellow,
                thickness: 1,
              ),
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 97, 80, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    ref
                        .watch(AUTH_CONTROLLER_provider)
                        .logout(context: context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HOME_DIRECTORY_PAGE(),
                    ));
                  },
                  child: ListTile(
                    title: Text(
                      'LogOut',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    trailing: Icon(
                      Icons.exit_to_app,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.yellow,
                thickness: 0.5,
              ),
              Expanded(
                  child: Container(
                color: Colors.white,
                child: Center(
                  child: Icon(
                    Icons.settings,
                    color: Colors.yellow,
                    size: 150,
                  ),
                ),
              ))
            ],
          ),
        ),
        body: SafeArea(
          child: Form(
            canPop: false,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 10),
                    width: size.width,
                    height: size.height * 0.115,
                    color: blue_f,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  name = search_controller.text;
                                });
                              },
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  label: Text('Search Your Doctor'),
                                  suffixIcon: Container(
                                    height: size.height * 0.02,
                                    padding: EdgeInsets.all(2),
                                    margin: EdgeInsets.only(left: 5, right: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    child: Icon(
                                      Icons.search,
                                      size: 20,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.blue),
                                  )),
                              controller: search_controller,
                            ),
                          ),
                        ),
                        Builder(
                          builder: (context) => IconButton(
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              icon: Icon(
                                Icons.settings,
                                color: yellow,
                              )),
                        ),
                      ],
                    )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.to(() => TOP_RATED_DOCTORS_for_patients(),
                        transition: Transition.zoom);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    margin: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 238, 255, 0)),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 7, bottom: 7),
                          width: size.width * 0.75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromARGB(255, 255, 255, 255)),
                          child: Center(
                            child: Text(
                              'Press to see Top Rated Doctors',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 198, 26, 255),
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 49, 85, 247)),
                          child: Icon(
                            Icons.touch_app_sharp,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
                Container(
                  height: size.height * 0.68,
                  child: FutureBuilder(
                    future: ref
                        .watch(patient_get_info_controller__provider)
                        .GET_DOCTORS_LIST(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        final doctors_list =
                            snapshot.data as List<DOCTOR_MODEL>;
                        return (name == '')
                            ? GridView.builder(
                                itemCount: doctors_list.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 16 / 10,
                                ),
                                itemBuilder: (context, index) {
                                  final doctor = doctors_list[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            DOCTOR_DETAILS_PAGE_for_patient(
                                          doctor_model: doctor,
                                        ),
                                      ));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                        color: black,
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: size.width * 0.13,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Image.network(
                                                doctor.PROFILE_PIC),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  doctor.NAME,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.yellow,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  doctor.JOB_TITLE,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 9),
                                                ),
                                                Text(
                                                  doctor.CLINIC_ADDRESS,
                                                  style: const TextStyle(
                                                      color: Colors.yellow,
                                                      fontSize: 8),
                                                ),
                                                Text(
                                                  'Rating: ${doctor.average_rating.toString()}',
                                                  style: const TextStyle(
                                                      color: Colors.yellow,
                                                      fontSize: 8),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : ListView.builder(
                                itemCount: doctors_list.length,
                                itemBuilder: (context, index) {
                                  final doctor = doctors_list[index];
                                  return (doctor.NAME
                                          .toLowerCase()
                                          .startsWith(name.toLowerCase()))
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  DOCTOR_DETAILS_PAGE_for_patient(
                                                doctor_model: doctor,
                                              ),
                                            ));
                                          },
                                          child: Container(
                                            height: size.height * 0.18,
                                            margin: const EdgeInsets.all(15),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 5),
                                            width: size.width * 0.8,
                                            decoration: BoxDecoration(
                                              color: black,
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: size.width * 0.3,
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8),
                                                    child: Image.network(
                                                        doctor.PROFILE_PIC),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        doctor.NAME,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.yellow,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        doctor.JOB_TITLE,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        doctor.CLINIC_ADDRESS,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.yellow,
                                                            fontSize: 10),
                                                      ),
                                                      Text(
                                                        'Rating: ${doctor.average_rating.toString()}',
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.yellow,
                                                            fontSize: 10),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container();
                                },
                              );
                      } else {
                        return loading_container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
