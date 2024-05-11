import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ABOUT_US_doctor extends StatelessWidget {
  const ABOUT_US_doctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.yellow,
        title: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
          child: Text(
            'About Us',
            style: TextStyle(
                fontSize: 18, color: const Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 255, 247, 171),
          ),
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Icon(
                  Icons.call,
                  color: Colors.yellow,
                  size: 50,
                ),
              ),
              Text(
                'For More Information',
                style: TextStyle(color: Color.fromARGB(255, 4, 0, 255)),
              ),
              Text(
                'Please Call ',
                style: TextStyle(color: Color.fromARGB(255, 17, 0, 255)),
              ),
              Text(
                '01009758663',
                style: TextStyle(color: Color.fromARGB(255, 163, 0, 163)),
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  child: LottieBuilder.asset(
                      'assets/lottie_animations/info.json')),
            ],
          )),
        ),
      ),
    );
  }
}
