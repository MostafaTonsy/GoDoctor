import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_reservation/Custom/laoding_container.dart';
import 'package:doctor_reservation/FEATURES/RESERVATION%20repo&controller/reservation_controller.dart';
import 'package:doctor_reservation/models/RESERVATION_MODEL.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class reservations_list_for_patient extends ConsumerStatefulWidget {
  const reservations_list_for_patient({super.key});

  @override
  ConsumerState<reservations_list_for_patient> createState() =>
      _reservations_list_for_patientState();
}

class _reservations_list_for_patientState
    extends ConsumerState<reservations_list_for_patient> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.025,
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
            child: FutureBuilder<List<RESERVATION_MODEL>>(
              future: ref
                  .watch(reservation_controller_provider)
                  .get_all_reservations_for_patient(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final reservationslist =
                      snapshot.data as List<RESERVATION_MODEL>;
                  return (reservationslist == [])
                      ? Container(
                          height: size.height * 0.5,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 300,
                                    width: 250,
                                    child: LottieBuilder.asset(
                                        'assets/lottie_animations/no_data.json')),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'No Reservations Yet',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 3, 197),
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final reservation = snapshot.data![index];
                            return Dismissible(
                              key: ValueKey<RESERVATION_MODEL>(
                                  snapshot.data![index]),
                              direction: DismissDirection.horizontal,
                              background: Container(
                                color: const Color.fromARGB(255, 225, 15, 0),
                                child: Icon(Icons.delete),
                              ),
                              onDismissed: (direction) {
                                ref
                                    .watch(reservation_controller_provider)
                                    .delete_reservation(
                                        RESERVATION_ID:
                                            reservation.RESERVATION_ID);
                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 238, 235, 235),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(255, 225, 247, 32))),
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
                                              .DOCTOR_PROFILE_PIC_URL),
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
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Text(
                                                reservation.DOCTOR_NAME,
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                      .DOCTOR_PHONE_NUMBER,
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
                                            Text(
                                              'Drag Horizontally to Cancel ',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: const Color.fromARGB(
                                                      255, 189, 14, 1)),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
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
    );
  }
}
