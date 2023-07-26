import 'dart:math';
import 'dart:ui';

import 'package:codeway_case/widgets/swipe_controller.dart';
import 'package:flutter/material.dart';

// swipe animation 
class InstagramStorySwipe extends StatefulWidget {
  InstagramStorySwipe({
    required this.children,
    required this.instagramSwipeController,
    super.key,
    this.initialPage = 0,
  }) {
    assert(children.isNotEmpty);
  }
  final List<Widget> children;
  final int initialPage;
  final InstagramSwipeController instagramSwipeController;

  @override
  InstagramStorySwipeState createState() => InstagramStorySwipeState();
}

class InstagramStorySwipeState extends State<InstagramStorySwipe> {
  double currentPageValue = 0;

//  Timer _timer;

  @override
  void initState() {
    super.initState();

    widget.instagramSwipeController.pageController.addListener(() {
      if (!mounted) return;
      setState(() {
        currentPageValue =
            widget.instagramSwipeController.pageController.page ?? 0;
      });
    });
  }
// dispose page controller
  @override
  void dispose() {
    super.dispose();

    widget.instagramSwipeController.pageController.dispose();
  }

// build page view 
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.instagramSwipeController.pageController,
      itemCount: widget.children.length,
      itemBuilder: (context, index) {
        double value;
        if (widget.instagramSwipeController.pageController.position
                .haveDimensions ==
            false) {
          value = index.toDouble();
        } else {
          value = widget.instagramSwipeController.pageController.page ?? 0;
        }
        return _SwipeWidget(
          index: index,
          pageNotifier: value,
          child: widget.children[index],
        );
      },
    );
  }
}

num degToRad(num deg) => deg * (pi / 180.0);

class _SwipeWidget extends StatelessWidget {
  const _SwipeWidget({
    required this.index,
    required this.pageNotifier,
    required this.child,
  });
  final int index;

  final double pageNotifier;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isLeaving = (index - pageNotifier) <= 0;
    final t = index - pageNotifier;
    final rotationY = lerpDouble(0, 90, t);
    final opacity = lerpDouble(0, 1, t.abs())?.clamp(0.0, 1.0);
    final transform = Matrix4.identity();
    transform.setEntry(3, 2, 0.001);
    transform.rotateY((-degToRad(rotationY ?? 0)).toDouble());
    return Transform(
      alignment: isLeaving ? Alignment.centerRight : Alignment.centerLeft,
      transform: transform,
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: Opacity(
              opacity: opacity ?? 1,
              child: const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
