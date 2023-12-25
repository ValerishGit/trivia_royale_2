import 'package:flutter/material.dart';

import '../utils/consts.dart';

class OverlayBG extends StatelessWidget {
  final Widget child;
  const OverlayBG({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          ConstStrings.BG_OVERLAY,
          fit: BoxFit.fill,
        ),
        child
      ],
    );
  }
}
