import 'package:bouncy_widget/bouncy_widget.dart';
import 'package:flutter/material.dart';
import 'package:trivia_royale_2/utils/colors.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
          child: Stack(children: [
        /*  const Positioned(
            bottom: 20,
            left: 25,
            child: Center(
              child: Text(
                "LOADING",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )), */
        Bouncy(
          lift: 50,
          ratio: 0.5,
          pause: 0.5,
          duration: const Duration(seconds: 2),
          child: Image.asset(
            'assets/app_logo_t.png',
            scale: 5.5,
          ),
        ),
      ])),
    );
  }
}
