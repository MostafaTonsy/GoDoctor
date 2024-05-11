import 'package:doctor_reservation/Custom/laoding_container.dart';
import 'package:doctor_reservation/FEATURES/REVIEWS/reviews_controller.dart';
import 'package:doctor_reservation/models/DOCTOR_MODEL.dart';
import 'package:doctor_reservation/models/REVIEW_MODEL.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class doctor_reviews_page_for_doctor extends ConsumerWidget {
  final DOCTOR_MODEL DOCTOR;
  const doctor_reviews_page_for_doctor({super.key, required this.DOCTOR});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.yellow,
        title: Text(
          'Doctor Reviews',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: ref
                .watch(reviews_controller_provider)
                .get_all_reviews_of_specific_doctor(doctor_id: DOCTOR.ID),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final reviews_list = snapshot.data as List<REVIEW_MODEL>;

                if (reviews_list.isEmpty) {
                  return (Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 130),
                      padding: EdgeInsets.all(20),
                      child: LottieBuilder.asset(
                          'assets/lottie_animations/no_data.json'),
                    ),
                  ));
                } else
                  return Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: reviews_list.length,
                        itemBuilder: (context, index) {
                          final review = reviews_list[index];
                          return Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 65, 33, 243),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Text(
                                            review.REVIEW_TITLE,
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    (review.rating != 0)
                                        ? RatingBarIndicator(
                                            rating: review.rating!,
                                            itemBuilder: (context, index) =>
                                                Icon(
                                                    Icons.star_border_outlined),
                                            direction: Axis.horizontal,
                                            itemSize: 20,
                                          )
                                        : Container(),
                                  ],
                                ),
                                Text(review.REVIEW_TEXT),
                                Text(
                                  review.REVIEW_TIME_STAMP
                                      .toDate()
                                      .toString()
                                      .substring(0, 16),
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 2, 13, 160),
                                      fontSize: 9),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
              } else {
                return Center(
                  child: loading_container(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
