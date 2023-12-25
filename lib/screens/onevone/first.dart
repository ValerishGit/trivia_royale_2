import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trivia_royale_2/utils/colors.dart';

import '../../widgets/stretch_button.dart';

class OneVOneFirst extends StatelessWidget {
  const OneVOneFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              StretchButton(
                titleTxt: 'CREATE A GAME',
                subTxt: 'Create a game and send an invite to a friend',
                icon: Icons.add_circle_outline,
                btnColor: AppColors.primaryColor,
                mainColor: Colors.white,
                shouldAnimate: false,
                onClick: () {},
              ),
              SizedBox(
                height: 20,
              ),
              Text("OR"),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomInputWidget(),
              ),
              StretchButton(
                titleTxt: 'JOIN GAME',
                subTxt: 'Enter the code you got from your friend',
                icon: Icons.add_circle_outline,
                btnColor: AppColors.secondaryColor,
                mainColor: Colors.white,
                shouldAnimate: false,
                onClick: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CustomInputWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey[200], // Set your desired background color
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Enter Game Code Here',
            border: InputBorder.none, // Remove default underline
          ),
        ),
      ),
    );
  }
}
