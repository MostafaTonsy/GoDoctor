import 'package:doctor_reservation/Custom/colors.dart';
import 'package:doctor_reservation/FEATURES/PATIENT_PAGES/Patient_profile.dart';
import 'package:doctor_reservation/FEATURES/PATIENT_PAGES/doctors_list_for_patient.dart';
import 'package:doctor_reservation/FEATURES/PATIENT_PAGES/reservations_list_for_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PATIENT_main_page extends ConsumerStatefulWidget {
  const PATIENT_main_page({super.key});

  @override
  ConsumerState<PATIENT_main_page> createState() => _DOCTORS_INFO_LISTState();
}

class _DOCTORS_INFO_LISTState extends ConsumerState<PATIENT_main_page> {
  int current_page = 0;
  List<Widget> patient_pages = [
    const DOCTORS_LIST_for_patients(),
    const reservations_list_for_patient()
  ];

  final List<Widget> pages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: current_page,
        children: patient_pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current_page,
        onTap: (value) {
          setState(() {
            current_page = value;
          });
        },
        backgroundColor: Color.fromARGB(255, 120, 2, 2),
        selectedItemColor: yellow,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Reservations',
            icon: Icon(Icons.contact_phone_sharp),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PATIENT_PROFILE(),
          ));
        },
        backgroundColor: blue_f,
        foregroundColor: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 4,
            ),
            Icon(
              Icons.person,
              size: 30,
            ),
            Text(
              'Profile',
              style: TextStyle(fontSize: 9),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
