import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_reservation/Custom/show_snackbar.dart';
import 'package:doctor_reservation/models/REVIEW_MODEL.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final REVIEW_REPOSITORY_PROVIDER = Provider(
  (ref) => REVIEW_REPOSITORY(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance),
);

class REVIEW_REPOSITORY {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  const REVIEW_REPOSITORY({required this.firestore, required this.auth});

  Future<void> ADD_REVIEW(
      {required String REVIEW_TEXT,
      required double rating,
      required String DOCTOR_ID,
      required String review_title,
      required BuildContext context}) async {
    try {
      final time_stamp = Timestamp.fromDate(DateTime.now());

      final review_id = Uuid().v1();
      final review = REVIEW_MODEL(
        REVIEWER_ID: auth.currentUser!.uid,
        rating: rating,
        REVIEW_TITLE: review_title,
        DOCTOR_ID: DOCTOR_ID,
        REVIEW_ID: review_id,
        REVIEW_TEXT: REVIEW_TEXT,
        REVIEW_TIME_STAMP: time_stamp,
      );

      var reviews_snapshot_for_Certain_reviewer = await firestore
          .collection('reviews')
          .where("DOCTOR_ID", isEqualTo: DOCTOR_ID)
          .get();

      if (reviews_snapshot_for_Certain_reviewer.docs.isNotEmpty) {
        for (var doc in reviews_snapshot_for_Certain_reviewer.docs) {
          var REVIEWWW = REVIEW_MODEL.fromMap(doc.data());
          if (REVIEWWW.REVIEWER_ID != auth.currentUser!.uid) {
            await firestore
                .collection('reviews')
                .doc(review_id)
                .set(review.toMap());
          } else {
            ShowSnackbar(
                ERROR: 'Sorry You Can\'t Add a Review For A Doctor Twice',
                context: context);
          }
        }
      }

      if (rating != 0) {
        var reviewsnapshot = await firestore
            .collection('reviews')
            .where("DOCTOR_ID", isEqualTo: DOCTOR_ID)
            .where("rating", isNotEqualTo: 0)
            .get();

        double AVERAGE_RATING = 0;
        double RATING = 0;
        if (reviewsnapshot.docs.isNotEmpty) {
          for (int i = 0; i < reviewsnapshot.docs.length; i++) {
            var review = REVIEW_MODEL.fromMap(reviewsnapshot.docs[i].data());
            RATING = RATING + review.rating!;
          }

          AVERAGE_RATING = RATING / reviewsnapshot.docs.length;
        }

        await firestore
            .collection('doctors')
            .doc(DOCTOR_ID)
            .update({"average_rating": AVERAGE_RATING});
      }
    } catch (e) {
      ShowSnackbar(ERROR: e.toString(), context: context);
    }
  }

  Future<List<REVIEW_MODEL>> get_all_reviews_of_specific_doctor(
      {required String doctor_id}) async {
    final reviewsSnapshots = await firestore
        .collection('reviews')
        .where('DOCTOR_ID', isEqualTo: doctor_id)
        .get();

    final List<REVIEW_MODEL> reviews_list = [];

    for (var doc in reviewsSnapshots.docs) {
      final review = REVIEW_MODEL.fromMap(doc.data());
      reviews_list.add(review);
    }
    return reviews_list;
  }

  Future<void> delete_review({required review_id}) async {
    await firestore.collection('reviews').doc(review_id).delete();
  }
}
