import 'package:flutter/material.dart';
import 'package:trivia_royale_2/utils/colors.dart';

class LargeInfoButton extends StatelessWidget {
  const LargeInfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 230,
      decoration: BoxDecoration(
        color: AppColors.accentGrey.withAlpha(88),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //TITLE
              const Text(
                "GROUP PLAY",
                style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),

              //Info Text
              const Text(
                "Play with up to 4 friends\nTake part in challenges\nand see who is faster\nsmarter,stronger",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    height: 1.5,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              //CTA Button
              SizedBox(
                width: 170,
                child: MaterialButton(
                  onPressed: () {},
                  shape: const StadiumBorder(),
                  color: AppColors.accentGrey,
                  child: const Text(
                    "Coming Soon",
                    style: TextStyle(
                        color: AppColors.darkBlue, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
