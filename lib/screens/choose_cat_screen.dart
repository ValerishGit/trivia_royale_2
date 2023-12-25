import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_royale_2/screens/trivia_game_screen.dart';
import 'package:trivia_royale_2/utils/colors.dart';
import 'package:trivia_royale_2/widgets/expandable_container.dart';

class CategorySelection extends StatefulWidget {
  const CategorySelection({super.key});

  @override
  State<CategorySelection> createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
  int selectedCat = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: const [],
        title: const Text(
          "Choose a Category",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      body: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Flexible(
                    child: GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 2,
                      shrinkWrap: true,

                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(6, (index) {
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCat = index;
                              });
                            },
                            child: Stack(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.linearToEaseOut,
                                  height: 160,
                                  width: 160,
                                  decoration: BoxDecoration(
                                      color: selectedCat == index
                                          ? AppColors.primaryColor
                                          : Colors.grey.shade100,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.sports_football_rounded,
                                          color: selectedCat == index
                                              ? Colors.white
                                              : AppColors.primaryColor,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          index == 0 ? 'All' : 'Sports',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  color: selectedCat == index
                                                      ? Colors.white
                                                      : AppColors.primaryColor,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: RibbonBadge(
                                    text: 'Best: 50',
                                    color: selectedCat == index
                                        ? AppColors.secondaryColor
                                        : Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: MaterialButton(
                        onPressed: () {
                          Get.offAll(
                              () => const TriviaGameScreen(isSingle: true));
                        },
                        shape: const StadiumBorder(),
                        color: AppColors.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "START",
                            style: TextStyle(
                                fontFamily: GoogleFonts.nunito().fontFamily,
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
