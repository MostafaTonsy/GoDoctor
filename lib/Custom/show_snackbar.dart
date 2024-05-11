import 'package:doctor_reservation/Custom/colors.dart';
import 'package:flutter/material.dart';

void ShowSnackbar({required String ERROR, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(child: Text(ERROR)),
    backgroundColor: black,
  ));
}
