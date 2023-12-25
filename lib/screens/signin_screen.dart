import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:get/get.dart';
import 'package:trivia_royale_2/screens/home_page_screen.dart';
import '../controllers/auth_controller.dart';
import '../utils/colors.dart';
import '../utils/consts.dart';
import '../widgets/custom_loading.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(fit: StackFit.expand, children: [
        Image.asset(
          ConstStrings.BG_OVERLAY_2,
          fit: BoxFit.fitWidth,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  ConstStrings.APP_LOGO,
                  scale: 1.2,
                ),
                Image.asset(
                  ConstStrings.ILLU_1,
                  scale: 1,
                ),
                const Text(
                  "CONNECT WITH",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                socialButtons(),
                const Text(
                  "By signing in you are agreeing to our Terms & Services",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Row socialButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      FlutterSocialButton(
        mini: true,
        onTap: () {
          Get.showOverlay(
              loadingWidget: const CustomLoadingSpinner(),
              asyncFunction: () async {
                bool res = await authController.signIn(0);
                if (res) {
                  Get.offAll(() => const HomepageScreen());
                } else {
                  return;
                }
              });
        },
        buttonType:
            ButtonType.facebook, // Button type for different type buttons
      ),
      const SizedBox(
        width: 20,
      ),
      const Text(
        "OR",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        width: 20,
      ),
      //For google Button
      FlutterSocialButton(
        mini: true,
        onTap: () {
          Get.showOverlay(
              loadingWidget: const CustomLoadingSpinner(),
              asyncFunction: () async {
                bool res = await authController.signIn(1);
                if (res) {
                  Get.offAll(() => const HomepageScreen());
                } else {
                  return;
                }
              });
        },
        buttonType: ButtonType.google, // Button type for different type buttons
      ),
    ]);
  }
}
