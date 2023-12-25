// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:trivia_royale_2/controllers/auth_controller.dart';
import 'package:trivia_royale_2/screens/choose_cat_screen.dart';
import 'package:trivia_royale_2/screens/leaderboard.dart';
import 'package:trivia_royale_2/screens/onevone/first.dart';
import 'package:trivia_royale_2/screens/settings_screen.dart';
import 'package:trivia_royale_2/utils/colors.dart';
import 'package:trivia_royale_2/utils/consts.dart';
import 'package:trivia_royale_2/widgets/large_info_button.dart';
import 'package:trivia_royale_2/widgets/top_bar.dart';
import '../widgets/expandable_container.dart';
import '../widgets/stretch_button.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  bool isExpanded = false;
  double offsetX = 0;
  bool canClaimReward = false;
  AuthController authController = Get.find();

  @override
  void initState() {
    super.initState();
    // Fetch user data from API using BuildContext
    checkDailyReward();
  }

  Future<bool> _onBackPressed() async {
    // Custom logic to handle back button press
    if (isExpanded) {
      setState(() {
        isExpanded = !isExpanded;
      });
      return false;
    }
    // Return false to allow default back button behavior, return true to prevent it
    return true;
  }

  Future<void> checkDailyReward() async {
    Timestamp? lastRewardClaimed =
        authController.activeUser.value.lastRewardClaimed;

    if (lastRewardClaimed == null || isEligibleForReward(lastRewardClaimed)) {
      // User is eligible for the daily reward
      // Show the reward screen
      setState(() {
        canClaimReward = true;
      });
    } else {
      // User has already claimed the daily reward
      // Show a message or disable the reward button
      setState(() {
        canClaimReward = false;
      });
    }
  }

  bool isEligibleForReward(Timestamp? lastRewardClaimed) {
    // Check if lastRewardClaimed is null (user has never claimed a reward)
    if (lastRewardClaimed == null) {
      return true;
    }

    // Get the current time
    Timestamp currentTime = Timestamp.now();

    // Calculate the difference in seconds between current time and last reward claimed time
    int differenceInSeconds = currentTime.seconds - lastRewardClaimed.seconds;
    logger.i(differenceInSeconds);

    // Assuming you want to allow claiming the reward once every 24 hours
    int secondsInADay = 24 * 60 * 60;
    logger.i(secondsInADay);

    // Check if enough time has passed since the last reward claimed
    return differenceInSeconds >= secondsInADay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: _onBackPressed,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                ConstStrings.BG_OVERLAY_2,
                fit: BoxFit.fitWidth,
              ),
              Stack(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TopBar(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //Soloplay Mode
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: StretchButton(
                        titleTxt: "1V1",
                        subTxt: "Challange a friend to a match",
                        icon: Icons.play_circle_sharp,
                        onClick: () {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            context: Get.context!,
                            isScrollControlled: true,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: const OneVOneFirst(),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //Group Mode
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: LargeInfoButton(),
                    ),
                    //List of quick trivia runs
                    const Spacer(),
                  ],
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                  bottom: isExpanded ? -50 : 0, // Adjust the value as needed
                  left: 0,
                  right: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeInOut,
                    height:
                        isExpanded ? MediaQuery.of(context).size.height : null,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isExpanded ? 0 : 40),
                        topRight: Radius.circular(isExpanded ? 0 : 40),
                      ),
                    ),
                    child: ExpandedContainer(
                      isExpanded: isExpanded,
                      onSeeAllPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: AnimatedContainer(
                    decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOutCirc,
                    transform:
                        Matrix4.translationValues(!isExpanded ? 0 : 80, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: canClaimReward,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  await authController.claimDailyReward();
                                  checkDailyReward();
                                },
                                child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    minRadius: 1,
                                    maxRadius: 30,
                                    child: Image.asset('assets/coin_ico.png')),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  top: 0,
                  right: -5,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOutCirc,
                    transform:
                        Matrix4.translationValues(!isExpanded ? 0 : 80, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RoundIconButton(
                              icon: Icons.settings,
                              onTap: () {
                                Get.to(() => SettingsScreen());
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RoundIconButton(
                              icon: Icons.leaderboard,
                              onTap: () {
                                Get.to(() => LeaderboardScreen());
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              RoundIconButton(icon: Icons.share, onTap: () {}),
                        ),
                      ],
                    ),
                  ),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 7.0,
            sigmaY: 7.0), // Adjust the sigma values for the blur effect

        child: Container(
          color: AppColors.accentGrey.withOpacity(1),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                onTap();
              },
              child: SizedBox(
                width: 45,
                height: 45,
                child: Icon(
                  icon,
                  color: AppColors.primaryColor, // Icon color
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
