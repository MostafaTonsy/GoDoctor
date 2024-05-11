import 'package:doctor_reservation/Custom/colors.dart';
import 'package:doctor_reservation/FEATURES/DOCTOR_PAGES/DOCTORS_LIST_for_DOCTORs.dart';
import 'package:doctor_reservation/FEATURES/DOCTOR_PAGES/DOCTOR_PROFILE.dart';
import 'package:doctor_reservation/FEATURES/DOCTOR_PAGES/Reservations_list_for_doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DOCTORS_main_page extends ConsumerStatefulWidget {
  const DOCTORS_main_page({super.key});

  @override
  ConsumerState<DOCTORS_main_page> createState() => _DOCTORS_INFO_LISTState();
}

class _DOCTORS_INFO_LISTState extends ConsumerState<DOCTORS_main_page> {
  int current_page = 0;
  List<Widget> pages = [
    const doctors_list_FOR_doctor(),
    const Reservations_list_for_doctor()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: current_page,
        children: pages,
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
            builder: (context) => DOCTOR_PROFILE(),
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
