// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class REVIEW_MODEL {
  final String REVIEW_ID;
  final Timestamp REVIEW_TIME_STAMP;
  final String REVIEWER_ID;

  final String REVIEW_TEXT;
  final String REVIEW_TITLE;
  final double? rating;

  final String DOCTOR_ID;

  const REVIEW_MODEL({
    required this.REVIEW_ID,
    required this.REVIEWER_ID,
    required this.REVIEW_TIME_STAMP,
    required this.REVIEW_TEXT,
    required this.rating,
    required this.DOCTOR_ID,
    required this.REVIEW_TITLE,
  });

  Map<String, dynamic> toMap() {
    return {
      'REVIEW_ID': REVIEW_ID,
      'REVIEWER_ID': REVIEWER_ID,
      'REVIEW_TIME_STAMP': REVIEW_TIME_STAMP.millisecondsSinceEpoch,
      'REVIEW_TEXT': REVIEW_TEXT,
      'DOCTOR_ID': DOCTOR_ID,
      'REVIEW_TITLE': REVIEW_TITLE,
      'rating': rating,
    };
  }

  factory REVIEW_MODEL.fromMap(Map<String, dynamic> map) {
    return REVIEW_MODEL(
      REVIEW_ID: map['REVIEW_ID'] ?? '',
      REVIEWER_ID: map['REVIEWER_ID'] ?? '',
      REVIEW_TIME_STAMP:
          Timestamp.fromMillisecondsSinceEpoch(map['REVIEW_TIME_STAMP']),
      REVIEW_TEXT: map['REVIEW_TEXT'] ?? '',
      DOCTOR_ID: map['DOCTOR_ID'] ?? '',
      REVIEW_TITLE: map['REVIEW_TITLE'] ?? '',
      rating: map['rating'] ?? 0.0,
    );
  }
}
