import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia_royale_2/controllers/auth_controller.dart';
import 'package:trivia_royale_2/modals/player_modal.dart';
import 'package:trivia_royale_2/screens/profile_screen.dart';
import 'package:trivia_royale_2/utils/colors.dart';
import 'package:trivia_royale_2/widgets/coin_counter.dart';

class TopBar extends StatelessWidget {
  TopBar({
    super.key,
  });

  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 200,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ProfileScreen(
                          player: authController.activeUser.value);
                    });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: const BoxConstraints(minWidth: 400),
                    child: AutoSizeText(
                      authController.activeUser.value.displayName ??
                          "{displayName}",
                      minFontSize: 16,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w900),
                    ),
                  ),
                  const Text(
                    "RANK:1,435",
                    style: TextStyle(
                        color: AppColors.accentGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w100),
                  )
                ],
              ),
            ),
          ),
          Obx(
            () => CoinCounter(
              coinAmnt: authController.activeUser.value.totalPoints.toString(),
              isShort: false,
            ),
          )
        ],
      ),
    );
  }
}
