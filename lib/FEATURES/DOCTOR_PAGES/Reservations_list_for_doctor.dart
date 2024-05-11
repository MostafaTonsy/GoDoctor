import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_reservation/Custom/laoding_container.dart';
import 'package:doctor_reservation/FEATURES/RESERVATION%20repo&controller/reservation_controller.dart';
import 'package:doctor_reservation/models/RESERVATION_MODEL.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class Reservations_list_for_doctor extends ConsumerWidget {
  const Reservations_list_for_doctor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.02,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(
              'My Reservations',
              style: TextStyle(
                fontSize: 22,
                color: Color.fromARGB(255, 227, 248, 42),
              ),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: ref
                .watch(reservation_controller_provider)
                .get_all_reservations_for_doctor(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final reservationsList =
                      snapshot.data as List<RESERVATION_MODEL>;

                  return (reservationsList.isEmpty)
                      ? Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 75,
                              ),
                              LottieBuilder.asset(
                                  'assets/lottie_animations/no_data.json'),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'No Reservations Yet',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 90, 93, 255),
                                    fontSize: 16),
                              )
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: reservationsList.length,
                          itemBuilder: (context, index) {
                            final reservation = reservationsList[index];
                            return Container(
                              margin: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 238, 235, 235),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.yellow)),
                              height: size.height * 0.2,
                              width: size.width * 0.95,
                              child: Card(
                                elevation: 20,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(8),
                                        width: size.width * 0.3,
                                        child: Image.network(reservation
                                            .PATIENT_PROFILE_PIC_URL),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8),
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 68, 0, 255),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Text(
                                              reservation.PATIENT_NAME,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.phone,
                                                color: Color.fromARGB(
                                                    255, 74, 107, 255),
                                              ),
                                              SizedBox(
                                                width: 7,
                                              ),
                                              Text(
                                                reservation
                                                    .PATIENT_PHONE_NUMBER,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.lock_clock,
                                                color: Color.fromARGB(
                                                    255, 74, 107, 255),
                                              ),
                                              SizedBox(
                                                width: 7,
                                              ),
                                              Text(Timestamp.fromDate(
                                                      reservation
                                                          .RESERVATION_TIME)
                                                  .toDate()
                                                  .toString()
                                                  .substring(0, 16)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                } else {
                  return loading_container();
                }
              } else {
                return loading_container();
              }
            },
          ),
        ),
      ],
    );
  }
}
