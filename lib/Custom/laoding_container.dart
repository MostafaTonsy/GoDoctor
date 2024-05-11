import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class loading_container extends StatelessWidget {
  const loading_container({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            height: 270,
            width: 270,
            child: LottieBuilder.asset(
                'assets/lottie_animations/loading_squares.json')));
  }
}
