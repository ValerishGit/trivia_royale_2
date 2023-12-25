import 'package:flutter/material.dart';
import 'package:trivia_royale_2/utils/colors.dart';

class ExpandedContainer extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onSeeAllPressed;

  ExpandedContainer({
    required this.isExpanded,
    required this.onSeeAllPressed,
  });

  bool isCompleted(index) {
    return index % 2 == 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 22),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Quick Trivia",
                    style: TextStyle(
                        color: AppColors.darkBlue,
                        fontWeight: FontWeight.w900,
                        fontSize: 24),
                  ),
                  MaterialButton(
                    onPressed: onSeeAllPressed,
                    child: Text(
                      isExpanded ? 'Hide' : "See All",
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                height:
                    isExpanded ? MediaQuery.of(context).size.height - 100 : 200,
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Stack(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Stack(
                                  children: [
                                    Image.asset(
                                      'assets/rewardbox.png',
                                      scale: 8,
                                    ),
                                    Positioned(
                                      top: 5,
                                      left: 0,
                                      right: 0,
                                      child: Text(
                                        (20 + index).toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                const Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Quiz Name",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Category | 10 Questions",
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black45,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isCompleted(index),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppColors.primaryColor,
                                      )),
                                )
                              ]),
                        ),
                        Positioned(
                            top: 0,
                            right: 15,
                            child: Visibility(
                              visible: !isCompleted(index),
                              child: const RibbonBadge(
                                text: 'Completed',
                                color: AppColors.secondaryColor,
                              ),
                            )),
                      ]);
                    }),
              )
            ],
          ),
        ),
        // ... other content
      ],
    );
  }
}

class RibbonBadge extends StatelessWidget {
  final String text;
  final Color color;

  const RibbonBadge({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: Offset(1, 1),
              blurRadius: 2),
        ],
        color: color,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8.0),
          bottomLeft: Radius.circular(8.0),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
