import 'package:doctor_reservation/Custom/colors.dart';
import 'package:doctor_reservation/Custom/laoding_container.dart';
import 'package:doctor_reservation/FEATURES/Auth&getting_info/AUTH/AUTH_CONTROLLER/AUTH_CONTROLLER.dart';
import 'package:doctor_reservation/FEATURES/DOCTOR_PAGES/DOCTOR_DETAILS_PAGE_for_doctor.dart';
import 'package:doctor_reservation/FEATURES/DOCTOR_PAGES/DOC_INFO_REPO_controller_reservation/Doc_info__controller.dart';
import 'package:doctor_reservation/FEATURES/DOCTOR_PAGES/DRAWER_PAGES_doctor/ABOUT_US_doctor.dart';
import 'package:doctor_reservation/FEATURES/DOCTOR_PAGES/DRAWER_PAGES_doctor/EDIT_PROFILE_doctor.dart';
import 'package:doctor_reservation/FEATURES/DOCTOR_PAGES/TOP_RATED_DOCTORS.dart';
import 'package:doctor_reservation/FEATURES/HOME_DIRECTORY_PAGE/HOME_DIRECTORY_PAGE.dart';
import 'package:doctor_reservation/models/DOCTOR_MODEL.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class doctors_list_FOR_doctor extends ConsumerStatefulWidget {
  const doctors_list_FOR_doctor({super.key});

  @override
  ConsumerState<doctors_list_FOR_doctor> createState() =>
      _doctors_list_FOR_doctorState();
}

class _doctors_list_FOR_doctorState
    extends ConsumerState<doctors_list_FOR_doctor> {
  TextEditingController search_controller = TextEditingController();

  @override
  void dispose() {
    search_controller.dispose();
    super.dispose();
  }

  bool is_drawer_opened = false;
  String name = '';

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
                      Get.to(() => edit_profile_doc(),
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
                      builder: (context) => ABOUT_US_doctor(),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextField(
                              onChanged: (val) {
                                setState(() {
                                  name = val;
                                });
                              },
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  label: Text('Search Your Doctor'),
                                  labelStyle: TextStyle(fontSize: 18),
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
                    Get.to(() => TOP_RATED_DOCTORS_for_doctors(),
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
                                  color: Color.fromARGB(255, 198, 26, 255)),
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
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: FutureBuilder(
                    future: ref
                        .watch(Doc_info_controller_PROVIDER)
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
                                            DOCTOR_DETAILS_PAGE_for_doctor(
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
                                                  DOCTOR_DETAILS_PAGE_for_doctor(
                                                doctor_model: doctor,
                                              ),
                                            ));
                                          },
                                          child: Container(
                                            height: size.height * 0.18,
                                            margin: const EdgeInsets.all(15),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8),
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
