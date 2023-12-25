import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia_royale_2/controllers/auth_controller.dart';
import 'package:trivia_royale_2/screens/splash_screen.dart';
import 'package:trivia_royale_2/utils/colors.dart';

import '../widgets/settings_card.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Settings")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              //Accounts Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "ACCOUNT",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SettingsCard(
                      title: "Edit Profile",
                      onTap: () {
                        print("Edit Profile");
                      },
                      desc: "Change your public profile information"),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "OTHER",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SettingsCard(
                      title: "Settings Title",
                      desc: "Settings Short Description"),
                  const SettingsCard(
                      title: "Settings Title",
                      desc: "Settings Short Description"),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
              logoutButton(() async {
                authController.signOutUser();
              })
              //Other Section
            ],
          ),
        ),
      ),
    );
  }

  Center logoutButton(Function onTap) {
    return Center(
        child: GestureDetector(
      onTap: () {
        onTap();
      },
      child: const Text(
        "LOGOUT",
        style: TextStyle(
            color: AppColors.primaryColor, fontWeight: FontWeight.bold),
      ),
    ));
  }
}
