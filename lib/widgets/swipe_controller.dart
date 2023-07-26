import 'package:flutter/cupertino.dart';

class InstagramSwipeController {
  InstagramSwipeController(this.pageController);
  late PageController pageController;
  //change page if user taps on the right side of the screen
  void nextPage({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.linear,
  }) {
    pageController.nextPage(duration: duration, curve: curve);
  }
  //change page if user taps on the left side of the screen
  void previousPage({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.linear,
  }) {
    pageController.previousPage(duration: duration, curve: curve);
  }
}
