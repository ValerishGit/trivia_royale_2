import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:trivia_royale_2/controllers/auth_controller.dart';
import 'package:trivia_royale_2/screens/home_page_screen.dart';
import 'package:trivia_royale_2/screens/profile_screen.dart';
import 'package:trivia_royale_2/screens/signin_screen.dart';
import 'package:trivia_royale_2/utils/colors.dart';
import 'package:trivia_royale_2/utils/consts.dart';
import 'package:trivia_royale_2/widgets/overlay_bg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AuthController authController = Get.put(AuthController());
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () async {
      if (await authController.isLoggedIn()) {
        logger
            .i("User is Signed In ${FirebaseAuth.instance.currentUser?.email}");
        // signed in
        Get.offAll(() => HomepageScreen());
      } else {
        // signed out
        logger.i("User is Signed Out");
        Get.offAll(() => SignInScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: OverlayBG(
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: _controller,
              curve: Curves.bounceOut, // Adjust the curve as needed
            ).drive(Tween(begin: 0.1, end: 1.0)),
            child: Image.asset(
              ConstStrings.APP_LOGO,
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
