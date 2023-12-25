import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia_royale_2/screens/home_page_screen.dart';
import 'package:trivia_royale_2/utils/colors.dart';
import 'package:trivia_royale_2/widgets/coin_counter.dart';

import '../modals/player_modal.dart';

class TriviaGameScreen extends StatefulWidget {
  final bool isSingle;
  final List<Player>? players;
  const TriviaGameScreen({super.key, required this.isSingle, this.players});

  @override
  State<TriviaGameScreen> createState() => _TriviaGameScreenState();
}

class _TriviaGameScreenState extends State<TriviaGameScreen> {
  final CountDownController _controller = CountDownController();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  Future<void> startTimer() async {
    await Future.delayed(Duration(milliseconds: 400 * 5));
    _controller.start();
  }

  void onPauseClick() {
    _controller.pause();
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => OverlayDialog(
              onUnPause: () async {
                await Future.delayed(const Duration(milliseconds: 1000));
                _controller.resume();
              },
            )));
  }

  Widget singlePlayer() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [topRow(), Expanded(child: questionSection())],
        ),
      ),
    );
  }

  Widget multiPlayer() {
    return Container();
  }

  Row topRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              onPauseClick();
            },
            icon: const Icon(
              Icons.pause_rounded,
              size: 35,
              color: Colors.white,
            )),
        const CoinCounter(
          coinAmnt: '0',
          isShort: true,
        )
      ],
    );
  }

  Widget questionSection() {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Question #1",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Comics",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                Container(
                  constraints:
                      const BoxConstraints(minHeight: 300, maxHeight: 400),
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 150,
                  decoration: const BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(22.0),
                      child: AutoSizeText(
                        "What is the capital city of Japan?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: -15,
              right: 20,
              child: Center(
                  child: CircularCountDownTimer(
                duration: 15,
                initialDuration: 0,
                controller: _controller,
                width: MediaQuery.of(context).size.width / 8,
                height: MediaQuery.of(context).size.height / 8,
                ringColor: AppColors.primaryLight,
                ringGradient: null,
                fillColor: AppColors.secondaryColor,
                fillGradient: null,
                backgroundColor: Colors.transparent,
                backgroundGradient: null,
                strokeWidth: 5.0,
                strokeCap: StrokeCap.round,
                textStyle: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textFormat: CountdownTextFormat.S,
                isReverse: true,
                isReverseAnimation: true,
                isTimerTextShown: true,
                autoStart: false,
                onStart: () {},
                onComplete: () {},
                onChange: (String timeStamp) {},
                timeFormatterFunction: (defaultFormatterFunction, duration) {
                  if (duration.inSeconds == 0) {
                    return "0";
                  } else {
                    return Function.apply(defaultFormatterFunction, [duration]);
                  }
                },
              )),
            ),
          ]),
          const Spacer(),
          ListView.builder(
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) => DelayedDisplay(
                    slidingCurve: Curves.easeInOut,
                    delay: Duration(
                        milliseconds:
                            400 * index), // Adjust the delay as needed
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0, end: 1).animate(
                        CurvedAnimation(
                          parent: const AlwaysStoppedAnimation<double>(1),
                          curve: const Interval(
                            0.0,
                            1.0,
                            curve: Curves.easeIn,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: 170,
                          height: 50,
                          child: MaterialButton(
                            onPressed: () {},
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            color: AppColors.secondaryColor,
                            child: Text(
                              "Answer ${index.toString()}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: widget.isSingle ? singlePlayer() : multiPlayer(),
    );
  }
}

class OverlayDialog extends StatelessWidget {
  final Function onUnPause;
  const OverlayDialog({super.key, required this.onUnPause});

  Future<bool> onWillPope() async {
    onUnPause();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPope,
      child: Scaffold(
        backgroundColor: AppColors.primaryColor.withOpacity(0.85),
        body: Center(
            child: Container(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "PAUSED",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundIconButton(
                      onTap: () {
                        onUnPause();
                        Get.back();
                      },
                      icon: Icons.play_arrow_sharp),
                  const SizedBox(
                    width: 50,
                  ),
                  RoundIconButton(
                      onTap: () {
                        Get.offAll(() => const HomepageScreen());
                      },
                      icon: Icons.home),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
