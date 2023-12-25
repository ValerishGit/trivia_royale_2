import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:trivia_royale_2/modals/player_modal.dart';
import 'package:trivia_royale_2/screens/settings_screen.dart';
import 'package:trivia_royale_2/utils/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.player});
  final Player player;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Image.network(
                        player.avatarUrl!,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      player.displayName ?? "{displayName}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StatIcon extends StatelessWidget {
  final String statTxt;
  final String statValue;
  const StatIcon({
    super.key,
    required this.statTxt,
    required this.statValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 100,
      decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              statTxt,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 11,
                  color: Colors.white60,
                  fontWeight: FontWeight.w100),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              statValue,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
