import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CoinCounter extends StatelessWidget {
  final String coinAmnt;
  final bool isShort;
  const CoinCounter({super.key, required this.coinAmnt, required this.isShort});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isShort ? 70 : 100,
      height: 31,
      decoration: BoxDecoration(
          color: AppColors.darkColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Image.asset(
            'assets/coin_ico.png',
            scale: 22,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              coinAmnt,
              style: const TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          )
        ]),
      ),
    );
  }
}
