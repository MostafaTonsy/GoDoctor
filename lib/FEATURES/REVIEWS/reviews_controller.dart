import 'package:doctor_reservation/FEATURES/REVIEWS/REVIEWS_REPOSITORY.dart';
import 'package:doctor_reservation/models/REVIEW_MODEL.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviews_controller_provider = Provider((ref) {
  final reviewRepoProviderRef = ref.watch(REVIEW_REPOSITORY_PROVIDER);
  return REVIEW_CONTROLLER(
    review_repository: reviewRepoProviderRef,
  );
});

class REVIEW_CONTROLLER {
  final REVIEW_REPOSITORY review_repository;

  const REVIEW_CONTROLLER({
    required this.review_repository,
  });

  Future<void> ADD_REVIEW(
      {required String REVIEW_TEXT,
      required String DOCTOR_ID,
      required double rating,
      required String review_title,
      required BuildContext context}) async {
    await review_repository.ADD_REVIEW(
        rating: rating,
        review_title: review_title,
        REVIEW_TEXT: REVIEW_TEXT,
        DOCTOR_ID: DOCTOR_ID,
        context: context);
  }

  Future<List<REVIEW_MODEL>> get_all_reviews_of_specific_doctor(
      {required String doctor_id}) async {
    return await review_repository.get_all_reviews_of_specific_doctor(
        doctor_id: doctor_id);
  }

  Future<void> delete_review({required review_id}) async {
    await review_repository.delete_review(review_id: review_id);
  }
}
