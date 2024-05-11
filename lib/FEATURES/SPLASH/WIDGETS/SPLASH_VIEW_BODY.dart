import 'package:doctor_reservation/FEATURES/HOME_DIRECTORY_PAGE/HOME_DIRECTORY_PAGE.dart';
import 'package:flutter/material.dart';

class SPLASH_VIEW_BODY extends StatefulWidget {
  const SPLASH_VIEW_BODY({super.key});

  @override
  State<SPLASH_VIEW_BODY> createState() => _SPLASH_VIEW_BODYState();
}

class _SPLASH_VIEW_BODYState extends State<SPLASH_VIEW_BODY>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? Fading_Animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));

    Fading_Animation =
        Tween<double>(begin: 0.1, end: 1).animate(animationController!);

    animationController!.repeat(reverse: true);

    navigate_to_next_page();
  }

  navigate_to_next_page() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const HOME_DIRECTORY_PAGE()));
      },
    );
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        AnimatedBuilder(
          animation: Fading_Animation!,
          builder: (context, child) => Opacity(
            opacity: Fading_Animation!.value,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.14,
                  ),
                  const Text(
                    'GoDoctor',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.2,
                  ),
                  Container(
                      width: size.width * 0.85,
                      height: size.height * 0.4,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Image.asset('assets/DOCTOR.jpg')),
                  SizedBox(
                    height: size.height * 0.14,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
