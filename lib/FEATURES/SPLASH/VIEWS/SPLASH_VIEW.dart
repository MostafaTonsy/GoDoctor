import 'package:doctor_reservation/FEATURES/SPLASH/WIDGETS/SPLASH_VIEW_BODY.dart';
import 'package:flutter/material.dart';

class SPLASH_VIEW extends StatelessWidget {
  const SPLASH_VIEW({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: SPLASH_VIEW_BODY(),
    );
  }
}
