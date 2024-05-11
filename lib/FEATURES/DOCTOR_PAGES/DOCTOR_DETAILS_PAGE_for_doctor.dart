import 'package:doctor_reservation/FEATURES/DOCTOR_PAGES/doctor_reviews_page_for_doctor.dart';
import 'package:doctor_reservation/models/DOCTOR_MODEL.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class DOCTOR_DETAILS_PAGE_for_doctor extends ConsumerStatefulWidget {
  final DOCTOR_MODEL doctor_model;
  const DOCTOR_DETAILS_PAGE_for_doctor({super.key, required this.doctor_model});

  @override
  ConsumerState<DOCTOR_DETAILS_PAGE_for_doctor> createState() =>
      _DOCTOR_DETAILS_PAGE_for_doctorState();
}

class _DOCTOR_DETAILS_PAGE_for_doctorState
    extends ConsumerState<DOCTOR_DETAILS_PAGE_for_doctor> {
  ScrollController? sc;

  @override
  void initState() {
    sc = ScrollController();
    sc!.addListener(() {
      if (sc!.offset == sc!.position.maxScrollExtent) {
        sc!.jumpTo(0);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sc!.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Doctor Details',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          height: size.height * 0.85,
          width: size.width * 0.95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 22, 22, 22),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage:
                            NetworkImage(widget.doctor_model.PROFILE_PIC),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: Column(
                        children: [
                          Icon(
                            Icons.star,
                            size: 38,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(255, 85, 0, 255)),
                            child: Text(
                              (widget.doctor_model.average_rating == 0.0)
                                  ? 'No Ratings Yet'
                                  : widget.doctor_model.average_rating
                                      .toString(),
                              style: TextStyle(color: Colors.yellow),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          (widget.doctor_model.average_rating == 0.0)
                              ? Container()
                              : Text(
                                  'Rating',
                                  style: TextStyle(color: Colors.yellow),
                                ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  widget.doctor_model.NAME,
                  style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.doctor_model.JOB_TITLE,
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
                ),
                Text(
                  widget.doctor_model.OTHER_DETAILS,
                  style: const TextStyle(color: Colors.blue, fontSize: 14),
                ),
                Text(
                  widget.doctor_model.CLINIC_ADDRESS,
                  style: const TextStyle(color: Colors.yellow, fontSize: 17),
                ),
                Text(
                  widget.doctor_model.WORKING_HOURS,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 14),
                ),
                Text(
                  widget.doctor_model.PHONE_NUMBER,
                  style: const TextStyle(color: Colors.blue, fontSize: 17),
                ),
                SizedBox(
                  height: 115,
                ),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Get.to(() => doctor_reviews_page_for_doctor(
                            DOCTOR: widget.doctor_model));
                      },
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          foregroundColor: Colors.yellow,
                          backgroundColor: Colors.blue),
                      child: Text('See Doctor Reviews')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
