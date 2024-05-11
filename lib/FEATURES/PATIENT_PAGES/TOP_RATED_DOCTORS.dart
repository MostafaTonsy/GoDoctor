import 'package:doctor_reservation/Custom/laoding_container.dart';
import 'package:doctor_reservation/FEATURES/PATIENT_PAGES/DOCTOR_DETAILS_PAGE_for_patient.dart';
import 'package:doctor_reservation/FEATURES/PATIENT_PAGES/patient_user_GET_info-repo_controller/patient_get_info_controller.dart';
import 'package:doctor_reservation/models/DOCTOR_MODEL.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TOP_RATED_DOCTORS_for_patients extends ConsumerStatefulWidget {
  const TOP_RATED_DOCTORS_for_patients({super.key});

  @override
  ConsumerState<TOP_RATED_DOCTORS_for_patients> createState() =>
      _TOP_RATED_DOCTORSState();
}

class _TOP_RATED_DOCTORSState
    extends ConsumerState<TOP_RATED_DOCTORS_for_patients> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(10),
          height: size.height,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 249, 249, 249),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Color.fromARGB(255, 0, 110, 255))),
          child: Column(
            children: [
              Container(
                height: size.height * 0.07,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 181, 1, 236),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    'Top Rated Doctors',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<DOCTOR_MODEL>>(
                  future: ref
                      .watch(patient_get_info_controller__provider)
                      .GET_TOP_RATED_DOCTORS_LIST(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final doctors_list = snapshot.data as List<DOCTOR_MODEL>;
                      return ListView.builder(
                        itemCount: doctors_list.length,
                        itemBuilder: (context, index) {
                          final doctor = doctors_list[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    DOCTOR_DETAILS_PAGE_for_patient(
                                  doctor_model: doctor,
                                ),
                              ));
                            },
                            child: Container(
                              height: (index == 0)
                                  ? size.height * 0.3
                                  : size.height * 0.18,
                              margin: const EdgeInsets.all(15),
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: (index == 0)
                                    ? Color.fromARGB(255, 0, 61, 227)
                                    : Color.fromARGB(255, 0, 0, 0),
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: size.width * 0.3,
                                    margin: EdgeInsets.all(8),
                                    child: Image.network(doctor.PROFILE_PIC),
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
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.yellow,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          doctor.JOB_TITLE,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: (index == 0) ? 15 : 12),
                                        ),
                                        Text(
                                          doctor.CLINIC_ADDRESS,
                                          style: TextStyle(
                                              color: Colors.yellow,
                                              fontSize: (index == 0) ? 15 : 10),
                                        ),
                                        Text(
                                          'Rating: ${doctor.average_rating.toString()}',
                                          style: TextStyle(
                                              color: Colors.yellow,
                                              fontSize: (index == 0) ? 15 : 10),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
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
      ),
    );
  }
}
