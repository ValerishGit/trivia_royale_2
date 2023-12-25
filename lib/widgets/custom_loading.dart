import 'package:bouncy_widget/bouncy_widget.dart';
import 'package:flutter/material.dart';

class CustomLoadingSpinner extends StatelessWidget {
  final bool flipped;
  const CustomLoadingSpinner({super.key, this.flipped = false});

  @override
  Widget build(BuildContext context) {
    return Bouncy(
      lift: 50,
      ratio: 0.5,
      pause: 0.5,
      duration: const Duration(seconds: 2),
      child: Image.asset(
        'assets/app_logo_t.png',
        scale: 5.5,
      ),
    );
  }
}
