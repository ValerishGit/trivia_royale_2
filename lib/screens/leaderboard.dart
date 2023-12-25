import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:trivia_royale_2/controllers/auth_controller.dart';
import 'package:trivia_royale_2/controllers/leaderboard_controller.dart';
import 'package:trivia_royale_2/utils/colors.dart';
import 'package:trivia_royale_2/widgets/custom_loading.dart';

import '../modals/player_modal.dart';

class LeaderboardScreen extends StatelessWidget {
  LeaderboardScreen({super.key});
  LeaderboardController leaderboardController =
      Get.put(LeaderboardController());
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        forceMaterialTransparency: true,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          "Leaderboard",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: AppColors.primaryColor,
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        //Toggle Switch
        const SizedBox(
          height: 20,
        ),
        //toggleSelector(),
        //Leaderboard Table

        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder(
                  future: leaderboardController.getTop100(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CustomLoadingSpinner();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<Player> players = snapshot.data!;
                      return ListView.builder(
                          itemCount: players.length,
                          shrinkWrap: true,
                          itemBuilder: (contex, index) {
                            String medalAsset = "";
                            switch (index) {
                              case 0:
                                medalAsset = 'assets/first_place_medal.png';
                                break;
                              case 1:
                                medalAsset = 'assets/second_place_medal.png';
                                break;
                              case 2:
                                medalAsset = 'assets/third_place_medal.png';
                                break;
                              default:
                                medalAsset = "";
                            }
                            bool currentPlayer = players[index].displayName ==
                                authController.activeUser.value.displayName;
                            return Container(
                              decoration: BoxDecoration(
                                  color: currentPlayer
                                      ? AppColors.primaryColor
                                      : Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      (index + 1).toString(),
                                      style: TextStyle(
                                          height: 2,
                                          color: currentPlayer
                                              ? Colors.white
                                              : null),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: AppColors.accentGrey,
                                      minRadius: 30,
                                      backgroundImage: NetworkImage(
                                          players[index].avatarUrl ?? ""),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          players[index].displayName ??
                                              "{displayName}",
                                          style: TextStyle(
                                              color: currentPlayer
                                                  ? Colors.white
                                                  : null,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${players[index].totalPoints} Points",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: currentPlayer
                                                  ? Colors.white
                                                  : null,
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    Visibility(
                                        visible: medalAsset != "",
                                        child: Image.asset(
                                          medalAsset,
                                          scale: 1.5,
                                        ))
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
          ),
        )
      ]),
    );
  }

  Center toggleSelector() {
    return Center(
      child: ToggleSwitch(
        minWidth: 150,
        activeBgColor: const [AppColors.secondaryColor],
        customTextStyles: const [
          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ],
        initialLabelIndex: 0,
        animate: true,
        animationDuration: 500,
        totalSwitches: 2,
        labels: const ['Weekly', 'All Time'],
        onToggle: (index) {
          print('switched to: $index');
        },
      ),
    );
  }
}
