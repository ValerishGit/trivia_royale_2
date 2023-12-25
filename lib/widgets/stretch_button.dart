import 'package:flutter/material.dart';

import '../utils/colors.dart';

class StretchButton extends StatefulWidget {
  final String titleTxt;
  final String subTxt;
  final IconData icon;
  final Function onClick;
  final Color btnColor;
  final Color mainColor;
  final bool shouldAnimate;
  const StretchButton(
      {super.key,
      required this.titleTxt,
      required this.subTxt,
      required this.icon,
      required this.onClick,
      this.shouldAnimate = true,
      this.mainColor = AppColors.primaryColor,
      this.btnColor = AppColors.secondaryColor});

  @override
  State<StretchButton> createState() => _StretchButtonState();
}

class _StretchButtonState extends State<StretchButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller = AnimationController(vsync: this);

  @override
  void initState() {
    super.initState();
    if (widget.shouldAnimate) {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 2000),
        value: 0,
        vsync: this,
      )..repeat(reverse: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        double scale = 0.9 - 0.051 * _controller.value;
        return Transform.scale(
          scale: scale,
          child: GestureDetector(
            onTap: () => widget.onClick(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: widget.btnColor,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            widget.titleTxt,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: widget.mainColor),
                          ),
                          Text(widget.subTxt)
                        ],
                      ),
                      Icon(
                        widget.icon,
                        color: widget.mainColor,
                        size: 50,
                      )
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
